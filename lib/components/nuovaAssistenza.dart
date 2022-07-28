import 'dart:math';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_app/utils/storage_service.dart';

class NuovaAssistenza extends StatefulWidget {
  String marca, modello, imei, serial, note;

  NuovaAssistenza(
      {Key? key,
      required this.imei,
      required this.marca,
      required this.modello,
      required this.note,
      required this.serial})
      : super(key: key);

  @override
  State<NuovaAssistenza> createState() => _NuovaAssistenzaState();
}

class _NuovaAssistenzaState extends State<NuovaAssistenza> {
  final Storage storage = Storage();

  final _formKey = GlobalKey<FormState>();
  var waterCheck = false;
  var warrantyCheck = false;
  var _photoLoaded = false;
  var finalNumberTkt = '';
  var path = '';
  var fileName = '';
  var statusTck = 'NUOVA';
  String marcaValue = 'Apple';
  String problemValue = 'Batteria';
  final Map<String, dynamic> formData = {
    'marca': 'Apple',
    'modello': null,
    'imei': null,
    'serial': null,
    'note': null,
    'id': null,
    'problema': 'Batteria',
    'acqua': false,
    'garanzia': false,
    'data': '',
    'photo': false,
  };

  uploadFile() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nessuna foto selezionata'),
        ),
      );
      setState(() {
        _photoLoaded = false;
        formData['photo'] = _photoLoaded;
      });
      return null;
    }

    path = results.files.single.path!;
    fileName = results.files.single.name;

    storage.uploadFile(path, fileName, finalNumberTkt).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Immagine caricata'),
              backgroundColor: Colors.green,
            ),
          ),
        );

    setState(() {
      _photoLoaded = true;
      formData['photo'] = _photoLoaded;
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
    finalNumber();
    getDateToday();
  }

  List<int> pointValue = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  generateRandomNumber() {
    return pointValue[Random().nextInt(pointValue.length)];
  }

  getDateToday() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  finalNumber() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyyMMdd');
    String formattedDate = formatter.format(now);

    finalNumberTkt = formattedDate +
        '-' +
        getRandomString(2) +
        generateRandomNumber().toString();
    formData['id'] = finalNumberTkt;
    return finalNumberTkt;
  }

  static const paddingLabel = EdgeInsets.all(15);
  static const customLabel = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline);

  static const paddingBetweenRow =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5);

  DatabaseReference dbref = FirebaseDatabase.instance.ref('lavori');

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Crea Nuova Assistenza'),
      ),
      body: SizedBox(
        height: 1500,
        child: Form(
          key: _formKey,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: paddingBetweenRow,
                    child: DropdownButtonFormField<String>(
                      value: marcaValue,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.blue),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        labelText: 'Inserici Marca',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          marcaValue = newValue!;
                          formData['marca'] = marcaValue;
                        });
                      },
                      items: <String>['Apple', 'Samsung', 'Huawei', 'Htc']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: paddingBetweenRow,
                    child: TextFormField(
                      maxLength: 15, //limite massimo dei caratteri
                      onSaved: (value) {
                        formData['modello'] = value;
                      },
                      decoration: const InputDecoration(
                          contentPadding: paddingLabel,
                          border: OutlineInputBorder(),
                          labelText: 'Inserisci il modello',
                          labelStyle: customLabel,
                          counterText:
                              "" //nasconde il limite massimo dei caratteri
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
                      maxLength: 16,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9.,]+'),
                        ),
                      ],
                      // keyboardType: TextInputType.number,

                      onSaved: (value) {
                        formData['imei'] = value;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: paddingLabel,
                          labelText: "Inserisci l'imei",
                          labelStyle: customLabel,
                          counterText: ""),
                      // The validator receives the text that the user has entered.
                      validator: (imei) {
                        if (imei == null || imei.isEmpty) {
                          return 'il nome è obbligatorio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: paddingBetweenRow,
                    child: TextFormField(
                      maxLength: 15,
                      onSaved: (value) {
                        formData['serial'] = value;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: paddingLabel,
                          labelText: 'Inserisci il seriale',
                          labelStyle: customLabel,
                          counterText: ""),
                      // The validator receives the text that the user has entered.
                      validator: (serial) {
                        if (serial == null || serial.isEmpty) {
                          return 'il seriale è obbligatorio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: paddingBetweenRow,
                    child: DropdownButtonFormField<String>(
                      value: problemValue,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.blue),
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        labelText: 'Che problema presenta?',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          problemValue = newValue!;
                          formData['problema'] = problemValue;
                        });
                      },
                      items: <String>[
                        'Batteria',
                        'Lcd rotto',
                        'vetro rotto',
                        'Huawei',
                        'Speaker orecchio',
                        'Volume',
                        'Sistema Operativo',
                        'Connettore di Ricarica'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: paddingBetweenRow,
                    child: TextFormField(
                      onSaved: (value) {
                        formData['note'] = value;
                      },
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Note(spiega il problema riscontrato)',
                        labelStyle: customLabel,
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (note) {
                        if (note == null || note.isEmpty) {
                          return 'Il campo note è obbligatorio';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      children: [
                        TextButton(
                          // here toggle the bool value so that when you click
                          // on the whole item, it will reflect changes in Checkbox
                          onPressed: () => setState(() => {
                                warrantyCheck = !warrantyCheck,
                                formData['garanzia'] = warrantyCheck
                              }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 0,
                                        width: 50.0,
                                        child: Checkbox(
                                          value: warrantyCheck,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                warrantyCheck = value!;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      // You can play with the width to adjust your
                                      // desired spacing
                                      const SizedBox(width: 10.0),
                                      const Text("Garanzia")
                                    ],
                                  )
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  uploadFile();
                                },
                                child: const Text('Allega foto'),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                  // here toggle the bool value so that when you click
                                  // on the whole item, it will reflect changes in Checkbox
                                  onPressed: () => setState(() => {
                                        waterCheck = !waterCheck,
                                        formData['acqua'] = waterCheck
                                      }),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 0.0,
                                        width: 50.0,
                                        child: Checkbox(
                                          value: waterCheck,
                                          onChanged: (value) {
                                            setState(() {
                                              waterCheck = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      // You can play with the width to adjust your
                                      // desired spacing
                                      const SizedBox(width: 10.0),
                                      const Text("Ha preso acqua")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  FutureBuilder(
                                    future: storage.downloadURL(
                                        'IMG_0001.JPG', finalNumberTkt),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return SizedBox(
                                            width: 70,
                                            height: 50,
                                            child: Image.network(
                                              snapshot.data!,
                                              fit: BoxFit.cover,
                                            ));
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      return Container();
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber[800],
                              ),
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Richiesta inviata'),
                                        ),
                                      );
                                      DatabaseReference nuovoLavoro =
                                          dbref.push();
                                      nuovoLavoro.set({
                                        "imei": formData['imei'],
                                        "serial": formData['serial'],
                                        "marca": formData['marca'],
                                        "modello": formData['modello'],
                                        "note": formData['note'],
                                        "id": finalNumberTkt,
                                        "garanzia": formData['garanzia'],
                                        "acqua": formData['acqua'],
                                        "status": statusTck,
                                        "foto": _photoLoaded,
                                        "data": getDateToday(),
                                      });
                                    }

                                    Navigator.of(context).pop();
                                  } on SocketException catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Nessuna Connessione'),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
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
                              finalNumberTkt,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
