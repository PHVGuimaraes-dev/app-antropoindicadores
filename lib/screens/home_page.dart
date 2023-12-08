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
          backgroundColor: Theme.of(context).primaryColor,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ElevatedButton.icon(
                onPressed: () async{

                  await Permission.storage.request();
                  await Permission.manageExternalStorage.request();
                  DataStorage().createCSV();

                  Navigator.pushNamed(context, '/rota1');
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),

                icon: const Icon(Icons.edit_document),
                label: const Text("Iniciar Questionário")
            ),

            ElevatedButton.icon(
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
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  //fixedSize: Size(200, 40),
                ),

                icon: const Icon(Icons.description_outlined),
                label: const Text("Acessar Manual")
            ),

            ElevatedButton.icon(
                onPressed: () async{

                  await DataStorage().acessCSV();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Dados disponíveis na pasta 'Documentos/Formularios'")
                  ));

                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),

                icon: const Icon(Icons.file_open_outlined),
                label: const Text("Acessar coletas")
            ),

            Container(

              child: const Text(
                    '"app-antropoindicadores" - v. 1.4.1 \n\n'
                    'Desenvolvedor: Bel. Pedro Guimarães \n'
                    'Coordenação: Prof. Dr. Marcos Seruffo\n\n'
                    'Desenvolvido para o projeto: \n'
                    'INDICADORES ANTRÓPICOS \n '
                    '- PROCAD AMAZÔNIA - \n'
                    'Universidade Federal do Pará (UFPA)',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.bottomCenter
            ),
          ],
        )
    );
  }
}
