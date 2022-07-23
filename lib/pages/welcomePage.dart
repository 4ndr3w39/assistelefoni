import 'package:flutter/material.dart';
import 'package:my_app/misc/clippers/oval_top_border_clipper.dart';
import 'package:my_app/pages/registerPage.dart';

import 'login_page_new.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            _imageWidget(),
            _actionWidget(context),
          ],
        ),
      );

  _imageWidget() => Positioned(
      left: 0,
      bottom: 50,
      right: 0,
      top: 0,
      child: Container(
        color: Colors.amber[800],
        child: Image.asset(
          'assets/images/home3.png',
          fit: BoxFit.fitHeight,
        ),
      ));

  _actionWidget(BuildContext context) => Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: ClipPath(
          clipper: OvalTopBorderClipper(),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Gestisci le assistenze',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: ' dal tuo smartphone',
                          style: TextStyle(
                            color: Colors.amber[800],
                          ),
                        )
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Gestisci i tuoi clienti, crea nuove assistenze e stampa',
                    textAlign: TextAlign.center,
                  ),
                ),
                const ButtonWelcomePage(title: 'Log in', logIn: true),
                const ButtonWelcomePage(title: 'Registrati', logIn: false),
              ],
            ),
          ),
        ),
      );
}

class ButtonWelcomePage extends StatelessWidget {
  final String title;
  final bool logIn;
  const ButtonWelcomePage({
    Key? key,
    required this.title,
    required this.logIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (logIn) {
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPageNew(),
            ),
          );
        },
        child: Text(title),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            primary: Colors.transparent,
            shadowColor: Colors.transparent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              // TODO alternativa a MaterialPageRoute
              // PageRouteBuilder(
              //   pageBuilder: (context, a1, a2) => const FirstRoute(),
              //   transitionsBuilder: (context, a1, a2, child) =>
              //       FadeTransition(
              //     opacity: a1,
              //     child: child,
              //   ),
              //   transitionDuration: const Duration(
              //     milliseconds: 300,
              //   ),
              // )
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          },
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
      );
    }
  }
}
