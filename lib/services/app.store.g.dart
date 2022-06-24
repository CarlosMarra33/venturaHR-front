// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$usuarioAtom =
      Atom(name: 'AppStoreBase.usuario', context: context);

  @override
  Usuario? get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(Usuario? value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  late final _$vagasAtom = Atom(name: 'AppStoreBase.vagas', context: context);

  @override
  List<Vaga>? get vagas {
    _$vagasAtom.reportRead();
    return super.vagas;
  }

  @override
  set vagas(List<Vaga>? value) {
    _$vagasAtom.reportWrite(value, super.vagas, () {
      super.vagas = value;
    });
  }

  late final _$isVagasLoadedAtom =
      Atom(name: 'AppStoreBase.isVagasLoaded', context: context);

  @override
  bool get isVagasLoaded {
    _$isVagasLoadedAtom.reportRead();
    return super.isVagasLoaded;
  }

  @override
  set isVagasLoaded(bool value) {
    _$isVagasLoadedAtom.reportWrite(value, super.isVagasLoaded, () {
      super.isVagasLoaded = value;
    });
  }

  late final _$vagaSelecionadaAtom =
      Atom(name: 'AppStoreBase.vagaSelecionada', context: context);

  @override
  Vaga? get vagaSelecionada {
    _$vagaSelecionadaAtom.reportRead();
    return super.vagaSelecionada;
  }

  @override
  set vagaSelecionada(Vaga? value) {
    _$vagaSelecionadaAtom.reportWrite(value, super.vagaSelecionada, () {
      super.vagaSelecionada = value;
    });
  }

  late final _$respostaVagaAtom =
      Atom(name: 'AppStoreBase.respostaVaga', context: context);

  @override
  RespostaVaga? get respostaVaga {
    _$respostaVagaAtom.reportRead();
    return super.respostaVaga;
  }

  @override
  set respostaVaga(RespostaVaga? value) {
    _$respostaVagaAtom.reportWrite(value, super.respostaVaga, () {
      super.respostaVaga = value;
    });
  }

  @override
  String toString() {
    return '''
usuario: ${usuario},
vagas: ${vagas},
isVagasLoaded: ${isVagasLoaded},
vagaSelecionada: ${vagaSelecionada},
respostaVaga: ${respostaVaga}
    ''';
  }
}
