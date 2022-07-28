import 'package:flutter/material.dart';
import 'package:my_app/classes/contatto.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Profilo'),
      ),
      body: (Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey.shade200,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(contact.thumbnailUrl),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              children: [
                TableRow(children: [
                  const Text('Nome'),
                  Text(contact.nickname),
                ]),
                TableRow(children: [
                  const Text('Compleanno'),
                  Text(contact.birthday),
                ]),
                TableRow(children: [
                  const Text('Email'),
                  Text(
                    contact.id.toString(),
                  ),
                ]),
                TableRow(
                  children: [
                    const Text('Stato Email'),
                    Text(contact.name),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
