import 'package:flutter/material.dart';
import 'package:formularios_antropoindicadores/page_scaffold.dart';
import 'campo_escrita.dart';

//rota 2
class FormPage2 extends StatefulWidget {
  const FormPage2({Key? key}) : super(key: key);

  @override
  FormPage2State createState() {
    return FormPage2State();
  }
}
class FormPage2State extends State<FormPage2>{

  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  TextEditingController controller8 = TextEditingController();
  TextEditingController controller9 = TextEditingController();
  TextEditingController controller10 = TextEditingController();
  TextEditingController controller11 = TextEditingController();

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey2,
      child: PageScaffold(
        title: 'Dados do entrevistado',
        child: ListView(
        children: <Widget>[
          CampoEscrita(indice: '4', cntrl: controller5, icone: Icons.person), // Nome(inform.pri.)
          CampoEscrita(indice: '5', cntrl: controller6, icone: Icons.groups_3), // Etnia
          CampoEscrita(indice: '6', cntrl: controller7, icone: Icons.wc), // Gênero
          CampoEscrita(indice: '7', cntrl: controller8, icone: Icons.calendar_month), // Idade
          CampoEscrita(indice: '8', cntrl: controller9, icone: Icons.school), // Formação
          CampoEscrita(indice: '9', cntrl: controller10, icone: Icons.work), // Ocupação
          CampoEscrita(indice: '10', cntrl: controller11, icone: Icons.phone), // Contatos
          Container(
            padding: const EdgeInsets.only(
                left: 120.0, right: 120.0, top: 40.0),
            child: ElevatedButton(
              child: const Text('Avançar'),
              onPressed: () {
                // It returns true if the form is valid, otherwise returns false
                if (_formKey2.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  _formKey2.currentState!.save(); //save state
                  //dispose(); // clear controllers

                  Navigator.pushNamed(context, '/rota3');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const StadiumBorder(),
              ),
            ),
          ), // validar e salvar dados, ir para pag 3
        ],
      ),
      )
    ); // dadosList de 4 a 10
  }
}
