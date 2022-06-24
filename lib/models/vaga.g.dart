// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vaga _$VagaFromJson(Map<String, dynamic> json) => Vaga(
      email: json['email'] as String,
      vagaId: json['vagaId'] as int?,
      titulo: json['titulo'] as String,
      cargo: json['cargo'] as String,
      status: json['status'] as int,
      descricao: json['descricao'] as String,
      dataCriacao: json['dataCriacao'] == null
          ? null
          : DateTime.parse(json['dataCriacao'] as String),
      criterios: (json['criterios'] as List<dynamic>)
          .map((e) => Criterio.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VagaToJson(Vaga instance) => <String, dynamic>{
      'vagaId': instance.vagaId,
      'email': instance.email,
      'titulo': instance.titulo,
      'cargo': instance.cargo,
      'descricao': instance.descricao,
      'dataCriacao': instance.dataCriacao?.toIso8601String(),
      'status': instance.status,
      'criterios': instance.criterios,
    };
