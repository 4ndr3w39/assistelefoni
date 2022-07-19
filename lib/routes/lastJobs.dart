import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ListaLavori extends StatefulWidget {
  const ListaLavori({Key? key}) : super(key: key);
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<ListaLavori> {
  late final String query;
  Query ref = FirebaseDatabase.instance
      .ref("lavori")
      .orderByChild('status')
      .equalTo('Nuova');
  late DatabaseReference databaseReference;

  // createQuery() async {
  //   var ref;
  //   if (query == '') {
  //     DatabaseReference ref = FirebaseDatabase.instance.ref("lavori");
  //     late DatabaseReference databaseReference;
  //   } else {
  //     Query ref = FirebaseDatabase.instance
  //         .ref("lavori")
  //         .orderByChild('status')
  //         .equalTo(query);
  //     late DatabaseReference databaseReference;
  //   }
  //   return ref;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Lista Lavori'),
        automaticallyImplyLeading: false,
      ),
      body: FirebaseAnimatedList(
        query: ref,
        shrinkWrap: true,
        defaultChild: const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation animation, int index) {
          if (!snapshot.exists) {
            return const Center(child: Text(' NO DATA'));
          } else {
            return Stack(
              children: <Widget>[
                Positioned(
                  right: 10.0,
                  top: 15,
                  child: Container(
                    width: 110.0,
                    height: 20.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(255, 255, 143, 0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      (snapshot.value! as Map)['id'].toString().toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  elevation: 2,
                  margin: const EdgeInsets.only(top: 35, right: 10, left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        title: _buildTitle(snapshot),
                        trailing: const SizedBox(),
                        children: <Widget>[
                          _bodyDetail(snapshot),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 10.0,
                    top: 30,
                    child: IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 255, 143, 0)),
                      onPressed: () {
                        //  TODO
                      },
                    )),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTitle(snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Dispositivo: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Text(
                    (snapshot.value! as Map)['marca'].toString().toUpperCase(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Text(
                      (snapshot.value! as Map)['modello']
                          .toString()
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 14)),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Stato: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                (snapshot.value! as Map)['status'].toString().toUpperCase(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _bodyDetail(snapshot) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: Column(
                  children: [
                    const Text(
                      "Imei: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (snapshot.value! as Map)['imei'].toString().toUpperCase(),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                child: Column(
                  children: [
                    const Text(
                      "serial: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (snapshot.value! as Map)['serial']
                          .toString()
                          .toUpperCase(),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Acqua: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: [
                          ((snapshot.value! as Map)['acqua'] == null ||
                                  (snapshot.value! as Map)['acqua'] == false)
                              ? SizedBox(
                                  height: 15,
                                  width: 10.0,
                                  child: Checkbox(
                                    tristate: false,
                                    onChanged: (value) {},
                                    value: false,
                                  ),
                                )
                              : SizedBox(
                                  height: 15,
                                  width: 10.0,
                                  child: Checkbox(
                                    tristate: true,
                                    onChanged: (value) {},
                                    value: true,
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Garanzia: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ((snapshot.value! as Map)['garanzia'] == null ||
                              (snapshot.value! as Map)['garanzia'] == false)
                          ? SizedBox(
                              height: 15,
                              width: 10.0,
                              child: Checkbox(
                                tristate: false,
                                onChanged: (value) {},
                                value: false,
                              ),
                            )
                          : SizedBox(
                              height: 15,
                              width: 10.0,
                              child: Checkbox(
                                tristate: true,
                                onChanged: (value) {},
                                value: true,
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Note: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    (snapshot.value! as Map)['note'].toString().toUpperCase(),
                  ),
                )
              ],
            ),
          ),
          // ElevatedButton(
          //   child: const Text('Show Modal Bottom Sheet'),
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       builder: (context) {
          //         return Wrap(
          //           children: const <Widget>[
          //             ListTile(
          //               leading: Icon(Icons.share),
          //               title: Text('Share'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.copy),
          //               title: Text('Copy Link'),
          //             ),
          //             ListTile(
          //               leading: Icon(Icons.edit),
          //               title: Text('Edit'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
