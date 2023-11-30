import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../page_scaffold.dart';
import '../helpers/data_storage.dart';
import '../utils/campo_select.dart';
import 'home_page.dart';


class FormPage extends StatefulWidget {
  const FormPage({
    Key? key,
    required this.indice
  }) : super(key: key);

  final int indice;
  // índice da posição do vetor

  @override
  _FormPageState createState() {
    return _FormPageState();
  }
}
class _FormPageState extends State<FormPage>{

  final _formKey = GlobalKey<FormState>();

  late int indexRota; // índice da sequência de páginas
  late int indexP;  // índice da posição da pergunta
  late int indexV;

  @override
  void initState() {
    indexRota = widget.indice;
    indexP = 0 + (widget.indice-3)*6;
    indexV = 11 + (widget.indice-3)*5;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Form(
        key: _formKey,
        child: PageScaffold(
          title: "Página - $indexRota de 17",
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8, width: double.infinity),
                  StepProgressIndicator(
                      totalSteps: 17,
                      currentStep: indexRota,
                      size: 6.0,
                      selectedColor: Colors.green),
                  const SizedBox(height: 16, width: double.infinity),

                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lightGreen ),
                      child: Text(DataStorage().perguntas(
                          "${((indexP)/30).floor()}B"),
                          textAlign: TextAlign.center, style: const TextStyle(
                              fontSize: 18, color: Colors.white70))),
                  const SizedBox(height: 10, width: double.infinity),

                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lime.shade700),
                      child: Text(DataStorage().perguntas(indexP),
                          textAlign: TextAlign.center, style: const TextStyle(
                              fontSize: 18, color: Colors.white70))),
                  const SizedBox(height: 8, width: double.infinity),

                  CampoSelect(indicePergunta: indexP+1, indiceVetor: indexV),
                  CampoSelect(indicePergunta: indexP+2, indiceVetor: indexV+1),
                  CampoSelect(indicePergunta: indexP+3, indiceVetor: indexV+2),
                  CampoSelect(indicePergunta: indexP+4, indiceVetor: indexV+3),
                  CampoSelect(indicePergunta: indexP+5, indiceVetor: indexV+4),
                ],
              ),
              ElevatedButton.icon(
                  onPressed: () async{

                    _formKey.currentState!.validate()
                      ? _formKey.currentState!.save()
                      : (indexRota == 17)
                        ? _savingDialog()
                        : Navigator.pushNamed(context, '/rota${indexRota+1}');
                  },

                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor)),

                  icon: (indexRota==17)
                      ? const Icon(Icons.save)
                      : const Icon(Icons.arrow_forward),

                  label: (indexRota==17)
                      ? const Text("Finalizar")
                      : const Text("Avançar")
              ),
            ],
          ),
        )
    );
  }

  Future<void> _savingDialog() async{
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirmar Finalização"),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("O questionário será finalizado e os dados serão salvos."),
                  Text("Confirma o procedimento?")
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async{

                    DataStorage().saveForm(context);
                    await Future.delayed(const Duration(seconds: 1), (){
                      Navigator.pushAndRemoveUntil<void>(context,
                          MaterialPageRoute<void>(builder:
                              (BuildContext context) => const HomePage()),
                          ModalRoute.withName('/home'));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Fomulário salvo')));
                    });
                  },
                  child: const Text("Confirmar")),

              TextButton(
                  onPressed: () {Navigator.of(context).pop();},
                  child: const Text("Voltar"))
            ],
          );
        });
  }
}


