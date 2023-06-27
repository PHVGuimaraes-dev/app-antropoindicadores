// Para funções de armazenmento e leitura de dados

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'dart:convert';

List<String> head = <String>[];
 Map<String,dynamic> questoes = {}; // late?
//List<List<dynamic>> matrizHead = <List<dynamic>>[]; // cabeçalho
//DataStorage storage = DataStorage();

class DataStorage{

  Future<String> get _localPath async {

    final dir = Directory('/storage/emulated/0/Documents');

    if (Platform.isIOS) {
      Directory iosDir = await getApplicationDocumentsDirectory();
      return iosDir.path;
    }
    // final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

        File('$path/Formularios/Coleta_PROCAD.csv').create(recursive: true);
        //String fileHead = const ListToCsvConverter().convert(matrizHead);
        //File('$path/Formularios/Coleta_PROCAD.csv').writeAsString(fileHead);
      //}} );
    return File('$path/Formularios/Coleta_PROCAD.csv');
  }

  void headCSV() {
    head.add('Bioma'); head.add('Cód.Form.'); head.add('Ecosist./Comun.');
    head.add('Perf. Comun.'); head.add('Nome Inf.Pri.'); head.add('Etnia'); head.add('Gênero');
    head.add('Idade'); head.add('Formação'); head.add('Ocupação'); head.add('Contatos');
    head.add('P01'); head.add('P02'); head.add('P03'); head.add('P04'); head.add('P05');
    head.add('P06'); head.add('P07'); head.add('P08'); head.add('P09'); head.add('P10');
    head.add('P11'); head.add('P12'); head.add('P13'); head.add('P14'); head.add('P15');
    head.add('P16'); head.add('P17'); head.add('P18'); head.add('P19'); head.add('P20');
    head.add('P21'); head.add('P22'); head.add('P23'); head.add('P24'); head.add('P25');
    head.add('P26'); head.add('P27'); head.add('P28'); head.add('P29'); head.add('P30');
    head.add('P31'); head.add('P32'); head.add('P33'); head.add('P34'); head.add('P35');
    head.add('P36'); head.add('P37'); head.add('P38'); head.add('P39'); head.add('P40');
    head.add('P41'); head.add('P42'); head.add('P43'); head.add('P44'); head.add('P45');
    head.add('P46'); head.add('P47'); head.add('P48'); head.add('P49'); head.add('P50');
    head.add('P51'); head.add('P52'); head.add('P53'); head.add('P54'); head.add('P55');
    head.add('P56'); head.add('P57'); head.add('P58'); head.add('P59'); head.add('P60');
    head.add('P61'); head.add('P62'); head.add('P63'); head.add('P64'); head.add('P65');
    head.add('P63'); head.add('P67'); head.add('P68'); head.add('P69'); head.add('P70');
    head.add('P71'); head.add('P72'); head.add('P73'); head.add('P74'); head.add('P75');

    matrizHead.add(head);
  }

  // create file with columns head, if new
  Future<File> createCSV() async{
    //if (matrizHead.isEmpty){
    //add head list
    if(head.isEmpty){
      headCSV();
    }
    //create
    final file = await _localFile;
    // write file head at beggining
    //await file.readAsString().then((String data) {
    //  if(data.isEmpty){
    //    String fileHead = const ListToCsvConverter().convert(matrizHead);
    //    file.writeAsString(fileHead);
    //  }
   // });
    return file;
  }

  Future<File> writeCSV() async {
    final file = await _localFile;

    // convert matrix to String and write as csv file
    String csv = const ListToCsvConverter().convert(matriz);
    // take file data that is already csv
    await file.readAsString().then((String data) {
      String fileData = data;
      if(data.isNotEmpty){ // if file had data before saving
        String dataSum = fileData + '\n' + csv;
        file.writeAsString(dataSum);
      }else{ // if empty, add head and data
        String fileHead = const ListToCsvConverter().convert(matrizHead);
        String dataSum = fileHead + '\n' + csv;
        file.writeAsString(dataSum);
      }

    });
    // sum both to increment the file
    Future.delayed(const Duration(seconds: 1));
    // Write the file
    //return file.writeAsString(dataSum);
    return file;
  }

  Future<String> readCSV() async{
    try{
      final file = await _localFile;

      final contents = await file.readAsString();

      return contents;
    }catch (e){
      // if encountering error:
      return 'read error';
    }
  }

  void saveForm(BuildContext context) async {
    //salvando formulário
    matriz.add(dadosList);
    if (await Permission.storage.request().isGranted == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Salvando formulário...'),
          ));
      await writeCSV(); // test
      await DataStorage().readCSV().then((String result) {
        csvResultados = result;
      });
      matriz.clear();
      //salvo.
    }
  }

  // Deve ser carregado antes do método perguntas() para que este possua valores
  Future<Map<String,dynamic>> loadJSON() async {
    final String questions = await rootBundle.loadString(('assets/questions.json'));
    Map<String,dynamic> questionsMap = await json.decode(questions);
    if(questionsMap.isEmpty){ debugPrint("\nVazio\n");}
    return questionsMap;
  }

  String perguntas(int indice) {
      String pergunta = questoes[indice.toString()];
      return pergunta;
  }

}
