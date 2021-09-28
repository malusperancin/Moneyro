import 'dart:convert';

import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/usuario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:Moneyro/ui/appBar/Cabecalho.dart';

import '../../login.dart';

class MaisScreen extends StatefulWidget {
  MaisScreen({Key key}) : super(key: key);

  @override
  _MaisPageState createState() => _MaisPageState();
}

class _MaisPageState extends State<MaisScreen> {
  Usuario usuario;

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    if (usuario == null)
      await APIServices.getUsuario(await FlutterSession().get('id'))
          .then((response) {
        if (response.statusCode == 200) {
          usuario = new Usuario.fromObject(json.decode(response.body));
        }
      });

    print(4);

    return true;
  }

  void sairSessao() async {
    await FlutterSession().set("id", -1);

    Navigator.push(
        context, MaterialPageRoute(builder: (_context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Cabecalho(
                    titulo: "Você",
                    icone: Icons.face_rounded,
                    cor: Colors.cyan[500]),
                // INFORMAÇÕES DO USUARIO
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF545454),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                              flex: 2,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset(
                                    "assets/images/perfil" +
                                        usuario.foto.toString() +
                                        ".png",
                                  ))),
                          Flexible(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(usuario.apelido,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25,
                                            fontFamily: 'Malu2',
                                            color: Colors.white)),
                                    Text(usuario.nome,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            height: 0.8,
                                            fontFamily: 'Malu',
                                            color: Colors.white)),
                                    Text(usuario.email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            height: 1,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Malu',
                                            color: Colors.white)),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        child: SizedBox(
                          height: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("R\$",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      fontFamily: 'Malu2',
                                      color: Color(0xFF69CC47))),
                              Text(
                                  usuario.saldo
                                      .toStringAsFixed(2)
                                      .replaceAll(".", ","),
                                  style: TextStyle(
                                      height: 0.8,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 55,
                                      fontFamily: 'Malu2',
                                      color: Color(0xFF69CC47)))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(usuario.pontos.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 55,
                                      height: 0.9,
                                      fontFamily: 'Malu2',
                                      color: Color(0xFF6775F0))),
                              Text("Pontos",
                                  style: TextStyle(
                                      height: 0.5,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25,
                                      fontFamily: 'Malu2',
                                      color: Color(0xFF6775F0)))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: MaterialButton(
                    color: Color(0xFF545454),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: () {
                      sairSessao();
                    },
                    child: Row(
                      children: [
                        Text("Sair",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                fontFamily: 'Malu2',
                                color: Colors.redAccent)),
                        Spacer(),
                        Icon(Icons.exit_to_app_rounded,
                            color: Colors.redAccent, size: 35)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100)
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
