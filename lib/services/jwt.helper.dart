import 'dart:convert';

abstract class JwtHelper {
  static Map<String, dynamic> parseJwt(String token) {
    assert(token.isNotEmpty, "Token string is empty.");
    final parts = token.split('.');
    assert(parts.length == 3, "Not a JWT.");

    final payload = base64Url.normalize(parts[1]);
    final payloadMap = json.decode(utf8.decode(base64Url.decode(payload)));

    assert(payloadMap is Map<String, dynamic>, "Not a JWT.");
    return payloadMap as Map<String, dynamic>;
  }
}