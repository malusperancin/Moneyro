import 'dart:convert';

import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/situacao_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:Moneyro/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:soundpool/soundpool.dart';

class CofreScreen extends StatefulWidget {
  CofreScreen({Key key}) : super(key: key);

  @override
  _CofrePageState createState() => _CofrePageState();
}

class _CofrePageState extends State<CofreScreen> {
  final _url = 'http://localhost:8080/#/compra';
  Usuario usuario;
  var conectado = true;
  Situacao situacao;

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    await APIServices.getUsuario(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        usuario = new Usuario.fromObject(json.decode(response.body));
      }
    });

    await APIServices.getSituacoes().then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        List<Situacao> listaSituacao =
            list.map((model) => Situacao.fromObject(model)).toList();

        if (usuario.cofre > 15) situacao = listaSituacao[9];
        if (usuario.cofre <= 15) situacao = listaSituacao[8];
        if (usuario.cofre <= 10) situacao = listaSituacao[7];
        if (usuario.cofre <= 5) situacao = listaSituacao[6];
      }
    });

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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      color: Color(
          int.parse(situacao.cor.substring(1, 7), radix: 16) + 0xFF000000),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            right: -35,
            child: Image.asset(
                usuario.cofre < 5
                    ? "assets/images/status2.png"
                    : usuario.cofre < 10
                        ? "assets/images/status3.png"
                        : usuario.cofre < 15
                            ? "assets/images/status4.png"
                            : "assets/images/status5.png",
                width: MediaQuery.of(context).size.width * 0.55),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 30, bottom: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Quantia no cofre:",
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          fontFamily: 'Malu',
                          color: Colors.white)),
                  Text(
                      "R\$" +
                          usuario.cofre.toStringAsFixed(2).replaceAll(".", ","),
                      style: TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w700,
                          fontSize: 60,
                          fontFamily: 'Malu2',
                          color: Colors.white)),
                  Text(situacao.mensagem.toString(),
                      style: TextStyle(
                        height: 1.2,
                        fontWeight: FontWeight.w300,
                        fontSize: 22,
                        fontFamily: 'Malu',
                        color: Colors.white,
                      ))
                ]),
          ),
        ],
      ),
    );
  }

  _showMyDialog(double valor) {
    // playSom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pop();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Image.asset("assets/images/alerta.png"),
            Positioned(
              bottom: 90,
              right: 110,
              child: Text("\¢$valor",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 70,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
            )
          ]),
        );
      },
    );
  }

  Widget getDesconectado() {
    return Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset('assets/images/cofre_desconectado.png',
                    width: MediaQuery.of(context).size.width * 0.4),
                Text("Cofre desconectado!",
                    style: TextStyle(
                        height: 0.8,
                        fontWeight: FontWeight.w100,
                        fontSize: 18,
                        fontFamily: 'Malu',
                        color: Colors.black45)),
              ],
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
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {})
          ],
        ));
  }

  Widget getCard() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFF545454)),
        padding: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "R\$" + usuario.saldo.toStringAsFixed(2).replaceAll(".", ","),
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
                            width: 42,
                            height: 42,
                            child:
                                Icon(Icons.edit_rounded, color: Colors.white)),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: Container(child: Text("Cancelar")),
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
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          right: 10.0,
          left: 20.0,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 5))
            ],
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(100)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 38,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
              Container(
                  decoration: BoxDecoration(
                      color: cor, borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(icone),
                      iconSize: 32))
            ]));
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
              cabecalho("Cofre", Icons.savings_rounded, Colors.blue[500]),
              Expanded(
                  child: usuario.cofre >= 0.0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              getSituacao(),
                              conectado
                                  ? MaterialButton(
                                      child: Text("mostrar"),
                                      onPressed: () {
                                        _showMyDialog(5);
                                      })
                                  : getDesconectado()
                            ])
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Não tem cofre
                            Expanded(
                              child: Container(
                                color: Theme.of(context).backgroundColor,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    child: Image.asset(
                                        'assets/images/status1.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55),
                                    right: -25,
                                    top: -25,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
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
                                                  fontFamily: 'Malu2',
                                                  color: Colors.white)),
                                          Text(
                                              "Você precisa de um cofre para usar esta aba",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  fontFamily: 'Malu',
                                                  color: Colors.white))
                                        ],
                                      )),
                                ]),
                              ),
                            ),
                            //Comprar cofre
                            Container(
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
                                      onPressed: () {
                                        _launchURL();
                                      })
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

  Future<void> playSom() async {
    Soundpool pool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle
        .load("assets/sounds/bemtevi.mp4")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
}
