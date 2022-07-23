import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NuoveAssistenze extends StatefulWidget {
  const NuoveAssistenze({Key? key}) : super(key: key);
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<NuoveAssistenze> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("lavori");
  // late DatabaseReference databaseReference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
        query: ref.orderByChild("status").equalTo('DA CONSEGNARE'),
        shrinkWrap: true,
        defaultChild: const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation animation, int index) {
          var _statusColor =
              (snapshot.value! as Map)['status'] == 'NON RIPARABILE'
                  ? Colors.red
                  : (snapshot.value! as Map)['status'] == 'CONSEGNATO'
                      ? Colors.green
                      : const Color.fromARGB(255, 255, 143, 0);
          var _borderColor =
              (snapshot.value! as Map)['status'] == 'NON RIPARABILE'
                  ? const BorderSide(color: Colors.red, width: 2.0)
                  : (snapshot.value! as Map)['status'] == 'CONSEGNATO'
                      ? const BorderSide(color: Colors.green, width: 2.0)
                      : BorderSide.none;
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
                      color: _statusColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        (snapshot.value! as Map)['id'].toString().toUpperCase(),
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
                    side: _borderColor,
                  ),
                  elevation: 1,
                  margin: const EdgeInsets.only(top: 35, right: 10, left: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: _buildTitle(snapshot),
                    // trailing: const SizedBox(),
                    // children: <Widget>[
                    //   _bodyDetail(snapshot),
                    // ],
                  ),
                ),
                Positioned(
                  right: 20.0,
                  top: 22,
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
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTitle(snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                "Dispositivo: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                (snapshot.value! as Map)['marca'].toString().toUpperCase(),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 2),
              Text((snapshot.value! as Map)['modello'].toString().toUpperCase(),
                  style: const TextStyle(fontSize: 14))
            ],
          ),
          Row(
            children: <Widget>[
              const Text(
                "Imei: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                (snapshot.value! as Map)['imei'].toString().toUpperCase(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
