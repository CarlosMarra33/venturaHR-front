// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vaga _$VagaFromJson(Map<String, dynamic> json) => Vaga(
      titulo: json['titulo'] as String,
      cargo: json['cargo'] as String,
      status: json['status'] as int,
      destricao: json['destricao'] as String,
      dataModificacao: DateTime.parse(json['dataModificacao'] as String),
      pesos: (json['pesos'] as List<dynamic>?)?.map((e) => e as int).toList(),
      skillNames: (json['skillNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$VagaToJson(Vaga instance) => <String, dynamic>{
      'titulo': instance.titulo,
      'cargo': instance.cargo,
      'destricao': instance.destricao,
      'dataModificacao': instance.dataModificacao.toIso8601String(),
      'status': instance.status,
      'skillNames': instance.skillNames,
      'pesos': instance.pesos,
    };
