import 'package:json_annotation/json_annotation.dart';

import 'criterio.dart';
part 'vaga.g.dart';

@JsonSerializable()
class Vaga {
  int? vagaId;
  String email;
  String titulo;
  String cargo;
  String descricao;
  DateTime? dataCriacao;
  int status;
  List<Criterio> criterios;
  // List<String>? skillNames;
  // List<int>? pesos;

  Vaga({
    required this.email,
    this.vagaId,
    required this.titulo,
    required this.cargo,
    required this.status,
    required this.descricao,
    this.dataCriacao,
    required this.criterios,
  });

  factory Vaga.fromJson(Map<String, dynamic> json) => _$VagaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VagaToJson(this);
}
