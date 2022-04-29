import 'dart:math';

import 'package:flutter/material.dart';

class NuovaAssistenza extends StatelessWidget {
  const NuovaAssistenza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea Nuova Assistenza'),
      ),
      body: const Center(
        child: MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  List<int> pointValue = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  int generateRandomNumber() {
    return pointValue[Random().nextInt(pointValue.length)];
  }

  finalNumber() {
    final finalNumberTkt =
        getRandomString(2) + generateRandomNumber().toString();
    return finalNumberTkt;
  }

  static const paddingLabel = EdgeInsets.all(15);
  static const customLabel = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline);
  static const paddingBetweenRow =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10);

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: paddingBetweenRow,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: paddingLabel,
                labelText: 'Inserisci nome',
                labelStyle: customLabel,
              ),
              // The validator receives the text that the user has entered.
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'il nome è obbligatorio';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: paddingBetweenRow,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: paddingLabel,
                labelText: 'Inserisci cognome',
                labelStyle: customLabel,
              ),
              // The validator receives the text that the user has entered.
              validator: (surname) {
                if (surname == null || surname.isEmpty) {
                  return 'il cognome è obbligatorio';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: paddingBetweenRow,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: paddingLabel,
                labelText: 'Inserisci la marca',
                labelStyle: customLabel,
              ),
              // The validator receives the text that the user has entered.
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'la marca è obbligatoria';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: paddingBetweenRow,
            child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: paddingLabel,
                border: OutlineInputBorder(),
                labelText: 'Inserisci il modello',
                labelStyle: customLabel,
              ),
              // The validator receives the text that the user has entered.
              validator: (surname) {
                if (surname == null || surname.isEmpty) {
                  return 'il modello è obbligatorio';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: paddingBetweenRow,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Note(piega il problema riscontrato)',
                labelStyle: customLabel,
              ),
              // The validator receives the text that the user has entered.
              validator: (surname) {
                if (surname == null || surname.isEmpty) {
                  return 'Il campo note è obbligatorio';
                }
                return null;
              },
            ),
          ),
          // const Padding(),

          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Invia Richiesta'),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Numero di richiesta'),
                      Text(
                        finalNumber(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // generateRandomNumber(),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
