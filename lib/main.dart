import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app.dart';
import 'package:my_app/routes/home.dart';
import 'package:my_app/routes/listaContatti.dart';
import 'package:my_app/routes/listaLavori.dart';
import 'package:my_app/components/nuovaAssistenza.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/routes/settings.dart';
import 'package:my_app/utils/local_auth.dart';
import 'firebase_options.dart';
import 'package:my_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticated = await AuthService.authenticateUser();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  if (isAuthenticated) {
    runApp(MyApp(
      isAuthenticated: isAuthenticated,
    ));
  } else {
    exit(0);
  }
  // runApp(
  //   const MyApp(),
  // );
}

class MainPage extends StatefulWidget {
  late User user;

  MainPage({Key? key, User? user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainPage> createState() => _MainPageState();
}

// class FirstRoute extends StatelessWidget {
//   FirstRoute({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MainPage();
//   }
// }

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final User user;

  var screens = [
    const Home(),
    const ListaContatti(),
    ListaLavori(),
    const Settings(),
  ];

  _onItemTapped(int index) {
    setState(() {
      // change _selectedIndex, fab will show or hide
      _selectedIndex = index;
      // change app bar title
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.red[300],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contatti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot_outlined),
            label: 'Lavori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Opzioni',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NuovaAssistenza(
                      imei: '',
                      marca: '',
                      modello: '',
                      note: '',
                      serial: '',
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.amber[800],
            )
          : null,
    );
  }
}
