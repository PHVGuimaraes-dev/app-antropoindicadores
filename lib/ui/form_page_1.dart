import 'package:flutter/material.dart';
import 'package:formularios_antropoindicadores/page_scaffold.dart';
import 'campo_escrita.dart';

//rota 1
class FormPage1 extends StatefulWidget {
  const FormPage1({Key? key}) : super(key: key);

  @override
  FormPage1State createState() {
    return FormPage1State();
  }
}

class FormPage1State extends State<FormPage1> {

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();
  late FocusNode focusNode1;

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey1,
      child: PageScaffold(
          title: 'Dados do local',
          child: ListView(
            children: <Widget>[
              CampoEscrita(indice: '0', cntrl: controller1, icone: Icons.forest), // Bioma
              CampoEscrita(indice: '1', cntrl: controller2, icone: Icons.abc), // Código do form.
              CampoEscrita(indice: '2', cntrl: controller3, icone: Icons.house), // Ecossist./Comunid.
              CampoEscrita(indice: '3', cntrl: controller4, icone: Icons.group), // Perfil comunid.
              Container(
                padding: const EdgeInsets.only(
                    left: 120.0, right: 120.0, top: 40.0),
                child: ElevatedButton(
                  child: const Text('Avançar'),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey1.currentState!.validate()) {

                      _formKey1.currentState!.save(); //save state
                      // clear controllers
                      //controller1.clear();
                      //controller2.clear();
                      //controller3.clear();
                      //controller4.clear();
                      Navigator.pushNamed(context, '/rota2');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const StadiumBorder(),
                  ),
                ),
              ), // Valid. e salv. dados, ir para pag. 2
            ],
          )
      ),
    ); // dadosList de 0 a 3
  }

  @override
  void dispose() {
    focusNode1.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }
}
