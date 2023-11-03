// Para os campos de [pergunta + seleção]
import 'package:flutter/material.dart';
import '../ui/custom_dd_button.dart';
import '../helpers/data_storage.dart';

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
    return Flexible(
        fit: FlexFit.loose,
        child: Card(
          elevation: 0,
          color: const Color(0x3032cd32), //0xAARRGGBB

          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //side: BorderSide(color: Theme.of(context).colorScheme.background),
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(), //lista não rolável
            shrinkWrap: true, // faz caber na página
            children: <Widget>[
          //const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  DataStorage().perguntas(indicePergunta),
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: CustomDDButton(indexDados: indiceVetor),
              ),
            ],
          ),
      )
    );
  }
}