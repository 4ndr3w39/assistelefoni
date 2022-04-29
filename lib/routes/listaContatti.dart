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

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://breakingbadapi.com/api/characters'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String birthday;
  final int id;
  final String title;
  final String nickname;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.birthday,
    required this.nickname,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      birthday: json['birthday'] as String,
      nickname: json['nickname'] as String,
      id: json['char_id'] as int,
      title: json['name'] as String,
      url: json['img'] as String,
      thumbnailUrl: json['img'] as String,
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 160,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return SizedBox(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.album),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(photos[index].thumbnailUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(photos[index].title),
                  subtitle: Text(photos[index].birthday),
                  // trailing: Text(photos[index].nickname),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('LISTEN'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
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
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar: const BottomAppBar(),
    );
  }
}
