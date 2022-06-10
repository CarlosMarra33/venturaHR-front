import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/pages/card.home.widget.dart';

import '../services/app.store.dart';

class HomeCandidato extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const HomeCandidato(
      {Key? key, required this.dioService, required this.appStore})
      : super(key: key);

  @override
  State<HomeCandidato> createState() => _HomeCandidatoState();
}

class _HomeCandidatoState extends State<HomeCandidato> {
  var response;
  Usuario? usuario;
  List<Vaga> vagasList = [];
  @override
  void initState() {
    usuario = widget.appStore.usuario;
    response = widget.dioService
        .get('http://192.168.0.48:8081/candidato/home?email=' + usuario!.email!);
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: const Icon(Icons.add),
      //   label: const Text(
      //     'Criar Vaga',
      //     style: TextStyle(
      //       letterSpacing: 0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }
}
