import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/usuario_model.dart';
import 'package:Moneyro/ui/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _url = 'http://localhost:8080/#/cadastro';
  final _apelidoController = TextEditingController();
  final _senhaController = TextEditingController();
  String erro = "";

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  String _erro_login() {
    if (erro != "") return erro;

    return null;
  }

  void iniciar_sessao(Usuario user) async {
    var session = FlutterSession();
    await session.set("id", user.id);
    await session.set("nome", user.nome);
    await session.set("apelido", user.apelido);
    await session.set("email", user.email);
  }

  void _login() {
    Usuario usuario = new Usuario(
        1,
        'Teste',
        _apelidoController.text,
        'a@a.c',
        '999',
        new DateTime(2004, 2, 12),
        '2',
        _senhaController.text,
        'cidade',
        'SP',
        false,
        true,
        5.0,
        false,
        1,
        0);

    APIServices.login(usuario).then((response) {
      if (response.statusCode == 200) {
        usuario = new Usuario.fromObject(json.decode(response.body));
        print(usuario);
        iniciar_sessao(usuario);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        erro = response.body;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/images/logo.png"))),
            SizedBox(height: 80),
            TextFormField(
                controller: _apelidoController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 23),
                    fillColor: Colors.white,
                    hoverColor: Colors.blue,
                    focusColor: Colors.white,
                    labelText: "Apelido",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ))),
            SizedBox(height: 20),
            TextFormField(
                controller: _senhaController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 18),
                obscureText: true,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white70, fontSize: 23),
                    fillColor: Colors.white,
                    hoverColor: Colors.blue,
                    focusColor: Colors.white,
                    errorText: _erro_login(),
                    labelText: "Senha",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 2.0),
                    ))),
            SizedBox(height: 35),
            ElevatedButton(
                child: Text("Entrar"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).buttonColor,
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () {
                  _login();
                }),
            SizedBox(height: 30),
            Container(
                height: 100,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Você não possui uma conta ainda?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: _launchURL,
                      child: Text(
                        'Clique aqui para criar!',
                      ),
                    ),
                  ],
                )),
          ],
        )),
      )),
    );
  }
}
