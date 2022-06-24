import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:ventura_hr_front/models/resposta-vaga.dart';
import 'package:ventura_hr_front/models/usuario.dart';

import '../models/vaga.dart';
part 'app.store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  Usuario? usuario;

  @observable
  List<Vaga>? vagas;

  @observable
  bool isVagasLoaded = true;

  @observable
  Vaga? vagaSelecionada;

  @observable
  RespostaVaga? respostaVaga;
}
