import 'package:flutter/material.dart';
import '../helpers/data_storage.dart';

class CampoEscrita extends StatelessWidget {
  const CampoEscrita({
    super.key,
    //required this.keyValue,
    required this.indice,
    required this.cntrl,
    this.icone,
    this.keyboard,
  });

  //final String keyValue;
  final String indice;
  final TextEditingController cntrl;
  final IconData? icone;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(

        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
          key: ValueKey(indice), //ValueKey(keyValue)
          keyboardAppearance: ThemeData().brightness,
          keyboardType: keyboard ?? TextInputType.text,
          textInputAction: TextInputAction.next,
          autofocus: true,
          controller: cntrl,
          decoration: InputDecoration(
            labelText: DataStorage().perguntas("${indice}A"),

            icon: icone == null ? Icon(icone) : null,
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return 'Preencha um campo';
            }
            return null;
          },

          onSaved: (text) {
            dadosList[int.parse(indice)] = cntrl.text;
            PageStorage.of(context).writeState(context, {
              indice: cntrl.text, // keyValue:
            });
          },
        ),
    );
  }
}
