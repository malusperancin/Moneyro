import 'dart:convert';

import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/situacao_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:Moneyro/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CofreScreen extends StatefulWidget {
  CofreScreen({Key key}) : super(key: key);

  @override
  _CofrePageState createState() => _CofrePageState();
}

class _CofrePageState extends State<CofreScreen> {
  final _url = 'http://localhost:8080/#/compra';
  Usuario usuario;
  var cofre = true;
  var conectado = true;
  var quantia = 7;
  List<Situacao> situacoes;
  Situacao situacao;

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    APIServices.getUsuario(await FlutterSession().get('id')).then((response) {
      if (response.statusCode == 200) {
        usuario = new Usuario.fromObject(json.decode(response.body));
      }
    });

    APIServices.getSituacoes().then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        List<Situacao> listaSituacao = [];
        listaSituacao =
            list.map((model) => Situacao.fromObject(model)).toList();
        setState(() {
          situacoes = listaSituacao;
        });

        if (usuario.cofre > 15) situacao = situacoes[9];
        if (usuario.cofre <= 15) situacao = situacoes[8];
        if (usuario.cofre <= 10) situacao = situacoes[7];
        if (usuario.cofre <= 5) situacao = situacoes[6];
        if (usuario.cofre < 0) situacao = situacoes[5];
      }
    });
    quantia >= 0 ? cofre = true : cofre = false;

    NumberFormat formater = NumberFormat.simpleCurrency();
    formater.format(quantia);

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
    /*usuario.saldo
              .toStringAsFixed(2)
              .replaceAll(".", ",")*/
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      color: Color(
          int.parse(situacao.cor.substring(1, 7), radix: 16) + 0xFF000000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Container(
                    padding: EdgeInsets.only(left: 25, top: 30, bottom: 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          usuario.cofre < 0
                              ? SizedBox(width: 6.0)
                              : Text("Quantia no cofre:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                      fontFamily: 'Malu',
                                      color: Colors.white)),
                          usuario.cofre < 0
                              ? SizedBox(width: 6.0)
                              : Text(
                                  "R\$" +
                                      usuario.cofre
                                          .toStringAsFixed(2)
                                          .replaceAll(".", ","),
                                  style: TextStyle(
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 60,
                                      fontFamily: 'Malu2',
                                      color: Colors.white)),
                          Text(situacao.mensagem.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  fontFamily: 'Malu',
                                  color: Colors.white)),
                        ]))),
          ),
          usuario.cofre < 0
              ? Image.asset(
                  "assets/images/status1.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                )
              : usuario.cofre < 5
                  ? Image.asset(
                      "assets/images/status2.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                    )
                  : usuario.cofre < 10
                      ? Image.asset(
                          "assets/images/status3.png",
                          width: MediaQuery.of(context).size.width * 0.5,
                        )
                      : usuario.cofre < 15
                          ? Image.asset(
                              "assets/images/status4.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                            )
                          : Image.asset(
                              "assets/images/status5.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                            )
        ],
      ),
    );
  }

  Widget getCard() {
    return Container(
        padding: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 15),
        color: Color(0xFF545454),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("R\$" + quantia.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 55,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
              SizedBox(height: 20),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.purple[400], // button color
                      child: InkWell(
                        splashColor: Colors.purple[900], // inkwell color
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child:
                                Icon(Icons.edit_rounded, color: Colors.white)),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Cancelar")),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[200]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {}),
                  ElevatedButton(
                      child: Text("Confirmar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow[700],
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                      ),
                      onPressed: () {
                        // faz negocio no banco
                      })
                ],
              ))
            ]));
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
                child: Column(children: <Widget>[
              cabecalho("Cofre", Icons.point_of_sale_rounded, Colors.blue[500]),
              Expanded(
                  child: cofre
                      ? conectado
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[getSituacao(), getCard()])
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/status11.png',
                                    width: MediaQuery.of(context).size.width *
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
                                      primary: Theme.of(context).buttonColor,
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Malu'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {})
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Humn que pena...",
                                                style: TextStyle(
                                                    height: 0.8,
                                                    fontWeight: FontWeight.w900,
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
                                    Image.asset('assets/images/status11.png',
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        primary: Theme.of(context).buttonColor,
                                        textStyle: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Malu'),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () {})
                                ]))
                          ],
                        )),
            ]));
          } else {
            // aqui eh tipo uma tela de espera
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
