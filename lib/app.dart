import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/pages/welcomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.isAuthenticated});

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isAuthenticated ? const WelcomePage() : MainPage(),
      );
}
