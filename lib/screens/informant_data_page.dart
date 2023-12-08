import 'package:flutter/material.dart';
import 'package:formularios_antropoindicadores/page_scaffold.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../utils/campo_escrita.dart';

//rota 2
class InformantDataPage extends StatefulWidget {
  const InformantDataPage({Key? key}) : super(key: key);

  @override
  InformantDataPageState createState() {
    return InformantDataPageState();
  }
}
class InformantDataPageState extends State<InformantDataPage>{

  //final PageStorageKey _storageKey = const PageStorageKey(2);

  List<TextEditingController> cntrls2 = List.generate(7, (index) =>
      TextEditingController());

  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    //_loadFormState();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey2,
      child: PageScaffold(
        title: 'Página - 2 de 17',
        child: ListView(
          //key: _storageKey,
          children: <Widget>[
          const StepProgressIndicator(totalSteps: 17, currentStep: 2,
              size: 6.0 ,selectedColor: Colors.green),
          const SizedBox(height: 16, width: double.infinity),

          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.lightGreen ),
              child: const Text("Dados do Informante", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70))),

          CampoEscrita(indice: '4', cntrl: cntrls2[0],
              icone: Icons.person), // Nome(inform.pri.)
          CampoEscrita(indice: '5', cntrl: cntrls2[1],
              icone: Icons.groups_3), // Etnia
          CampoEscrita(indice: '6', cntrl: cntrls2[2],
              icone: Icons.wc), // Gênero
          CampoEscrita(indice: '7', cntrl: cntrls2[3],
              icone: Icons.calendar_month, keyboard: TextInputType.datetime), // Idade
          CampoEscrita(indice: '8', cntrl: cntrls2[4],
              icone: Icons.school), // Formação
          CampoEscrita(indice: '9', cntrl: cntrls2[5],
              icone: Icons.work), // Ocupação
          CampoEscrita(indice: '10', cntrl: cntrls2[6],
              icone: Icons.phone, keyboard: TextInputType.phone), // Contatos
          ElevatedButton.icon(

              onPressed: () async{
                if (_formKey2.currentState!.validate()) {
                  _formKey2.currentState!.save();
                  Navigator.pushNamed(context, '/rota3');
                }
              },

              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).primaryColor)),

              icon: const Icon(Icons.arrow_forward),
              label: const Text("Avançar")
          ),// validar e salvar dados, ir para pag 3
        ],
      ),
      )
    ); // dadosList de 4 a 10
  }

  void _loadFormState() {
    // Load form field values from PageStorage
    Map<String, dynamic>? savedState = PageStorage.of(context).readState(context);
    if (savedState != null) {
      setState(() {
        cntrls2[0].text = savedState['4'].toString();
        cntrls2[1].text = savedState['5'].toString();
        cntrls2[2].text = savedState['6'].toString();
        cntrls2[3].text = savedState['7'].toString();
        cntrls2[4].text = savedState['8'].toString();
        cntrls2[5].text = savedState['9'].toString();
        cntrls2[6].text = savedState['10'].toString();
      });
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in cntrls2) {
      controller.dispose();
    }
    super.dispose();
  }

}
