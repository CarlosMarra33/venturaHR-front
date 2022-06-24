import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/pages/cadastro.page.dart';
import 'package:ventura_hr_front/pages/cadastro.vaga.page.dart';
import 'package:ventura_hr_front/pages/detalhe.vaga.page.dart';
import 'package:ventura_hr_front/pages/home.empresa.page.dart';
import 'package:ventura_hr_front/pages/login.page.dart';
import 'package:ventura_hr_front/services/app.store.dart';
import 'package:ventura_hr_front/services/dio.service.dart';

import 'pages/home.candidato.page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<Dio>((e) => Dio(), isSingleton: false),
    BindInject<DioService>(
      (inject) => DioService(inject<Dio>(), inject<AppStore>()),
    ),
    Bind.singleton((i) => AppStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, __) => LoginPage(
              appStore: Modular.get<AppStore>(),
              dioService: Modular.get<DioService>(),
            )),
    ChildRoute('/cadastro', child: (_, __) => CadastroPage()),
    ChildRoute('/empresa-home',
        child: (_, __) => HomeEmpresa(appStore: Modular.get<AppStore>(), dioService: Modular.get<DioService>())),
    ChildRoute('/candidato-home',
        child: (_, __) => HomeCandidato(appStore: Modular.get<AppStore>(), dioService: Modular.get<DioService>())),
    ChildRoute('/cadastro-vaga',
        child: (_, __) => CadastroVaga(
              appStore: Modular.get<AppStore>(),
              dioService: Modular.get<DioService>(),
            )),
    ChildRoute('/detalhes-vaga',
        child: (_, __) => DetalhesVagaPage(appStore: Modular.get<AppStore>(), dioService: Modular.get<DioService>())),
  ];
}
