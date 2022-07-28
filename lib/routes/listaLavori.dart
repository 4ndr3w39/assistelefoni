import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/modal/modalUpdate.dart';

class ListaLavori extends StatefulWidget {
  const ListaLavori({Key? key}) : super(key: key);

  @override
  State<ListaLavori> createState() => _ListaLavoriState();
}

class _ListaLavoriState extends State<ListaLavori> {
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("lavori");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Lista Lavori'),
        automaticallyImplyLeading: false,
      ),
      body: FirebaseAnimatedList(
        query: userRef.orderByChild('data'),
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
                Positioned(
                  left: 140.0,
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
                        (snapshot.value! as Map)['data']
                            .toString()
                            .toUpperCase(),
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
                      color: _statusColor,
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
                    side: _borderColor,
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(
                      top: 35, right: 10, left: 10, bottom: 5),
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
                                      color: Color.fromARGB(255, 195, 210, 238),
                                    ),
                                  )
                                : IconButton(
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
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.warning_rounded,
                                      color: Color.fromARGB(255, 195, 210, 238),
                                    ),
                                  )
                                : IconButton(
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
                        width: 25,
                        child: Column(
                          children: [
                            ((snapshot.value! as Map)['foto'] == null ||
                                    (snapshot.value! as Map)['foto'] == false)
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.image_rounded,
                                      color: Color.fromARGB(255, 195, 210, 238),
                                    ),
                                  )
                                : IconButton(
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
                                  context, snapshot.key, userRef);
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
                              Icons.delete,
                              color: Color.fromARGB(255, 228, 8, 8),
                              size: 20,
                            ),
                            onPressed: () {
                              deleteJobs(snapshot.key);
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
                  const SizedBox(width: 4),
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
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Color.fromARGB(255, 18, 101, 234),
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
                    const Icon(
                      Icons.key_rounded,
                      size: 20,
                      color: Color.fromARGB(255, 18, 101, 234),
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
                const Icon(
                  Icons.text_snippet_rounded,
                  size: 20,
                  color: Color.fromARGB(255, 18, 101, 234),
                ),
                Expanded(
                  child: Text(
                    (snapshot.value! as Map)['note'].toString().toUpperCase(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  deleteJobs(key) async {
    await userRef.child(key).remove();
  }
}
