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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('colonna'),
          const Text('colonna'),
          Expanded(
            child: Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text('Elemento 2'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Elemento 1'),
              Text('Elemento 2'),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  width: 10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text('Elemento 3'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
