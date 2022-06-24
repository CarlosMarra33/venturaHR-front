import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/models/usuario.dart';

import '../models/vaga.dart';
import '../services/app.store.dart';
import '../services/dio.service.dart';

class LoginPage extends StatefulWidget {
  final AppStore appStore;
  final DioService dioService;

  const LoginPage({Key? key, required this.appStore, required this.dioService})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('VenturaHR'))),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your Email',
                    ),
                  ),
                ),
                Text('Senha'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: senhaController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Entre com sua senha',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Usuario user = Usuario(
                        email: emailController.text,
                        password: senhaController.text,
                      );
                      try {
                        var usuario = user.toJson();
                        // var headers = <String, String>{
                        //   'Authorization': token,
                        // };
                        var response = await Dio().post(
                            'http://192.168.0.48:8081/login',
                            data: usuario);
                        debugPrint("teste aqui: " + response.data.toString());

                        Usuario usuarioLogado = Usuario.fromJson(response.data);

                        // print(response);
                        widget.appStore.usuario = usuarioLogado;
                        if (usuarioLogado.tipoConta == 2) {
                          getAllVagasEmpresa(usuario: usuarioLogado);
                        } else if (usuarioLogado.tipoConta == 1) {
                          getAllVagasCandidato(usuario: usuarioLogado);
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Text('Login')),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Modular.to.pushNamed('/cadastro');
                    },
                    child: const Text('Cadastro'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAllVagasEmpresa({
    required Usuario usuario,
  }) async {
    List<Vaga> vagasRespose = [];
    Response<List<dynamic>> response;
    response = await widget.dioService
        .get('http://192.168.0.48:8081/empresa/home?email=' + usuario.email!);

    debugPrint('response Data teste: ' + response.data!.length.toString());
    for (var vaga in response.data!) {
      vagasRespose.add(Vaga.fromJson(vaga as Map<String, dynamic>));
      debugPrint(
          'vaga.:  ' + Vaga.fromJson(vaga as Map<String, dynamic>).toString());
    }
    ;
    response.data!.map((vaga) {});

    widget.appStore.vagas = vagasRespose;
    widget.appStore.isVagasLoaded = true;
    Modular.to.pushNamed('/empresa-home');
  }

  void getAllVagasCandidato({
    required Usuario usuario,
  }) async {
    List<Vaga> vagasRespose = [];
    Response<List<dynamic>> response;
    response = await widget.dioService
        .get('http://192.168.0.48:8081/candidato/home?email=' + usuario.email!);

    debugPrint('response Data teste: ' + response.data!.length.toString());
    for (var vaga in response.data!) {
      vagasRespose.add(Vaga.fromJson(vaga as Map<String, dynamic>));
      debugPrint(
          'vaga.:  ' + Vaga.fromJson(vaga as Map<String, dynamic>).toString());
    }

    widget.appStore.vagas = vagasRespose;
    widget.appStore.isVagasLoaded = true;
    Modular.to.pushNamed('candidato-home');
  }
}
