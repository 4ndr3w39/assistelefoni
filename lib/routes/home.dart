import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/components/calendarDate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 11.59) {
    return 'Good Morning';
  } else if (timeNow > 12 && timeNow <= 16) {
    return 'Good Afternoon';
  } else if (timeNow > 16 && timeNow < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

getCurrentDate() {
  var dateN = (DateFormat('d MMMM y').format(DateTime.now()));
  return dateN.toString();
}

class _CharacterListState extends State<Home> {
  var hour = DateTime.now().hour;
  var time = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              greetingMessage(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const Text(
            'Andrea',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          // Row(
          //   children: <Widget>[
          //     ElevatedButton(
          //         onPressed: () {
          //           addNuovoLavoro();
          //         },
          //         child: const Text('write'))
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.only(right: 20),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const SizedBox(
                      width: 140,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(13),
                        child: Text(
                          'Lavori in attesa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5.0,
                    top: 0,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: 140,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(13),
                        child: Text(
                          'Da consegnare',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: const Text('Riepilogo Mensile'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(13),
                          child: Text(
                            'Da consegnare',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          CalendarDate(getCurrentDate())
        ],
      ),
    );
  }
}
