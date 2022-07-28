import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/fire_auth.dart';
import 'package:my_app/utils/validator.dart';
import '../main.dart';

// Define a custom Form widget.

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[800],
          // Here we take the value from the MainPage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),
        body: Column(
          children: <Widget>[
            Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red.shade800,
                            const Color(0xFFf5851f)
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/images/register.jpg',
                              width: 100,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.6,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          emailField(context),
                          passwordField(context),
                          nameField(context),
                          birthdateField(context),
                          const Spacer(),
                          submitButton(context)
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget emailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        controller: _emailTextController,
        focusNode: _focusEmail,
        validator: (value) => Validator.validateEmail(
          email: value,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.email,
            color: Colors.red[800],
          ),
          hintText: 'Email',
        ),
      ),
    );
  }

  Widget nameField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        controller: _nameTextController,
        focusNode: _focusName,
        validator: (value) => Validator.validateName(
          name: value,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.account_box,
            color: Colors.red[800],
          ),
          hintText: 'Nome e Cognome',
        ),
      ),
    );
  }

  Widget birthdateField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.calendar_month,
            color: Colors.red[800],
          ),
          hintText: 'Data di Nascita',
        ),
      ),
    );
  }

  Widget passwordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        controller: _passwordTextController,
        focusNode: _focusPassword,
        obscureText: true,
        validator: (value) => Validator.validatePassword(
          password: value,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.vpn_key,
            color: Colors.red[800],
          ),
          hintText: 'Password',
        ),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return _isProcessing
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red[800],
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 34,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () async {
              setState(() {
                _isProcessing = true;
              });

              if (_registerFormKey.currentState!.validate()) {
                User? user = await FireAuth.registerUsingEmailPassword(
                    name: _nameTextController.text,
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
                            )),
                    ModalRoute.withName('/'),
                  );
                }
              }
            },
            child: const Text(
              'Sign up',
              style: TextStyle(color: Colors.white),
            ),
          );
  }
}
