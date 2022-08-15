import 'package:flutter/material.dart';
import 'main.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                controller: controller1,
                decoration: const InputDecoration(
                  labelText: 'Nome (informante principal): ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[4] = controller1.text;
                },
              ),
            ), // Nome(inform.princ.)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller2,
                decoration: const InputDecoration(
                  labelText: 'Etnia : ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[5] = controller2.text;
                },
              ),
            ), // Etnia
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller3,
                decoration: const InputDecoration(
                  labelText: 'Gênero: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[6] = controller3.text;
                },
              ),
            ), // Gênero
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller4,
                decoration: const InputDecoration(
                  labelText: 'Idade: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[7] = controller4.text;
                },
              ),
            ), // Idade
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller5,
                decoration: const InputDecoration(
                  labelText: 'Formação: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[8] = controller5.text;
                },
              ),
            ), // Formação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller6,
                decoration: const InputDecoration(
                  labelText: 'Ocupação: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[9] = controller6.text;
                },
              ),
            ), // Ocupação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller7,
                decoration: const InputDecoration(
                  labelText: 'Contatos: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[10] = controller7.text;
                },
              ),
            ), // Contatos
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
                  primary: Theme.of(context).primaryColor,
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
