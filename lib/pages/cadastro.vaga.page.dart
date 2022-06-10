import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/pages/card.home.widget.dart';

import '../services/app.store.dart';

class CadastroVaga extends StatefulWidget {
  // final DioService dioService;
  // final AppStore appStore;

  const CadastroVaga({
    Key? key,
    // required this.dioService,
    // required this.appStore,
  }) : super(key: key);

  @override
  State<CadastroVaga> createState() => _CadastroVagaState();
}

class _CadastroVagaState extends State<CadastroVaga> {
  var _pesos = [1, 2, 3, 4, 5];
  List<TextEditingController> criteriosControllers = [];
  int valorEscolhido = 0;
  var criterios = [];
  TextEditingController tituloController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController crit1 = TextEditingController();
  var _itemSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('VenturaHR'))),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 40,
              // ),
              inputField(
                controller: tituloController,
                labelText: 'Título',
                title: 'Título',
              ),
              const SizedBox(
                height: 10,
              ),
              inputField(
                controller: cargoController,
                labelText: 'Cargo',
                title: 'Cargo',
              ),
              const SizedBox(
                height: 10,
              ),
              inputField(
                controller: descricaoController,
                labelText: 'Descrição',
                title: 'Descrição',
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Critérios'),
              const SizedBox(
                height: 10,
              ),
              inputField(
                controller: crit1,
                labelText: 'critério 1',
                title: '',
              ),
              dropdownPeso(position: 0)
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownPeso({
    required int position,
  }) {
    return DropdownButton<int>(
        items: _pesos.map((int dropDownStringItem) {
          return DropdownMenuItem<int>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem.toString()),
          );
        }).toList(),
        onChanged: (novoItemSelecionado) {
          _dropDownItemSelected(novoItemSelecionado!, position);
          setState(() {
            this._pesos[position] = novoItemSelecionado;
          });
        },
        value: _pesos[position]);
  }

  void _dropDownItemSelected(int novoItem, int position) {
    setState(() {
      this._pesos[position] = novoItem;
    });
  }

  Widget inputField(
      {required TextEditingController controller,
      required String labelText,
      required String title}) {
    return Column(
      children: [
        Text(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: labelText,
            ),
          ),
        ),
      ],
    );
  }
}
