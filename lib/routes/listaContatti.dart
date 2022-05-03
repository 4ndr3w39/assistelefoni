import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ListaContatti extends StatefulWidget {
  const ListaContatti({Key? key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
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

class Contact {
  final String birthday;
  final int id;
  final String title;
  final String nickname;
  final String url;
  final String thumbnailUrl;

  const Contact({
    required this.birthday,
    required this.nickname,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      birthday: json['birthday'] as String,
      nickname: json['nickname'] as String,
      id: json['char_id'] as int,
      title: json['name'] as String,
      url: json['img'] as String,
      thumbnailUrl: json['img'] as String,
    );
  }
}

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 110,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.album),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(contacts[index].thumbnailUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(contacts[index].title),
                  // subtitle: Text(contacts[index].birthday),
                  trailing: TextButton(
                    child: const Text('Vedi'),
                    onPressed: () {/* ... */},
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
          ),
        );
      },
    );
  }
}

class _CharacterListState extends State<ListaContatti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Lista Contatti'),
      // ),
      // body: Container(child: const Contact()),
      body: FutureBuilder<List<Contact>>(
        future: fetchContacts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
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
