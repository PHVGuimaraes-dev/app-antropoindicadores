import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'data_storage.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

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
        title: const Text('Pagina inicial'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 100.0, right: 80.0),
            child: ElevatedButton(
              child: const Text('Criar Formulário',
                  textAlign: TextAlign.justify),
              onPressed: () async{
                //permissions here
                await Permission.storage.request();
                await Permission.manageExternalStorage.request();
                //moved to data_storage
                //storage.headCSV();
                //matrizHead.add(head);
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
              child: const Text('Tema claro/escuro',
                  textAlign: TextAlign.justify),
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const StadiumBorder(),
              ),
            ),
          ), // Modo C/E

          Container(
            child: const Text(
              '"INDICADORES ANTRÓPICOS"  \n\n'
                  'DataForm 1.2 - PROCAD - AMAZÔNIA \n\n'
                  'Desenvolvido por Bel. Pedro Guimarães \n'
                  'Coordenação: Prof. Dr. Marcos Seruffo\n\n'
                  'Universidade Federal do Pará',
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }
}
