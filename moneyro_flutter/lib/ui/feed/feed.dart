import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {


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
            return Center(
              child: Container(
                child: Text('feed'),
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
