import 'package:flutter/material.dart';
import 'package:formularios_antropoindicadores/page_scaffold.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../utils/campo_escrita.dart';

//rota 1
class FormDataPage extends StatefulWidget {
  const FormDataPage({Key? key}) : super(key: key);

  @override
  FormDataPageState createState() {
    return FormDataPageState();
  }
}

class FormDataPageState extends State<FormDataPage> {

  List<TextEditingController> cntrls1 = List.generate(4, (index) =>
      TextEditingController());

  final _formKey1 = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: PageScaffold(
          title: 'Página - 1 de 17',
          child: ListView(
            children: <Widget>[
              const StepProgressIndicator(totalSteps: 17, currentStep: 1,
                  size: 6.0 ,selectedColor: Colors.green),
              const SizedBox(height: 16, width: double.infinity),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.lightGreen ),
                child: const Text("Dados do Local", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70))),

              CampoEscrita(indice: '0', cntrl: cntrls1[0], icone: Icons.forest),
              // Bioma
              CampoEscrita(
                  indice: '1', cntrl: cntrls1[1], icone: Icons.abc),
              // Código do form.
              CampoEscrita(
                  indice: '2', cntrl: cntrls1[2], icone: Icons.house),
              // Ecossist./Comunid.
              CampoEscrita(
                  indice: '3', cntrl: cntrls1[3], icone: Icons.group),
              // Perfil comunid.
              ElevatedButton.icon(

                  onPressed: () async{
                    if (_formKey1.currentState!.validate()) {
                      _formKey1.currentState!.save();
                      Navigator.pushNamed(context, '/rota2');
                    }
                  },

                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)),

                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Avançar")
              ),
              // Valid. e salv. dados, ir para pag. 2
            ],
          )
      ),
    ); // dadosList de 0 a 3
  }

  @override
  void dispose() {
    focusNode1.dispose();
    for (TextEditingController controller in cntrls1) {
      controller.dispose();
    }
    super.dispose();
  }

}
