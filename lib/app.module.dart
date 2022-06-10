import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/pages/cadastro.page.dart';
import 'package:ventura_hr_front/pages/cadastro.vaga.page.dart';
import 'package:ventura_hr_front/pages/home.empresa.page.dart';
import 'package:ventura_hr_front/pages/login.page.dart';
import 'package:ventura_hr_front/services/app.store.dart';
import 'package:ventura_hr_front/services/dio.service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    BindInject<DioService>(
      (inject) => DioService(inject<Dio>(), inject<AppStore>()),
      isSingleton: false,
    ),
    Bind.singleton((i) => AppStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/1',
        child: (_, __) => LoginPage(appStore: Modular.get<AppStore>())),
    ChildRoute('/cadastro', child: (_, __) => CadastroPage()),
    ChildRoute('/empresa-home',
        child: (_, __) => HomeEmpresa(
            appStore: Modular.get<AppStore>(),
            dioService: Modular.get<DioService>())),
    ChildRoute('/',
        child: (_, __) => CadastroVaga(
              // appStore: Modular.get<AppStore>(),
              // dioService: Modular.get<DioService>(),
            ))
  ];
}