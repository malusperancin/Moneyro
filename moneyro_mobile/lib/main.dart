import 'package:flutter/material.dart';
import 'package:moneyro_mobile/ui/amigos/amigos.dart';
import 'package:moneyro_mobile/ui/cofre/cofre.dart';
import 'package:moneyro_mobile/ui/feed/feed.dart';
import 'package:moneyro_mobile/ui/home.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(MyApp());
}

/*
* deixar bonitx
* colocar icone,
* tela de carregamento,
* tap page la em cima pois mt feia está
* algo no menu sla, mudar a cor, botas umas bordas umas sombrax
*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          buttonColor: Color.fromRGBO(236, 165, 24, 1.0), //amarelo
          backgroundColor: Color.fromRGBO(67, 67, 67, 1.0), //cinza
          //primaryColorDark: Color.fromRGBO(12, 65, 111, 1), // azulao
          primaryColorDark: Color.fromRGBO(25, 22, 87, 1), // roxao
          //primaryColorLight: Color.fromRGBO(11, 83, 148, 1)), //azulzin
          primaryColorLight: Color.fromRGBO(69, 64, 173, 1)), // roxin

      home: HomeScreen(),
    );
  }
}
