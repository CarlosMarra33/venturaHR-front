import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/components/card.home.widget.dart';

import '../services/app.store.dart';

class CadastroVaga extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const CadastroVaga({
    Key? key,
    required this.dioService,
    required this.appStore,
  }) : super(key: key);

  @override
  State<CadastroVaga> createState() => _CadastroVagaState();
}

class _CadastroVagaState extends State<CadastroVaga> {
  List<int> _pesos = [1, 2, 3, 4, 5];
  int valorEscolhido = 1;
  var criteriosPeso = [];
  TextEditingController tituloController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController crit1 = TextEditingController();
  TextEditingController crit2 = TextEditingController();
  TextEditingController crit3 = TextEditingController();
  TextEditingController crit4 = TextEditingController();
  TextEditingController crit5 = TextEditingController();
  var _itemSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('VenturaHR'))),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
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
              dropdownPeso(1),
              inputField(
                controller: crit2,
                labelText: 'critério 2',
                title: '',
              ),
              dropdownPeso(2),
              inputField(
                controller: crit3,
                labelText: 'critério 3',
                title: '',
              ),
              dropdownPeso(3),
              inputField(
                controller: crit4,
                labelText: 'critério 4',
                title: '',
              ),
              dropdownPeso(4),
              inputField(
                controller: crit5,
                labelText: 'critério 5',
                title: '',
              ),
              dropdownPeso(5),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Criar Vaga'))
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownPeso(int qtd) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Peso ' + qtd.toString()),
        const SizedBox(
          width: 50,
        ),
        DropdownButton<int>(
            items: _pesos.map((int dropDownStringItem) {
              return DropdownMenuItem<int>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem.toString()),
              );
            }).toList(),
            onChanged: (novoItemSelecionado) {
              _dropDownItemSelected(novoItemSelecionado!);
              criteriosPeso.add(valorEscolhido);
            },
            value: valorEscolhido),
      ]),
    );
  }

  void _dropDownItemSelected(int novoItem) {
    setState(() {
      valorEscolhido = novoItem;
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
