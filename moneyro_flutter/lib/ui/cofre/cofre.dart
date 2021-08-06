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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                        /*
                        sattus1: nao tem cofre
                        2: tem 0 - 5
                        3: ok 5 - 10
                        4: uau 10 - 15
                        5: rei 15 - infinito
                      */
                        child: cofre
                            ?
                            // tem cofre
                            Column(children: <Widget>[
                                Text("Cofre",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 60,
                                        fontFamily: 'Malu')),
                                Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: quantia < 5
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.asset(
                                                    "images/status2.png"))
                                            : quantia < 10
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Image.asset(
                                                        "images/status3.png"))
                                                : quantia < 15
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.asset(
                                                            "images/status4.png"))
                                                    : quantia >= 15
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            child: Image.asset(
                                                                "images/status5.png"))
                                                        : quantia))
                              ])
                            // não tem cofre
                            : Column(children: <Widget>[
                                Text("Cofre",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 60,
                                        fontFamily: 'Malu')),
                                Text("Você ainda não possui um cofre",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30,
                                        fontFamily: 'Malu')),
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                            "images/status11.png"))),
                                Padding(
                                  padding: EdgeInsets.all(50.0),
                                  child: ElevatedButton(
                                      child: Text("Comprar um cofre"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).buttonColor,
                                        textStyle: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                      onPressed: () {
                                        _launchURL();
                                      }),
                                )
                              ]))));
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
