import 'package:flutter/material.dart';
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

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dados Pessoais'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(
          children: <Widget>[
            CampoEscrita(indice: '4A', cntrl: controller1), // Nome(inform.pri.)
            CampoEscrita(indice: '5A', cntrl: controller2), // Etnia
            CampoEscrita(indice: '6A', cntrl: controller3), // Gênero
            CampoEscrita(indice: '7A', cntrl: controller4), // Idade
            CampoEscrita(indice: '8A', cntrl: controller5), // Formação
            CampoEscrita(indice: '9A', cntrl: controller6), // Ocupação
            CampoEscrita(indice: '10A', cntrl: controller7), // Contatos
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
                    // dispose(); // clear controllers
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
      ),
    ); // dadosList de 4 a 10
  }
}
