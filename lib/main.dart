import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/pdf_screen.dart';
import 'screens/form_page.dart';
import 'screens/home_page.dart';
import 'screens/form_data_page.dart';
import 'screens/informant_data_page.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeData _getThemeData(Brightness brightness, Color color) {

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: Colors.green,
      background: const Color(0xfff6f6f6),
    );

    return ThemeData(
        brightness: brightness,
        colorScheme: colorScheme,
        primaryColor: color,
        buttonTheme: ButtonThemeData(colorScheme: colorScheme),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: _getThemeData(Brightness.light, Colors.green),
      dark: _getThemeData(Brightness.dark, Colors.green.shade800),

      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, dark) {
        return MaterialApp(
          title: 'App Antropoindicadores',
          theme: theme,
          darkTheme: dark,
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/home':   (BuildContext context) => const HomePage(),
            '/pdf_viewer': (BuildContext context) => const PDFScreen(),
            '/rota1':  (BuildContext context) => const FormDataPage(),
            '/rota2':  (BuildContext context) => const InformantDataPage(),
            //rota 3: perguntas 1-5, dadosList de 11 a 15
            '/rota3':  (BuildContext context) => const FormPage(indice: 3),
            //rota 4: perguntas 6-10, dadosList de 16 a 20
            '/rota4':  (BuildContext context) => const FormPage(indice: 4),
            //rota 5: perguntas 11-15, dadosList de 21 a 25
            '/rota5':  (BuildContext context) => const FormPage(indice: 5),
            //rota 6: perguntas 16-20, dadosList de 26 a 30
            '/rota6':  (BuildContext context) => const FormPage(indice: 6),
            //rota 7: perguntas 21-25, dadosList de 31 a 35
            '/rota7':  (BuildContext context) => const FormPage(indice: 7),
            // EIXO: CONFLITOS / CONSEQUÊNCIAS AMBIENTAIS
            //rota 8: perguntas 26-30, dadosList de 36 a 40
            '/rota8':  (BuildContext context) => const FormPage(indice: 8),
            //rota 9: perguntas 31-35, dadosList de 41 a 45
            '/rota9':  (BuildContext context) => const FormPage(indice: 9),
            //rota 10: perguntas 36-40, dadosList de 46 a 50
            '/rota10': (BuildContext context) => const FormPage(indice: 10),
            //rota 11: perguntas 41-45, dadosList de 51 a 55
            '/rota11': (BuildContext context) => const FormPage(indice: 11),
            //rota 12: perguntas 46-50, dadosList de 56 a 60
            '/rota12': (BuildContext context) => const FormPage(indice: 12),
            //EIXO: SUSTENTABILIDADE /BOM VIVER
            //rota 13: perguntas 51-55, dadosList de 61 a 65
            '/rota13': (BuildContext context) => const FormPage(indice: 13),
            //rota 14: perguntas 56-60, dadosList de 66 a 70
            '/rota14': (BuildContext context) => const FormPage(indice: 14),
            //rota 15: perguntas 61-65, dadosList de 71 a 75
            '/rota15': (BuildContext context) => const FormPage(indice: 15),
            //rota 16: perguntas 66-70, dadosList de 76 a 80
            '/rota16': (BuildContext context) => const FormPage(indice: 16),
            //rota 17: perguntas 71-75, dadosList de 81 a 85
            '/rota17': (BuildContext context) => const FormPage(indice: 17),
            //'/resultados': (BuildContext context) => const ResultScreen(),
          },
        );
      },
    );
  }
}




