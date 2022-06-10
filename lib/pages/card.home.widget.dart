import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:dio/dio.dart';
import 'package:ventura_hr_front/models/usuario.dart';
import 'package:ventura_hr_front/models/vaga.dart';

class CardHomeWidget extends StatelessWidget {
  final Vaga vaga;

  CardHomeWidget({Key? key, required this.vaga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO rota para a pagina details
      },
      child: Container(
        // height: 300,
        width: 300,
        child: Card(
          color: Colors.white70,
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vaga.titulo,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'Cargo: ' + vaga.cargo,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Descrição: ' + vaga.destricao,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
