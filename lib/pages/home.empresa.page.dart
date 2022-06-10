import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/pages/card.home.widget.dart';

import '../services/app.store.dart';

class HomeEmpresa extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const HomeEmpresa(
      {Key? key, required this.dioService, required this.appStore})
      : super(key: key);

  @override
  State<HomeEmpresa> createState() => _HomeEmpresaState();
}

class _HomeEmpresaState extends State<HomeEmpresa> {
  var response;
  Usuario? usuario;
  List<Vaga> vagasList = [];
  @override
  void initState() {
    usuario = widget.appStore.usuario;
    response = widget.dioService
        .get('http://192.168.0.48:8081/empresa/home?email=' + usuario!.email!);
    List<dynamic> vagasmap = jsonDecode(response);
    vagasmap.map((vaga) => vagasList.add(Vaga.fromJson(vaga)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('VenturaHR'))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(itemBuilder: ((context, index) {
              return CardHomeWidget(vaga: vagasList[index]);
            }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text(
          'Criar Vaga',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
