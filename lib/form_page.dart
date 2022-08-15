// Para cada página do formulário

import 'package:flutter/material.dart';
import 'data_storage.dart';
import 'campo_select.dart';
import 'home_page.dart';

DataStorage storage = DataStorage();

String proxBot(int indexR){
  if(indexR == 17){
    return 'Finalizar';
  }else{
    return 'Avançar';
  }
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
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(storage.perguntas(widget.indexP)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(
          children: <Widget>[
            CampoSelect(indicePergunta: widget.indexP+1, indiceVetor: widget.indexV),
            CampoSelect(indicePergunta: widget.indexP+2, indiceVetor: widget.indexV+1),
            CampoSelect(indicePergunta: widget.indexP+3, indiceVetor: widget.indexV+2),
            CampoSelect(indicePergunta: widget.indexP+4, indiceVetor: widget.indexV+3),
            CampoSelect(indicePergunta: widget.indexP+5, indiceVetor: widget.indexV+4),

            Container(
              padding: const EdgeInsets.only(
                  left: 120.0, right: 120.0, top: 40.0),
              child: ElevatedButton(
                child: Text(proxBot(widget.indexRota)), // mostra avançar ou finalizar
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                ),
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // se dados validos, salva página no vetor

                    if(widget.indexRota == 17){
                      // caso última rota, salva formulário no arquivo e volta a página inicial
                      storage.saveForm(context);

                      await Future.delayed(const Duration(seconds: 1), (){
                        Navigator.pushAndRemoveUntil<void>(context,
                          MaterialPageRoute<void>(builder: (BuildContext context)
                          => const HomePage()),
                          ModalRoute.withName('/home'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fomulário salvo'))
                        );
                      });
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
      ),
    );
  }
}