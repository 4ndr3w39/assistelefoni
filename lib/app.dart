import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/pages/welcomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isAuthenticated
            ? const WelcomePage()
            : MainPage(
                user: null,
              ),
      );
}
