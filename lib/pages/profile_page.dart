import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/welcomePage.dart';
import 'package:my_app/utils/storage_service.dart';

import '../utils/fire_auth.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  late User _currentUser;
  final Storage storage = Storage();
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  uploadFile() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('no file selected'),
        ),
      );
      return null;
    }
    final path = results.files.single.path!;
    final fileName = results.files.single.name;

    storage.uploadFile(path, fileName).then((value) => print('Done'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('Profilo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey.shade200,
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/default.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: GestureDetector(
                      onTap: () {
                        uploadFile();
                      },
                      child: Container(
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(Icons.add_a_photo, color: Colors.black),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                50,
                              ),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 4),
                                color: Colors.black.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 3,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Table(
                children: [
                  TableRow(children: [
                    const Text('Nome'),
                    Text('${_currentUser.displayName}'),
                  ]),
                  const TableRow(children: [
                    Text('Ruolo'),
                    Text('//////'),
                  ]),
                  TableRow(children: [
                    const Text('Email'),
                    Text('${_currentUser.email}'),
                  ]),
                  TableRow(
                    children: [
                      const Text('Stato Email'),
                      _currentUser.emailVerified
                          ? Text(
                              'Email verified',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.green),
                            )
                          : Text(
                              'Email not verified',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red),
                            ),
                    ],
                  )
                ],
              ),
            ),
            // Text(
            //   'NAME: ${_currentUser.displayName}',
            //   style: Theme.of(context).textTheme.bodyText1,
            // ),
            // SizedBox(height: 16.0),
            // Text(
            //   'EMAIL: ${_currentUser.email}',
            //   style: Theme.of(context).textTheme.bodyText1,
            // ),
            // SizedBox(height: 16.0),

            const SizedBox(height: 16.0),
            _isSendingVerification
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: const Text('Verify email'),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 16.0),
            _isSigningOut
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                    child: const Text('Sign out'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
            FutureBuilder(
                future: storage.downloadURL('IMG_0002.JPG'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SizedBox(
                        width: 300,
                        height: 250,
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
