// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Acima do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else {
        _infoText = 'Obesidade Grau III(${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.amber),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.amber),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.amber),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 2),
                  child: SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.amber,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                )
              ],
            ),
          )),
    );
  }
}
