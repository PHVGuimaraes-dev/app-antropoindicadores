// Para os campos de [pergunta + seleção]

import 'package:flutter/material.dart';
import 'custom_dd_button.dart';
import 'data_storage.dart';
//import 'main.dart'; // quando juntar
DataStorage storage = DataStorage(); //para metodo de perguntas

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
    return ListView(
      physics: const NeverScrollableScrollPhysics(), //lista não rolável
      shrinkWrap: true, // faz caber na página
      children: <Widget>[
        const SizedBox(height: 40),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SizedBox(
            width: 160,
            child: Text(
              storage.perguntas(indicePergunta),
              maxLines: null,
              textAlign: TextAlign.left,
              //textDirection: TextDirection.rtl,
              overflow:  TextOverflow.ellipsis,
              style: const TextStyle(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: CustomDDButton(indexDados: indiceVetor),
        ),
      ],
    );
  }
}