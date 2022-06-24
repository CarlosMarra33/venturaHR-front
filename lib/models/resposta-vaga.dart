import 'package:json_annotation/json_annotation.dart';
import 'package:ventura_hr_front/models/criterio.dart';
part 'resposta-vaga.g.dart';

@JsonSerializable()
class RespostaVaga {
  String? nomeCandidato;
  String? emailCandidato;
  int? vagaId;
  List<Criterio>? criterios;

  RespostaVaga(
      {required this.nomeCandidato, required this.emailCandidato, required this.vagaId, required this.criterios});

  factory RespostaVaga.fromJson(Map<String, dynamic> json) => _$RespostaVagaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RespostaVagaToJson(this);
}
