// Para funções de armazenmento e leitura de dados

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';

List<String> head = <String>[];
//List<List<dynamic>> matrizHead = <List<dynamic>>[]; // cabeçalho

class DataStorage{


  Future<String> get _localPath async {
    // final dir = Directory('/storage/emulated/0/Documents/Formularios'); <-order error, 'formularios' do not exist yet
    final dir = Directory('/storage/emulated/0/Documents');
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    // '$path/Coleta_PROCAD.csv' <- error, formularios needs creation
    //File('$path/Formularios/Coleta_PROCAD.csv').exists().then((bool fileExist) {
      //if(fileExist == false){
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
      await storage.readCSV().then((String result) {
        csvResultados = result;
      });
      matriz.clear();
      //salvo.
    }
  }

  String perguntas(int index){
    String question = '';
    switch(index){

      case 0: return question = 'Alimentação e saúde';
      case 1: return question = '1) Sua família se alimenta ao menos três vezes ao dia?';
      case 2: return question = '2) Sua família consome diferentes tipos de alimentos?';
      case 3: return question = '3) Sua família consegue atendimento médico com\n facilidade na comunidade?';
      case 4: return question = '4) Em geral, a comunidade é saudável, tem boa saúde?';
      case 5: return question = '5) Sua família sabe fazer e/ou utiliza remédios caseiros?';

      case 6: return question = 'Moradia';
      case 7: return question = '6) Você gosta de morar nesta comunidade?';
      case 8: return question = '7) Você considera que sua casa é confortável?';
      case 9: return question = '8) Você cria animais e/ou plantas em sua casa?';
      case 10: return question = '9) A prefeitura/o governo cuida da comunidade?';
      case 11: return question = '10) A vizinhança é unida e solidária?';

      case 12: return question = 'Trabalho e ambiente';
      case 13: return question = '11) Os trabalhadores da comunidade protegem o meio\n ambiente?';
      case 14: return question = '12) Os trabalhadores da comunidade têm seus direitos \nsociais assegurados?';
      case 15: return question = '13) Há casos de degradação do meio ambiente em \nrazão do trabalho local?';
      case 16: return question = '14) Existem empresas que exploram o meio ambiente\n local?';
      case 17: return question = '15) Os trabalhadores da comunidade dividem o uso do\n espaço de trabalho entre si?';

      case 18: return question = 'Renda e consumo';
      case 19: return question = '16) O que você ganha mensalmente é o bastante para\n viver bem?';
      case 20: return question = '17) Na comunidade existe trabalho para todos/as?';
      case 21: return question = '18) Você consegue guardar dinheiro todo mês fazendo\n uma poupança?';
      case 22: return question = '19) Você consegue pagar todas as suas contas do mês?';
      case 23: return question = '20) Você consegue comprar mensalmente tudo o que\n deseja?';

      case 24: return question = 'Conforto ambiental';
      case 25: return question = '21) Sua comunidade é bem arborizada?';
      case 26: return question = '22) O clima em sua comunidade é agradável?';
      case 27: return question = '23) A umidade se mantem estável nos últimos cinco\n anos?';
      case 28: return question = '24) O calor tem aumentado nos últimos cinco anos?';
      case 29: return question = '25) Existe abundância de água limpa (beber, cozinhar,\n banhar, lazer) na comunidade?';

      case 30: return question = 'Bioindicadores';
      case 31: return question = '26) Na comunidade existem diferentes ambientes/\n ecossistemas (secos e molhados)?';
      case 32: return question = '27) Existe fartura de alimentos da natureza local \n(animais, peixes, frutas, plantas e raízes)?';
      case 33: return question = '28) Existem árvores com mais de 30 anos na \ncomunidade?';
      case 34: return question = '29) A quantidade de insetos, fungos, algas e mofos se \nmantem estável?';
      case 35: return question = '30) A quantidade de aves se mantem estável nos últimos \ncinco anos?';

      case 36: return question = 'Geoindicadores';
      case 37: return question = '31) A terra na comunidade é boa para o plantio?';
      case 38: return question = '32) O ar que se respira na comunidade tem boa \nqualidade?';
      case 39: return question = '33) O depósito de lixo da comunidade é adequado?';
      case 40: return question = '34) A intensidade dos ventos e das chuvas se mantem \nestável nos últimos cinco anos?';
      case 41: return question = '35) O nível das águas dos rios e das marés se mantem \nestável nos últimos cinco anos?';

      case 42: return question = 'Territorialidade';
      case 43: return question = '36) Os espaços de produção econômica em sua\n comunidade são coletivos?';
      case 44: return question = '37) Você conhece a história de origem de \nsua comunidade?';
      case 45: return question = '38) Você conhece todos as comunidades e vilas de \nseu lugar?';
      case 46: return question = '39) Você sabe usar todos os recursos naturais de \nsua comunidade?';
      case 47: return question = '40) Você compartilha o que tem e produz com \nparentes e amigos?';

      case 48: return question = 'Interculturalidade';
      case 49: return question = '41) A comunidade aceita as novidades e as pessoas\n que vem de fora?';
      case 50: return question = '42) Os poderosos daqui tratam os outros moradores\n com respeito?';
      case 51: return question = '43) Você acredita que na comunidade exista influência \nda cultura de negros e indígenas?';
      case 52: return question = '44) Todos os moradores participam de festas e\n brincadeiras próprias da comunidade?';
      case 53: return question = '45) As notícias e informações da comunidade são\n divulgadas para fora?';

      case 54: return question = 'Segurança';
      case 55: return question = '46) Você se sente seguro em sua comunidade?';
      case 56: return question = '47) A polícia garante proteção às pessoas da\n comunidade?';
      case 57: return question = '48) Existe respeito entre jovens e velhos?';
      case 58: return question = '49) As famílias resolvem seus problemas de\n maneira pacífica?';
      case 59: return question = '50) A comunidade evita discussões e brigas entre \nseus moradores?';

      case 60: return question = 'Diversidade cultural';
      case 61: return question = '51) Para você, todas as pessoas/culturas têm a\n mesma importância?';
      case 62: return question = '52) Existe tolerância religiosa na comunidade?';
      case 63: return question = '53) Pessoas Com Deficiência são aceitas e incluídas \nnas atividades da comunidade?';
      case 64: return question = '54) A comunidade preserva a história e a sabedoria\n dos/as antigos/as?';
      case 65: return question = '55) A comunidade respeita as diferentes cores\n e aparências das pessoas?';

      case 66: return question = 'Garantia de direitos';
      case 67: return question = '56) A comunidade respeita o direito a ser diferente\n das pessoas daqui?';
      case 68: return question = '57) Você acredita que homens e mulheres devem ter\n os mesmos direitos?';
      case 69: return question = '58) Os moradores da comunidade tem assistência\n social nos programas de governo?';
      case 70: return question = '59) A comunidade combate o abuso de poder e\n a corrupção de autoridades locais?';
      case 71: return question = '60) A comunidade participa do planejamento e\n da gestão do município?';

      case 72: return question = 'Economia circular';
      case 73: return question = '61) Para você, consumir menos melhora ajuda\n a melhorar o meio ambiente?';
      case 74: return question = '62) Em sua casa existe aproveitamento do lixo\n (seco/molhado)?';
      case 75: return question = '63) Em sua casa vocês costumam consertar os\n bens danificados (roupa, equipamento, objetos)?';
      case 76: return question = '64) Em sua casa vocês costumam compartilhar o uso\n ou doar os bens que não querem mais?';
      case 77: return question = '65) Em sua casa vocês costumam usar a energia\n (eletricidade, carvão, etc) de forma sustentável?';

      case 78: return question = 'Dialogo de saberes';
      case 79: return question = '66) A escola da comunidade dispõe de acesso à\n tecnologia digital?';
      case 80: return question = '67) Os jovens e adultos têm formação profissional\n para exercerem seus trabalhos?';
      case 81: return question = '68) A escola utiliza os saberes tradicionais/\ndos mais velhos da comunidade?';
      case 82: return question = '69) A comunidade costuma se reunir para resolver\n seus problemas?';
      case 83: return question = '70) Existe transmissão de conhecimentos práticos e\n da vida entre as gerações (pais e filhos/jovens e velhos)?';

      case 84: return question = 'Gestão do território';
      case 85: return question = '71) As soluções sobre os problemas da comunidade\n são feitas coletivamente?';
      case 86: return question = '72) Todos os segmentos da sociedade são consultados\n na tomada de decisões?';
      case 87: return question = '73) Há fiscalização pela comunidade dos usos\n do território?';
      case 88: return question = '74) A comunidade respeita os limites de usos da\n terra/do território?';
      case 89: return question = '75) A comunidade utiliza informações científicas na\n resolução de seus problemas?';
    }
    return question;
  }

}