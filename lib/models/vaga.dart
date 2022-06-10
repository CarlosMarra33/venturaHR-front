import 'package:json_annotation/json_annotation.dart';
part 'vaga.g.dart';

@JsonSerializable()
class Vaga {
  String titulo;
  String cargo;
  String destricao;
  DateTime dataModificacao;
  int status;
  List<String>? skillNames;
  List<int>? pesos;

  Vaga(
      {required this.titulo,
      required this.cargo,
      required this.status,
      required this.destricao,
      required this.dataModificacao,
      this.pesos,
      this.skillNames});

  factory Vaga.fromJson(Map<String, dynamic> json) => _$VagaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VagaToJson(this);
}
