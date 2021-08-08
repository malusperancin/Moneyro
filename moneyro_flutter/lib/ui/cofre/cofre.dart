import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:url_launcher/url_launcher.dart';

class CofreScreen extends StatefulWidget {
  CofreScreen({Key key}) : super(key: key);

  @override
  _CofrePageState createState() => _CofrePageState();
}

class _CofrePageState extends State<CofreScreen> {
  final _url = 'http://localhost:8080/#/compra';
  var nome;
  var cofre = false;
  var quantia = 7;

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    nome = await FlutterSession().get('nome');
    return true;
  }

  /*
    sattus1: nao tem cofre
    2: tem 0 - 5
    3: ok 5 - 10
    4: uau 10 - 15
    5: rei 15 - infinito
  */

  Widget getSituacao() {
    return SizedBox(
        width: 300,
        height: 300,
        child: quantia < 5
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset("images/status2.png"))
            : quantia < 10
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("images/status3.png"))
                : quantia < 15
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("images/status4.png"))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("images/status5.png")));
  }

  Widget cabecalho(titulo) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Expanded(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0, 0, 4.0),
                              child: Text(titulo,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35,
                                      fontFamily: 'Malu',
                                      color: Colors.white))),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green[500],
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(Icons.point_of_sale_rounded),
                              iconSize: 25,
                            ),
                          )
                        ])))));
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
                child: Column(children: <Widget>[
                  cabecalho("Cofre"),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Não tem cofre
                      Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Row(children: <Widget>[
                            Image.asset(
                              "images/status11.png",
                              fit: BoxFit.cover,
                              width: 300,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text("Humn que pena...",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 35,
                                            fontFamily: 'Malu',
                                            color: Colors.white))),
                                Expanded(
                                    child: Text(
                                        "Você precisa de um cofre para usar esta aba",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            fontFamily: 'Malu',
                                            color: Colors.white)))
                              ],
                            ),
                          ])),
                      //Comprar cofre
                      Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Text(
                                  "Caso queira adquirir um, este botão te levará direto para nossa loja",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      fontFamily: 'Malu',
                                      color: Colors.white)),
                            ),
                            SizedBox(width: 5.0),
                            ElevatedButton(
                                child: Text(
                                  "Comprar",
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).buttonColor,
                                  textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Malu'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  _launchURL();
                                }),
                          ]))
                    ],
                  )),
                ]));
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
