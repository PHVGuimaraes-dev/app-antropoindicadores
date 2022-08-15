import 'package:flutter/material.dart';
import 'main.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dados Locais'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardAppearance: Brightness.dark,
                textInputAction: TextInputAction.next,
                autofocus: true,
                controller: controller1,
                decoration: const InputDecoration(
                  labelText: 'Bioma: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text) {
                  dadosList[0] = controller1.text;
                },

              ),
            ), // Bioma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller2,
                decoration: const InputDecoration(
                  labelText: 'Código do formulário: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[1] = controller2.text;
                },
              ),
            ), // Código do form.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: controller3,
                decoration: const InputDecoration(
                  labelText: 'Ecossistema/comunidade(s): ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[2] = controller3.text;
                },
              ),
            ), // Ecossist./Comunid.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                //textInputAction: TextInputAction.next,
                controller: controller4,
                decoration: const InputDecoration(
                  labelText: 'Perfil da comunidade: ',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return unfilledText;
                  }
                  return null;
                },
                onSaved: (text){
                  dadosList[3] = controller4.text;
                },
              ),
            ), // Perfil comunid.
            Container(
              padding: const EdgeInsets.only(
                  left: 120.0, right: 120.0, top: 40.0),
              child: ElevatedButton(
                child: const Text('Avançar'),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey1.currentState!.validate()) {
                    // If the form is valid, display a Snackbar.
                    _formKey1.currentState!.save(); //save state
                    // clear controllers
                    controller1.clear();
                    controller2.clear();
                    controller3.clear();
                    controller4.clear();
                    Navigator.pushNamed(context, '/rota2');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                ),
              ),
            ), // Valid. e salv. dados, ir para pag. 2
          ],
        ),
      ),
    ); // dadosList de 0 a 3
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    focusNode1.dispose();
    super.dispose();
  }
}
