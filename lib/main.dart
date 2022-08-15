import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:path_provider/path_provider.dart';

import 'data_storage.dart';
import 'form_page.dart';
import 'home_page.dart';
import 'form_page_1.dart';
import 'form_page_2.dart';

List<List<dynamic>> matriz = <List<dynamic>>[]; // Dados Acumulados
List<dynamic> dadosList = List<dynamic>.filled(86, 'none'); // Form atual
List<List<dynamic>> matrizHead = <List<dynamic>>[]; // cabeçalho
DataStorage storage = DataStorage();

var csvResultados = 'none';
const String unfilledText = 'Adicione uma resposta';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  // ignore: "use_key_in_widget_constructors"
  const MyApp({this.savedThemeMode});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green, // keyboard
        scaffoldBackgroundColor: Colors.white,

      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green[800], // keyboard
        //scaffoldBackgroundColor: Colors.black45, // gray better
        iconTheme: const IconThemeData(color: Colors.black45),
      ),

      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, dark) {
        return MaterialApp(
          title: 'Form App 1',
          theme: theme,
          darkTheme: dark,
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/home':   (BuildContext context) => const HomePage(),
            '/rota1':  (BuildContext context) => const FormPage1(),
            '/rota2':  (BuildContext context) => const FormPage2(),
            //rota 3: perguntas 1-5, dadosList de 11 a 15
            '/rota3':  (BuildContext context) => const FormPage(indexP: 0, indexV: 11, indexRota: 3),
            //rota 4: perguntas 6-10, dadosList de 16 a 20
            '/rota4':  (BuildContext context) => const FormPage(indexP: 6, indexV: 16, indexRota: 4),
            //rota 5: perguntas 11-15, dadosList de 21 a 25
            '/rota5':  (BuildContext context) => const FormPage(indexP: 12, indexV: 21, indexRota: 5),
            //rota 6: perguntas 16-20, dadosList de 26 a 30
            '/rota6':  (BuildContext context) => const FormPage(indexP: 18, indexV: 26, indexRota: 6),
            //rota 7: perguntas 21-25, dadosList de 31 a 35
            '/rota7':  (BuildContext context) => const FormPage(indexP: 24, indexV: 31, indexRota: 7),
            // EIXO: CONFLITOS / CONSEQUÊNCIAS AMBIENTAIS
            //rota 8: perguntas 26-30, dadosList de 36 a 40
            '/rota8':  (BuildContext context) => const FormPage(indexP: 30, indexV: 36, indexRota: 8),
            //rota 9: perguntas 31-35, dadosList de 41 a 45
            '/rota9':  (BuildContext context) => const FormPage(indexP: 36, indexV: 41, indexRota: 9),
            //rota 10: perguntas 36-40, dadosList de 46 a 50
            '/rota10': (BuildContext context) => const FormPage(indexP: 42, indexV: 46, indexRota: 10),
            //rota 11: perguntas 41-45, dadosList de 51 a 55
            '/rota11': (BuildContext context) => const FormPage(indexP: 48, indexV: 51, indexRota: 11),
            //rota 12: perguntas 46-50, dadosList de 56 a 60
            '/rota12': (BuildContext context) => const FormPage(indexP: 54, indexV: 56, indexRota: 12),
            //EIXO: SUSTENTABILIDADE /BOM VIVER
            //rota 13: perguntas 51-55, dadosList de 61 a 65
            '/rota13': (BuildContext context) => const FormPage(indexP: 60, indexV: 61, indexRota: 13),
            //rota 14: perguntas 56-60, dadosList de 66 a 70
            '/rota14': (BuildContext context) => const FormPage(indexP: 66, indexV: 66, indexRota: 14),
            //rota 15: perguntas 61-65, dadosList de 71 a 75
            '/rota15': (BuildContext context) => const FormPage(indexP: 72, indexV: 71, indexRota: 15),
            //rota 16: perguntas 66-70, dadosList de 76 a 80
            '/rota16': (BuildContext context) => const FormPage(indexP: 78, indexV: 76, indexRota: 16),
            //rota 17: perguntas 71-75, dadosList de 81 a 85
            '/rota17': (BuildContext context) => const FormPage(indexP: 84, indexV: 81, indexRota: 17),
            //'/resultados': (BuildContext context) => const ResultScreen(),
          },
        );
      },
    );
  }
}



