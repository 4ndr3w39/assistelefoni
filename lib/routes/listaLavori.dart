import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaLavori extends StatefulWidget {
  const ListaLavori({Key? key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<ListaLavori> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Lista Lavori'),
      // ),
      body: Center(),
    );
  }
}
