import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/components/card.home.widget.dart';

import '../services/app.store.dart';

class HomeCandidato extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const HomeCandidato({Key? key, required this.dioService, required this.appStore}) : super(key: key);

  @override
  State<HomeCandidato> createState() => _HomeCandidatoState();
}

class _HomeCandidatoState extends State<HomeCandidato> {
  var response;
  Usuario? usuario;
  List<Vaga> filteredList = [];
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    usuario = widget.appStore.usuario;
    if (filteredList.length == 0) {
      filteredList = widget.appStore.vagas!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[200],
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    List<Vaga> newList = [];
                    for (var vaga in widget.appStore.vagas!) {
                      if (vaga.cargo.contains(value)) {
                        newList.add(vaga);
                      }
                    }
                    setState(() {
                      filteredList = newList;
                    });
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    prefixIconColor: Colors.white,
                    suffixIconColor: Colors.white,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    labelText: "Search",
                    hintText: "",
                    labelStyle: TextStyle(color: Colors.white),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              widget.appStore.isVagasLoaded
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            widget.appStore.vagaSelecionada = filteredList[index];
                            Modular.to.pushNamed('/detalhes-vaga');
                          },
                          child: CardHomeWidget(
                            vaga: filteredList[index],
                          ),
                        );
                      }))
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        );
      }),
    );
  }
}
