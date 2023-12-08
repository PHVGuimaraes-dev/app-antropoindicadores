// Para os campos de [pergunta + seleção]
import 'package:flutter/material.dart';
import '../helpers/data_storage.dart';

class CampoSelect extends StatefulWidget {
  const CampoSelect({
    Key? key,
    required this.keyValue,
    required this.indicePergunta,
    required this.indiceVetor
  }) : super(key:key);

  final String keyValue;
  final int indicePergunta;
  final int indiceVetor;

  @override
  State<CampoSelect> createState() => _CampoSelectState();
}

class _CampoSelectState extends State<CampoSelect> {

  String? dropdownValue;
  bool isSelected = false;

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
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(), //lista não rolável
            shrinkWrap: true,
            children: <Widget>[
              //const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  DataStorage().perguntas(widget.indicePergunta),
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: _dropdown(),
              ),
            ],
          ),
        )
    );
  }

  Widget _dropdown(){

    //Map<String, dynamic>? savedState = PageStorage.of(context).readState(context);

    //if (savedState != null) {
    //  setState(() {
    //    dropdownValue = savedState[widget.keyValue];
    //  });
    //}

    return  DropdownButtonFormField(
      //key: ValueKey(widget.keyValue),
      hint: const Text('Selecionar'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
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

        dadosList[widget.indiceVetor] = dropdownValue![0];

        //PageStorage.of(context).writeState(context, {
        //  widget.keyValue: dropdownValue!,
        //}
        //);
      },
      items: <String>[
        'X (Não informado)',
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


