// Para cada página do formulário

import 'package:flutter/material.dart';
import 'package:formularios_antropoindicadores/page_scaffold.dart';
import '../helpers/data_storage.dart';
import 'campo_select.dart';
import 'home_page.dart';

String proxBot(int indexR){
   return indexR == 17 ? 'Finalizar' : 'Avançar';
}

class FormPage extends StatefulWidget {
  const FormPage({
    Key? key,
    required this.indexRota,
    required this.indexP,
    required this.indexV
  }) : super(key: key);

  final int indexRota; // índice da sequência de páginas
  final int indexP;    // índice da posição da pergunta
  final int indexV;    // índice da posição do vetor

  @override
  _FormPageState createState() {
    return _FormPageState();
  }
}
class _FormPageState extends State<FormPage>{

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: PageScaffold(
        title: DataStorage().perguntas(widget.indexP),
        child: ListView(
          children: <Widget>[
            //const SizedBox(height: 40,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CampoSelect(indicePergunta: widget.indexP+1, indiceVetor: widget.indexV),
                CampoSelect(indicePergunta: widget.indexP+2, indiceVetor: widget.indexV+1),
                CampoSelect(indicePergunta: widget.indexP+3, indiceVetor: widget.indexV+2),
                CampoSelect(indicePergunta: widget.indexP+4, indiceVetor: widget.indexV+3),
                CampoSelect(indicePergunta: widget.indexP+5, indiceVetor: widget.indexV+4),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 120.0, right: 120.0, top: 40.0, bottom: 10.0),
              child: ElevatedButton(
                child: Text(widget.indexRota == 17 ? 'Finalizar' : 'Avançar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async{

                  if (_formKey.currentState!.validate()) {
                    // se dados validos, salva página no vetor
                    _formKey.currentState!.save();
                    // caso última rota, salva formulário no arquivo e volta a página inicial
                    if(widget.indexRota == 17){
                      _savingDialog();
                    }else {
                      // em outro caso, passa para a próxima rota
                      Navigator.pushNamed(context, '/rota${widget.indexRota+1}');
                    }
                  }
                },
              ),
            )
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