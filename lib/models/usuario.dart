import 'package:json_annotation/json_annotation.dart';
part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  String? nome;
  String? email;
  String? cnpj;
  String? cpf;
  String? password;
  int? tipoConta;
  String? token;

  Usuario(
      {this.nome,
      this.email,
      this.cpf,
      this.password,
      this.cnpj,
      this.tipoConta,
      this.token});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
