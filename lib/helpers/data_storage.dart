import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<List<dynamic>> matrizHead = <List<dynamic>>[]; // cabeçalho
List<List<dynamic>> matriz = <List<dynamic>>[]; // dados acumulados
List<dynamic> dadosList = List<dynamic>.filled(86, ''); // form atual
Map<String,dynamic> questoes = {}; // perguntas
List<String> formCache = [];

var csvResultados = '';
const String unfilledText = 'Adicione uma resposta';

class DataStorage{

  Future<String> get _localPath async {

    final dir = Directory('/storage/emulated/0/Documents');

    if (Platform.isIOS) {
      Directory iosDir = await getApplicationDocumentsDirectory();
      return iosDir.path;
    }

    return dir.path;
  }

  Future<File> get _localFile async {

    final path = await _localPath;
    File('$path/Formularios/Coleta_PROCAD.csv').create(recursive: true);
    return File('$path/Formularios/Coleta_PROCAD.csv');

  }

  void _headCSV() {

    List<String> head = <String>[];

    for(int i=0; i<=10; i++){
      String index = "${i.toString()}A";
      head.add(questoes[index]["coluna"]);
    }

    for(int i=1; i<=89; i++){
      // Se chave não for múltiplo de 6, que são apenas os Temas
      if(i%6 != 0){
        head.add(questoes[i.toString()]["coluna"]);
      }
    }
    matrizHead.add(head);
  }

  // create file with columns head, if new
  Future<File> createCSV() async{

    if(matrizHead.isEmpty){
      _headCSV();
    }
    final file = await _localFile;

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
    Future.delayed(const Duration(seconds: 1));
    return file;
  }

  Future<String> readCSV() async{

    try{
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    }catch (e){
      return 'read error';
    }
  }

  //salvando formulário
  void saveForm(BuildContext context) async {

    matriz.add(dadosList);

    if (await Permission.storage.request().isGranted == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Salvando formulário...')));
      await writeCSV();
      await DataStorage().readCSV().then((String result) {
        csvResultados = result;
      });
      matriz.clear();
    }
  }

  // Deve ser carregado antes do método perguntas() para que este possua valores
  Future<Map<String,dynamic>> loadJSON() async {

    final String questions = await rootBundle.loadString(('assets/questions.json'));
    Map<String,dynamic> questionsMap = await json.decode(questions);
    return questionsMap;
  }

  String perguntas(indice) {

      String pergunta = questoes[indice.toString()]["pergunta"];
      return pergunta;
  }

  Future<File> getUserGuidePath() async{

    String assetName = 'INDICADORES_ANTROPICOS-Manual_do_Usuário_e_Guia_de_Campo v2.pdf';
    final ByteData assetData = await rootBundle.load('assets/$assetName');
    final List<int> bytes = assetData.buffer.asUint8List();

    final String dir = await _localPath;

    final String filePath = '$dir/$assetName';
    return File(filePath).writeAsBytes(bytes);


  }

  Future<File> getUserGuide() async {
    Completer<File> completer = Completer();

    try {
      await Permission.storage.request();
      String assetName = 'INDICADORES_ANTROPICOS-Manual_do_Usuário_e_Guia_de_Campo v2.pdf';
      // String filename = 'App Antropoindicadores - Manual do Usuário + Guia de campo - v2.pdf';
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$assetName");

      //var data = await rootBundle.load(assetName);
      //var bytes = data.buffer.asUint8List();
      final ByteData assetData = await rootBundle.load('assets/$assetName');
      final List<int> bytes = assetData.buffer.asUint8List();

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

}
