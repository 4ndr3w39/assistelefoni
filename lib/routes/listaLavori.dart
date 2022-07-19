import 'dart:convert';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/modal/modalUpdate.dart';

class ListaLavori extends StatefulWidget {
  const ListaLavori({Key? key}) : super(key: key);
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<ListaLavori> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("lavori");
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
                  left: 10.0,
                  top: 15,
                  child: Container(
                    height: 20.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color:
                          (snapshot.value! as Map)['status'] == 'NON RIPARABILE'
                              ? Colors.red
                              : const Color.fromARGB(255, 255, 143, 0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        (snapshot.value! as Map)['id'].toString().toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  top: 15,
                  child: Container(
                    height: 20.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color:
                          (snapshot.value! as Map)['status'] == 'NON RIPARABILE'
                              ? Colors.red
                              : const Color.fromARGB(255, 255, 143, 0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        (snapshot.value! as Map)['status']
                            .toString()
                            .toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    side: (snapshot.value! as Map)['status'] == 'NON RIPARABILE'
                        ? const BorderSide(color: Colors.red, width: 2.0)
                        : BorderSide.none,
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(top: 35, right: 10, left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
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
                  right: 130.0,
                  top: 30,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                        child: Column(
                          children: [
                            ((snapshot.value! as Map)['acqua'] == null ||
                                    (snapshot.value! as Map)['acqua'] == false)
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.water_drop_rounded,
                                      size: 20,
                                      color: Color.fromARGB(255, 195, 210, 238),
                                    ),
                                  )
                                : IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.water_drop_rounded,
                                      color: Color.fromARGB(255, 18, 101, 234),
                                    ),
                                    tooltip: 'Danno da liquido',
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        child: Column(
                          children: [
                            ((snapshot.value! as Map)['garanzia'] == null ||
                                    (snapshot.value! as Map)['garanzia'] ==
                                        false)
                                ? const Icon(
                                    Icons.warning_rounded,
                                    size: 20,
                                    color: Color.fromARGB(255, 195, 210, 238),
                                  )
                                : IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.warning_rounded,
                                      color: Color.fromARGB(255, 18, 101, 234),
                                    ),
                                    tooltip: 'In garanzia',
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Column(
                          children: [
                            ((snapshot.value! as Map)['garanzia'] == null ||
                                    (snapshot.value! as Map)['garanzia'] ==
                                        false)
                                ? const Icon(
                                    Icons.image_rounded,
                                    size: 20,
                                    color: Color.fromARGB(255, 195, 210, 238),
                                  )
                                : IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.image_rounded,
                                      color: Color.fromARGB(255, 18, 101, 234),
                                    ),
                                    tooltip: 'Foto allegate',
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    right: 10.0,
                    top: 40,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 255, 143, 0),
                              size: 20,
                            ),
                            onPressed: () {
                              updateDatajobs((snapshot.value! as Map)['status'],
                                  context, snapshot.key, ref);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.perm_device_info_outlined,
                              color: Color.fromARGB(255, 255, 143, 0),
                              size: 20,
                            ),
                            onPressed: () {
                              updateDatajobs((snapshot.value! as Map)['status'],
                                  context, snapshot.key, ref);
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTitle(snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
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
        ],
      ),
    );
  }

  Widget _bodyDetail(snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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

  // updateData(String status, var key) {
  //   Map<String, String> data = {"status": status};
  //   ref.child(key).update(data);
  // }
}
