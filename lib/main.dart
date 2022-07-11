import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app.dart';
import 'package:my_app/routes/home.dart';
import 'package:my_app/routes/listaContatti.dart';
import 'package:my_app/routes/listaLavori.dart';
import 'package:my_app/routes/nuovaAssistenza.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/pages/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({required this.user});

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

  // TODO perchè final?
  final screens = [
    Home(),
    const ListaContatti(),
    const ListaLavori(),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.amber[800],
      //   title: const Text('Assistelefoni'),
      //   // Here we take the value from the MainPage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      // ),
      body: screens[_selectedIndex],
      // Container(
      //   padding: const EdgeInsets.all(30.0),
      //   child: GestureDetector(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const ListaContatti(),
      //         ),
      //       );
      //     },
      //     child: Column(
      //       children: <Widget>[
      //         const Text(
      //           'Contatti',
      //           textAlign: TextAlign.center,
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         IconButton(
      //           iconSize: 150,
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const ListaContatti(),
      //               ),
      //             );
      //           },
      //           icon: const Icon(
      //             IconData(0xe042,
      //                 fontFamily: 'MaterialIcons', matchTextDirection: true),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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




// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Authentication',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             textStyle: TextStyle(
//               fontSize: 24.0,
//             ),
//             padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
//           ),
//         ),
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 46.0,
//             color: Colors.blue.shade700,
//             fontWeight: FontWeight.w500,
//           ),
//           bodyText1: TextStyle(fontSize: 18.0),
//         ),
//       ),
//       home: WelcomePage(),
//     );
//   }
// }
