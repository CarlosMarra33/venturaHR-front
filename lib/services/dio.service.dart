import 'dart:async';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'app.store.dart';

class DioService {
  final Dio dio;
  final AppStore identityStore;

  String? get accessToken => identityStore.usuario!.token;

  DioService(this.dio, this.identityStore) {
    if (dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
  }

  void _addAuthorizationHeader(Map<String, String> headers) {
    if (accessToken != null) {
      headers['Authorization'] = accessToken!;
    }
  }

  void _addCommonHeaders(Map<String, String> headers, bool useCache) {
    headers['Connection'] = "keep-alive";
    if (useCache == false) {
      headers['Cache-Control'] = 'no-cache';
    }
  }

  Future<Response> delete<T>(String path,
      {CancelToken? cancelToken,
      String? contentType,
      List<String>? cookies,
      bool useCache = true}) async {
    cancelToken = cancelToken ?? CancelToken();

    // var headers = {Headers.contentTypeHeader: 'application/json'};
    var headers = <String, String>{'Authorization': accessToken!};
    if (cookies != null) {
      var cookiesConcat =
          cookies.map((e) => e.substring(0, e.indexOf(';'))).join(';');
      headers['cookie'] = cookiesConcat;
    }

    _addAuthorizationHeader(headers);
    _addCommonHeaders(headers, useCache);

    try {
      return await dio
          .delete<T>(path,
              options: Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status != null && status >= 200 && status <= 302;
                },
              ),
              cancelToken: cancelToken)
          .timeout(const Duration(seconds: 30));
    } on TimeoutException catch (error) {
      cancelToken.cancel();
      throw DioError(error: error, requestOptions: RequestOptions(path: path));
    }
  }

  Future<Response<T>> get<T>(String path,
      {CancelToken? cancelToken,
      List<String>? cookies,
      bool useCache = true}) async {
    cancelToken = cancelToken ?? CancelToken();

    var headers = <String, String>{'Authorization': accessToken!};
    // var headers = {
    //   Headers.contentTypeHeader: 'application/json',
    //   //'host': 'contadigital-identidade-tst.icatuseguros.com.br',
    // };
    _addAuthorizationHeader(headers);
    _addCommonHeaders(headers, useCache);

    return await dio
        .get<T>(path,
            options: Options(
              headers: headers,
              followRedirects: false,
              extra: {'withCredentials': cookies != null && cookies.isNotEmpty},
              validateStatus: (status) {
                return status != null && status >= 200 && status <= 302;
              },
            ),
            cancelToken: cancelToken)
        .timeout(const Duration(seconds: 30));
  }

  Future<Response<T>> post<T>(String path, dynamic body,
      {bool useCookies = false,
      String? contentType,
      List<String>? cookies,
      CancelToken? cancelToken,
      bool useCache = true}) async {
    cancelToken = cancelToken ?? CancelToken();

    var headers = <String, String>{'Authorization': accessToken!};
    if (body is! FormData) {
      headers[Headers.contentTypeHeader] = contentType ?? 'application/json';
      headers[Headers.acceptHeader] = '*/*';
    }

    if (cookies != null) {
      var cookiesConcat =
          cookies.map((e) => e.substring(0, e.indexOf(';'))).join(';');
      headers['cookie'] = cookiesConcat;
    }

    _addAuthorizationHeader(headers);
    _addCommonHeaders(headers, useCache);

    return await dio
        .post<T>(path,
            data: body,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status != null && status >= 200 && status <= 302;
              },
            ),
            cancelToken: cancelToken)
        .timeout(const Duration(seconds: 30));
  }

  Future<Response> put<T>(String path, dynamic body,
      {bool useCookies = false,
      String? contentType,
      List<String>? cookies,
      CancelToken? cancelToken,
      bool useCache = true}) async {
    cancelToken = cancelToken ?? CancelToken();
    var headers = <String, String>{};
    if (body is! FormData) {
      headers[Headers.contentTypeHeader] = contentType ?? 'application/json';
      headers[Headers.acceptHeader] = '*/*';
    }

    if (cookies != null) {
      var cookiesConcat =
          cookies.map((e) => e.substring(0, e.indexOf(';'))).join(';');
      headers['cookie'] = cookiesConcat;
    }

    _addAuthorizationHeader(headers);
    _addCommonHeaders(headers, useCache);

    return await dio
        .put<T>(path,
            data: body,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status != null && status >= 200 && status <= 302;
              },
            ),
            cancelToken: cancelToken)
        .timeout(const Duration(seconds: 30));
  }
}
