// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      nome: json['nome'] as String?,
      email: json['email'] as String?,
      cpf: json['cpf'] as String?,
      password: json['password'] as String?,
      cnpj: json['cnpj'] as String?,
      tipoConta: json['tipoConta'] as int?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'cnpj': instance.cnpj,
      'cpf': instance.cpf,
      'password': instance.password,
      'tipoConta': instance.tipoConta,
      'token': instance.token,
    };
