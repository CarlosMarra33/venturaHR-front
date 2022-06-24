import 'package:json_annotation/json_annotation.dart';
part 'criterio.g.dart';

@JsonSerializable()
class Criterio {
  String? criterios;
  int? pesos;

  Criterio({required this.criterios, required this.pesos});

  factory Criterio.fromJson(Map<String, dynamic> json) =>
      _$CriterioFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CriterioToJson(this);
}
