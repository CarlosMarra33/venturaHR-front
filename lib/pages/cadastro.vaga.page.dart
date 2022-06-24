import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/components/card.home.widget.dart';

import '../models/criterio.dart';
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
  List<Criterio> criterios = [];
  List<TextEditingController> controllersList = [];
  List<TextEditingController> pesosControllers = [];
  int valorEscolhido = 1;
  List<int> criteriosPeso = [];
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
              getCriterios(),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      criteriosPeso.add(1);
                      controllersList.add(TextEditingController());
                      criterios.add(Criterio(criterios: '', pesos: 1));
                    });
                  },
                  child: const Text('Adicionar critério')),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    fazerRequisicao();
                  },
                  child: const Text('Criar Vaga'))
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownPeso(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Peso ' + (index + 1).toString()),
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
              criteriosPeso.replaceRange(index, index + 1, [novoItemSelecionado]);
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

  Widget getCriterios() {
    List<Widget> widgets = [];
    var count = 0;

    for (var criterio in criterios) {
      widgets.add(Column(
        children: [
          inputField(
            controller: controllersList[count],
            labelText: 'critério ' + (count + 1).toString(),
            title: '',
          ),
          dropdownPeso(count),
        ],
      ));
      count += 1;
    }

    return Column(
      children: widgets,
    );
  }

  Widget inputField({required TextEditingController controller, required String labelText, required String title}) {
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

  void fazerRequisicao() async {
    List<Criterio> listaCriterios = [];

    for (var index = 0; index < controllersList.length; index++) {
      listaCriterios.add(Criterio(criterios: controllersList[index].text, pesos: criteriosPeso[index]));
    }

    var vaga = Vaga(
      cargo: cargoController.text,
      criterios: listaCriterios,
      descricao: descricaoController.text,
      email: widget.appStore.usuario!.email!,
      status: 1,
      titulo: tituloController.text,
    );

    await widget.dioService.post('http://192.168.0.48:8081/empresa/criacao', vaga.toJson());
    getAllVagas(usuario: widget.appStore.usuario!);
  }

  void getAllVagas({
    required Usuario usuario,
  }) async {
    List<Vaga> vagasRespose = [];
    Response<List<dynamic>> response;
    response = await widget.dioService.get('http://192.168.0.48:8081/empresa/home?email=' + usuario.email!);

    debugPrint('response Data teste: ' + response.data!.length.toString());
    for (var vaga in response.data!) {
      vagasRespose.add(Vaga.fromJson(vaga as Map<String, dynamic>));
      debugPrint('vaga.:  ' + Vaga.fromJson(vaga as Map<String, dynamic>).toString());
    }
    ;
    response.data!.map((vaga) {});

    widget.appStore.vagas = vagasRespose;
    widget.appStore.isVagasLoaded = true;
    Modular.to.pushNamed('/empresa-home');
  }
}
