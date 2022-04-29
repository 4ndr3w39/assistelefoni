import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Contact>> fetchContact(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://breakingbadapi.com/api/characters'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseContacts, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Contact> parseContacts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
}

class Contact {
  final String birthday;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Contact({
    required this.birthday,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      birthday: json['birthday'] as String,
      id: json['char_id'] as int,
      title: json['name'] as String,
      url: json['img'] as String,
      thumbnailUrl: json['img'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Contact>>(
        future: fetchContact(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ContactsList(contact: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key, required this.contact}) : super(key: key);

  final List<Contact> contact;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: contact.length,
      itemBuilder: (context, index) {
        return Image.network(contact[index].thumbnailUrl);
      },
    );
  }
}
