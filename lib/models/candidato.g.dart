// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidato.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidato _$CandidatoFromJson(Map<String, dynamic> json) => Candidato(
      nome: json['nome'] as String?,
      email: json['email'] as String?,
      pontuacao: (json['pontuacao'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CandidatoToJson(Candidato instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'pontuacao': instance.pontuacao,
    };
