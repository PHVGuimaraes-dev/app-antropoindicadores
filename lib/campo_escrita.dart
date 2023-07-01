import 'package:flutter/material.dart';
import 'data_storage.dart';

class CampoEscrita extends StatelessWidget {
  const CampoEscrita({
    super.key,
    required this.indice,
    required this.cntrl,
  });

  final String indice;
  final TextEditingController cntrl;

  @override
  Widget build(BuildContext context) {
    return Padding(

        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(

          keyboardAppearance: Brightness.dark,
          textInputAction: TextInputAction.next,
          autofocus: true,
          controller: cntrl,
          decoration: InputDecoration(
            labelText: DataStorage().perguntas(indice),
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return unfilledText;
            }
            return null;
          },

          onSaved: (text) {
            dadosList[0] = cntrl.text;
          },
        ),
    );
  }
}
