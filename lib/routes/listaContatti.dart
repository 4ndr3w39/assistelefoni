import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:my_app/pages/detailPage.dart';

import '../classes/contatto.dart';

class ListaContatti extends StatefulWidget {
  const ListaContatti({Key? key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<ListaContatti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Lista Contatti'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Contact>>(
        future: fetchContacts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Errore....'),
            );
          } else if (snapshot.hasData) {
            return ContactsList(contacts: snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.amber[800],
              ),
            );
          }
        },
      ),
      // bottomNavigationBar: const BottomAppBar(),
    );
  }
}

Future<List<Contact>> fetchContacts(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://breakingbadapi.com/api/characters'));

  // Use the compute function to run parseContacts in a separate isolate.
  return compute(parseContacts, response.body);
}

// A function that converts a response body into a List<Contact>.
List<Contact> parseContacts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 80,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                // leading: Icon(Icons.album),
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(contacts[index].thumbnailUrl),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(contacts[index].name),
                // subtitle: Text(contacts[index].birthday),
                trailing: TextButton(
                  child: const Text('Vedi'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          contact: contacts[index],
                        ),
                      ),
                    );
                  },
                ),
                // trailing: Text(contacts[index].nickname),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     TextButton(
              //       child: const Text('BUY TICKETS'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //     TextButton(
              //       child: const Text('LISTEN'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
