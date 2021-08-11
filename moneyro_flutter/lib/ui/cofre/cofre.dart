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
  var cofre = true;
  var conectado = true;
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

  Widget cabecalho(titulo, icone, cor) {
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
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
                                color: cor,
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(icone),
                              iconSize: 28,
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
                  cabecalho("Cofre", Icons.savings_rounded, Colors.green[500]),
                  Expanded(
                      child: cofre
                          ? conectado
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("tela normal")
                                  ])
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/images/status11.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    Text("Cofre desconectado",
                                        style: TextStyle(
                                            height: 0.8,
                                            fontWeight: FontWeight.w100,
                                            fontSize: 18,
                                            fontFamily: 'Malu',
                                            color: Colors.black45)),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    ElevatedButton(
                                        child: Text(
                                          "Conectar",
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).buttonColor,
                                          textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Malu'),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        onPressed: () {
                                          _launchURL();
                                        })
                                  ],
                                )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Não tem cofre
                                Container(
                                  color: Theme.of(context).backgroundColor,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Row(children: <Widget>[
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Humn que pena...",
                                                    style: TextStyle(
                                                        height: 0.8,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 40,
                                                        fontFamily: 'Malu',
                                                        color: Colors.white)),
                                                Text(
                                                    "Você precisa de um cofre para usar esta aba",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18,
                                                        fontFamily: 'Malu',
                                                        color: Colors.white))
                                              ],
                                            )),
                                        Image.asset(
                                            'assets/images/status11.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55),
                                      ])),
                                ),
                                //Comprar cofre
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 50),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            "Caso queira adquirir um, este botão te levará direto para nossa loja",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Malu',
                                                color: Colors.white,
                                                height: .9)),
                                      ),
                                      SizedBox(width: 6.0),
                                      ElevatedButton(
                                          child: Text(
                                            "Comprar",
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).buttonColor,
                                            textStyle: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Malu'),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          onPressed: () {
                                            _launchURL();
                                          })
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
