import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/components/card.home.widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/criterio.dart';
import '../services/app.store.dart';

class HomeEmpresa extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const HomeEmpresa({Key? key, required this.dioService, required this.appStore}) : super(key: key);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Center(child: Text('VenturaHR')),
          leading: InkWell(
              onTap: () {
                Modular.to.navigate("/");
              },
              child: Icon(Icons.exit_to_app))),
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              widget.appStore.isVagasLoaded
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.appStore.vagas!.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            widget.appStore.vagaSelecionada = widget.appStore.vagas![index];
                            Modular.to.pushNamed('/detalhes-vaga');
                          },
                          child: CardHomeWidget(
                            vaga: widget.appStore.vagas![index],
                          ),
                        );
                      }))
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Modular.to.pushNamed('/cadastro-vaga');
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Cadastrar Vaga',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
