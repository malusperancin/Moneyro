import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class MaisScreen extends StatefulWidget {
  MaisScreen({Key key}) : super(key: key);

  @override
  _MaisPageState createState() => _MaisPageState();
}

class _MaisPageState extends State<MaisScreen> {


  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Container(
                child: Text('mais'),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width
              )
            );
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        }
      );
  }
}
