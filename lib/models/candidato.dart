import 'package:json_annotation/json_annotation.dart';
part 'candidato.g.dart';

@JsonSerializable()
class Candidato {
  String? nome;
  String? email;
  double? pontuacao;

  Candidato({required this.nome, required this.email, required this.pontuacao});

  factory Candidato.fromJson(Map<String, dynamic> json) => _$CandidatoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CandidatoToJson(this);
}
