import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../helpers/data_storage.dart';
import 'pdf_screen.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  String pathPDF = "";

  final List<String> _routes = [ 'home', 'rota1', 'rota2', 'rota3', 'rota4', 'rota5',
    'rota6', 'rota7', 'rota8', 'rota9', 'rota10', 'rota12', 'rota13', 'rota14',
    'rota15', 'rota16', 'rota17'];


  @override
  void initState() {
    super.initState();

    DataStorage().loadJSON().then((questionsMap) {
      setState(() {
        questoes = questionsMap;
      });
    } );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Antropoindicadores'),
          actions: [
            IconButton(
                onPressed: () { AdaptiveTheme.of(context).toggleThemeMode(); },
                icon: const Icon(Icons.brightness_6_outlined)
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 100.0, right: 80.0),
              child: ElevatedButton(
                child: const Text('Iniciar Questionário',
                    textAlign: TextAlign.justify),

                onPressed: () async{
                  await Permission.storage.request();
                  await Permission.manageExternalStorage.request();
                  DataStorage().createCSV();

                  Navigator.pushNamed(context, '/rota1');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                ),
              ),
            ), // Criar Form.

            Container(
              padding: const EdgeInsets.only(left: 100.0, right: 80.0),
              child: ElevatedButton(
                child: const Text("Acessar Manual"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                ),

                onPressed: () async{

                  await DataStorage().getUserGuide().then((file) {
                    setState(() {
                      pathPDF = file.path;
                    });
                  });

                  if (pathPDF.isNotEmpty) {
                    Navigator.push(context,MaterialPageRoute(builder:
                        (context) => PDFScreen(path: pathPDF)));
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Manual disponível na pasta 'Documentos'")));
                },
              ),
            ),

            Container(
              child: const Text(
                'app-antropoindicadores 1.3.2 - PROCAD - AMAZÔNIA \n\n'
                    'Desenvolvedor: Bel. Pedro Guimarães \n'
                    'Coordenação: Prof. Dr. Marcos Seruffo\n\n'
                    'Desenvolvido para o projeto: \n'
                    'INDICADORES ANTRÓPICOS - PPGEAA  \n'
                    'Universidade Federal do Pará',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.bottomCenter,
            ),
          ],
        )
    );
  }
}
