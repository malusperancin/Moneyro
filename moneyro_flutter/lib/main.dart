import 'package:flutter/material.dart';
import 'package:Moneyro/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Color.fromRGBO(236, 179, 24, 1.0), //amarelo
        backgroundColor: Color.fromRGBO(67, 67, 67, 1.0), //cinza
        primaryColorDark: Color.fromRGBO(12, 65, 111, 0.9),
        primaryColorLight: Color.fromRGBO(11, 83, 148, 1)), //azul
      home: HomeScreen(),
    );
  }
}
