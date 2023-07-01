// Para os campos de [pergunta + seleção]
import 'package:flutter/material.dart';
import 'custom_dd_button.dart';
import 'data_storage.dart';

class CampoSelect extends StatelessWidget{
  const CampoSelect({
  Key? key,
  required this.indicePergunta,
  required this.indiceVetor
  }) : super(key:key);

  final int indicePergunta;
  final int indiceVetor;

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 0,
      // #424242 card gray
      //color: const Color.fromRGBO(48, 48, 48, 0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).colorScheme.background),
      ),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(), //lista não rolável
        shrinkWrap: true, // faz caber na página
        children: <Widget>[
          //const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              DataStorage().perguntas(indicePergunta),
              maxLines: null,
              textAlign: TextAlign.left,
              //textDirection: TextDirection.rtl,
              //overflow:  TextOverflow.ellipsis,
              //softWrap: true,
              style: const TextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: CustomDDButton(indexDados: indiceVetor),
          ),
        ],
      ),
    );
  }
}