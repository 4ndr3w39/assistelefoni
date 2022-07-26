import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Ciao'),
      ),
    );
  }
}
