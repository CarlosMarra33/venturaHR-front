// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resposta-vaga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaVaga _$RespostaVagaFromJson(Map<String, dynamic> json) => RespostaVaga(
      nomeCandidato: json['nomeCandidato'] as String?,
      emailCandidato: json['emailCandidato'] as String?,
      vagaId: json['vagaId'] as int?,
      criterios: (json['criterios'] as List<dynamic>?)
          ?.map((e) => Criterio.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RespostaVagaToJson(RespostaVaga instance) =>
    <String, dynamic>{
      'nomeCandidato': instance.nomeCandidato,
      'emailCandidato': instance.emailCandidato,
      'vagaId': instance.vagaId,
      'criterios': instance.criterios,
    };
