import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

import '../utils/fire_auth.dart';
import '../utils/validator.dart';

class LoginPageNew extends StatefulWidget {
  const LoginPageNew({Key? key}) : super(key: key);

  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyResetPassword = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _emailTextControllerResend = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusEmailResend = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future resetPassword(context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email Inviata'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException {
      Navigator.of(context).pop();
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainPage(
            user: user,
          ),
        ),
        (route) => false,
      );
    }

    return firebaseApp;
  }

  @override
  void dispose() {
    _emailTextControllerResend.dispose();
    super.dispose();
  }

  Future<void> openModalResend() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKeyResetPassword,
          child: AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            title: const Text('Reimposta password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _emailTextController,
                  // focusNode: _focusEmailResend,
                  validator: (value) => Validator.validateEmail(
                    email: value,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  resetPassword(context);
                },
                child: const Text('Invia'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annulla'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber[800],
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Form(
                      key: _formKeyLogin,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.amber.shade800,
                                  const Color(0xFFf5851f)
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(90),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/login.png',
                                    width: 150,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2.6,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 40),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 32.0, right: 32),
                              child: Column(
                                children: <Widget>[
                                  emailField(context),
                                  const SizedBox(height: 20),
                                  passwordField(context),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, right: 20),
                                        // child: ElevatedButton(
                                        //   onPressed: openModalResend,
                                        //   child:
                                        //       const Text('Password dimenticata?'),
                                        // ),
                                        child: GestureDetector(
                                          onTap: openModalResend,
                                          child: const Text(
                                              'Password dimenticata?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _isProcessing
                              ? const CircularProgressIndicator()
                              : submitButton(context)
                        ],
                      ),
                    )
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget emailField(BuildContext context) {
    return TextFormField(
      controller: _emailTextController,
      focusNode: _focusEmail,
      validator: (value) => Validator.validateEmail(
        email: value,
      ),
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.amber[800],
        ),
        hintText: 'Email',
      ),
    );
  }

  Widget passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordTextController,
      focusNode: _focusPassword,
      obscureText: true,
      validator: (value) => Validator.validatePassword(
        password: value,
      ),
      decoration: InputDecoration(
        icon: Icon(
          Icons.vpn_key,
          color: Colors.amber[800],
        ),
        hintText: 'Password',
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.amber[800],
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 34,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        'Login'.toUpperCase(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      onPressed: () async {
        _focusEmail.unfocus();
        _focusPassword.unfocus();

        if (_formKeyLogin.currentState!.validate()) {
          setState(() {
            _isProcessing = true;
          });

          User? user = await FireAuth.signInUsingEmailPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text,
              context: context);

          setState(() {
            _isProcessing = false;
          });

          if (user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainPage(
                  user: user,
                ),
              ),
              (route) => false,
            );
          }
        }
      },
    );
  }
}
