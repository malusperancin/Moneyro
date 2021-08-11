import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanilhaScreen extends StatefulWidget {
  PlanilhaScreen({Key key}) : super(key: key);

  @override
  _PlanilhaPageState createState() => _PlanilhaPageState();
}

class _PlanilhaPageState extends State<PlanilhaScreen> {


  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui

    return true;
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
                  cabecalho("Planilha", Icons.reorder_rounded, Colors.amber[500])
                ]));
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        }
      );
  }
}
