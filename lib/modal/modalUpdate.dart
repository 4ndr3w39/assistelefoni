import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/updateDb.dart';

Future<void> updateDatajobs(
    String status, BuildContext context, var key, DatabaseReference ref) {
  var statusController = TextEditingController(text: status);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 200, horizontal: 30),
        title: const Text('Prendi in carico assistenza'),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: statusController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Status"),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                updateData(statusController.text, key, ref);
                Navigator.of(context).pop();
              },
              child: const Text('Aggiorna')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla')),
        ],
      );
    },
  );
}
