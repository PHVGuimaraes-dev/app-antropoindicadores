// Para a configuração das caixas de seleção

import 'package:flutter/material.dart';
import 'main.dart';

class CustomDDButton extends StatefulWidget{
  const CustomDDButton({
    Key? key,
    required this.indexDados,
  }) : super(key:key);

  final int indexDados;

  @override
  CustomDDButtonState createState(){
    return CustomDDButtonState();
  }
}
class CustomDDButtonState extends State<CustomDDButton>{

  String dropdownValue = '1 (Inexistente/Nunca)';
  bool isSelected = false;

  @override
  Widget build(BuildContext context){
    return DropdownButtonFormField(
      hint: const Text('Selecionar'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.green,
      ),
      onChanged: (String? newValue){
        setState((){
          dropdownValue = newValue!;
          isSelected = true;
        });
      },
      validator: (text){
        if(isSelected == false){
          return 'Selecione uma opção';
        }
        return null;
      },
      onSaved: (text){
        dadosList[widget.indexDados] = dropdownValue[0]; // test [0]
      },
      items: <String>[
        '1 (Inexistente/Nunca)',
        '2 (Quase nunca)',
        '3 (Mais ou menos)',
        '4 (Quase sempre)',
        '5 (Sempre)']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}