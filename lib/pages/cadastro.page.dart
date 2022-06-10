import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:dio/dio.dart';
import 'package:ventura_hr_front/models/usuario.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  int tipoContaVal = 0;
  bool ehEmpresa = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('VenturaHR'))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Candidato',
                    style: TextStyle(
                        color: ehEmpresa ? Colors.grey : Colors.black),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FlutterSwitch(
                    inactiveColor: Colors.blue,
                    width: 45.0,
                    height: 25.0,
                    valueFontSize: 25.0,
                    toggleSize: 15.0,
                    value: ehEmpresa,
                    borderRadius: 30.0,
                    padding: 3.0,
                    onToggle: (val) {
                      setState(() {
                        ehEmpresa = val;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Empresa',
                    style: TextStyle(
                        color: ehEmpresa ? Colors.black : Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ehEmpresa ? showEmpresaForm : showCandidatoForm,
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (ehEmpresa) {
                      tipoContaVal = 2;
                    } else {
                      tipoContaVal = 1;
                    }
                    Usuario user = Usuario(
                      cnpj: cnpjController.text,
                      cpf: cpfController.text,
                      nome: nomeController.text,
                      email: emailController.text,
                      password: senhaController.text,
                      tipoConta: tipoContaVal,
                    );
                    try {
                      var usuario = user.toJson();
                      var response = Dio().post(
                          'http://192.168.0.48:8081/cadastro',
                          data: user.toJson());
                      // print(response);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: const Text('cadastrar')),
              const SizedBox(
                height: 15,
              ),
              // TextButton(onPressed: () {}, child: const Text('Cadastro'))
            ],
          ),
        ),
      ),
    );
  }

  Widget get showCandidatoForm {
    return Column(children: [
      inputField(
          controller: emailController,
          labelText: 'Entre com o Email',
          title: 'Email'),
      inputField(
          controller: nomeController,
          labelText: 'Entre com o Nome',
          title: 'Nome'),
      inputField(
          controller: senhaController,
          labelText: 'Entre com a Senha',
          title: 'senha'),
      inputField(
          controller: cpfController,
          labelText: 'Entre com o CPF',
          title: 'CPF'),
    ]);
  }

  Widget get showEmpresaForm {
    return Column(children: [
      inputField(
          controller: emailController,
          labelText: 'Entre com o Email',
          title: 'Email'),
      inputField(
          controller: nomeController,
          labelText: 'Entre com o Nome',
          title: 'Nome'),
      inputField(
          controller: senhaController,
          labelText: 'Entre com a Senha',
          title: 'senha'),
      inputField(
          controller: cnpjController,
          labelText: 'Entre com o CNPJ',
          title: 'CNPJ'),
    ]);
  }

  Widget inputField(
      {required TextEditingController controller,
      required String labelText,
      required String title}) {
    return Column(
      children: [
        Text(title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
