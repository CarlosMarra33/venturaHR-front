import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ventura_hr_front/app.module.dart';
import 'package:ventura_hr_front/app.widget.dart';

// import 'models/vaga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Vaga vaga = Vaga(
  //     cargo: 'dev',
  //     titulo: 'Vaga para deesnvolvedor',
  //     destricao: 'mto boa',
  //     status: 1);

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
  // MaterialApp(
  //   home: CardHomeWidget(
  //     vaga: vaga,
  //   ),
  // )
}

// class CardHomeWidget extends StatelessWidget {
//   final Vaga vaga;

//   CardHomeWidget({Key? key, required this.vaga}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InkWell(
//         onTap: () {
//           // TODO rota para a pagina details
//         },
//         child: Container(
//           // height: 300,
//           width: 300,
//           child: Card(
//             color: Colors.white70,
//             elevation: 3.0,
//             child: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       vaga.titulo,
//                       // textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 25,
//                       ),
//                     ),
//                     Text(
//                       'Cargo: ' + vaga.cargo,
//                       // textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       'Descrição: ' + vaga.destricao,
//                       // textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
