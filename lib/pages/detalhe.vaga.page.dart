import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/models/criterio.dart';
import 'package:ventura_hr_front/models/resposta-vaga.dart';
import 'package:ventura_hr_front/models/vaga.dart';
import 'package:ventura_hr_front/services/app.store.dart';
import 'package:ventura_hr_front/services/dio.service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetalhesVagaPage extends StatefulWidget {
  final DioService dioService;
  final AppStore appStore;

  const DetalhesVagaPage(
      {Key? key, required this.dioService, required this.appStore})
      : super(key: key);

  @override
  State<DetalhesVagaPage> createState() => _DetalhesVagaState();
}

class _DetalhesVagaState extends State<DetalhesVagaPage> {
  Vaga? vaga;
  List<String> criteriosNomes = [];
  List<int> pesos = [];

  @override
  void initState() {
    vaga = widget.appStore.vagaSelecionada!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[200],
      appBar: AppBar(
        title: Center(child: Text('VenturaHR')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vaga!.cargo,
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Email: " + vaga!.email,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Descrição da vaga: " + vaga!.descricao,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Criado em:   " +
                        vaga!.dataCriacao!.day.toString() +
                        "/" +
                        vaga!.dataCriacao!.month.toString() +
                        "/" +
                        vaga!.dataCriacao!.year.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Critérios",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[100],
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.appStore.usuario!.email != vaga!.email
                      ? getCriterios()
                      : getCriteriosEmpresa(),
                ),
              ),
            ),
            Spacer(),
            widget.appStore.usuario!.email != vaga!.email
                ? Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        List<Criterio> crits = [];

                        for (var item = 0;
                            item < criteriosNomes.length;
                            item++) {
                          crits.add(Criterio(
                              criterios: criteriosNomes[item],
                              pesos: pesos[item]));
                        }
                        criarRespostaVaga(
                          resposta: RespostaVaga(
                            nomeCandidato: widget.appStore.usuario!.nome,
                            emailCandidato: widget.appStore.usuario!.email,
                            vagaId: widget.appStore.vagaSelecionada!.vagaId,
                            criterios: crits,
                          ),
                        );
                      },
                      child: Text(
                        'Candidatar-se',
                        style: TextStyle(
                          color: Colors.blueAccent[200],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Background color
                      ),
                    ),
                  )
                : Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Cancelar Vaga",
                              style: TextStyle(
                                color: Colors.blueAccent[200],
                              )),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Encerrar Vaga",
                              style: TextStyle(
                                color: Colors.blueAccent[200],
                              )),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getCriteriosEmpresa() {
    List<Widget> criterios = [];
    var count = 0;
    for (var criterio in widget.appStore.vagaSelecionada!.criterios) {
      criterios.add(Text(criterio.criterios!));
    }
    return SingleChildScrollView(child: Column(children: criterios));
  }

  Widget getCriterios() {
    List<Widget> criterios = [];
    var count = 0;

    for (var criterio in widget.appStore.vagaSelecionada!.criterios) {
      criterios.add(Text(criterio.criterios!));
      criteriosNomes.add(criterio.criterios!);
      pesos.add(0);
      criterios.add(RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.school,
          color: Colors.blue[900],
        ),
        onRatingUpdate: (rating) {
          pesos.replaceRange(count - 1, count, [rating.toInt()]);
        },
      ));
      if (count != widget.appStore.vagaSelecionada!.criterios.length - 1)
        criterios.add(Divider(
          color: Colors.grey[600],
          thickness: 1,
        ));
      count++;
    }

    return SingleChildScrollView(child: Column(children: criterios));
  }

  void criarRespostaVaga({
    required RespostaVaga resposta,
  }) async {
    await widget.dioService.post(
        'http://192.168.0.48:8081/candidato/responderVaga', resposta.toJson());
    Modular.to.pushNamed('candidato-home');
  }
}
