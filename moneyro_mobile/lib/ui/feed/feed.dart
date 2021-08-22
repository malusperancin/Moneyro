import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/conteudo_model.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {
  List<Conteudo> conteudos = [];

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    conteudos = [];

    await APIServices.getConteudos(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        conteudos = list.map((model) => Conteudo.fromObject(model)).toList();
      }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[]));
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
