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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String erro;

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void iniciar_sessao(Usuario user) async =>
      await FlutterSession().set("id", user.id);

  void _login() {
    Usuario usuario = new Usuario(
        1,
        '',
        _apelidoController.text,
        '',
        '',
        new DateTime(1900, 1, 1),
        '',
        _senhaController.text,
        '',
        '',
        false,
        false,
        0.0,
        false,
        1,
        0,
        0.0);

    APIServices.login(usuario).then((response) {
      if (response.statusCode == 200) {
        usuario = new Usuario.fromObject(json.decode(response.body));
        iniciar_sessao(usuario);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        setState(() {
          erro = String.fromCharCodes(response.bodyBytes)
              .replaceAll("Ã£", "ã")
              .replaceAll("Ã¡", "á");
          print(erro);
        });
      }
    });
  }

  @override
  void dispose() {
    _apelidoController.dispose();
    _senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2504a6),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Spacer(),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/images/logo.png"))),
                Spacer(),
                TextFormField(
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu apelido';
                      }
                      return null;
                    },
                    controller: _apelidoController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellow),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellowAccent, width: 2.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 23),
                        fillColor: Colors.white,
                        hoverColor: Colors.blue,
                        focusColor: Colors.white,
                        labelText: "Apelido",
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ))),
                SizedBox(height: 20),
                TextFormField(
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                    controller: _senhaController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    obscureText: true,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellow),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellowAccent, width: 2.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 23),
                        fillColor: Colors.white,
                        hoverColor: Colors.blue,
                        focusColor: Colors.white,
                        labelText: "Senha",
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white70, width: 2.0),
                        ))),
                SizedBox(height: 10),
                erro != null
                    ? Row(children: <Widget>[
                        Icon(Icons.warning_rounded, color: Colors.yellow),
                        SizedBox(width: 10),
                        Text(erro.toString(),
                            style: TextStyle(color: Colors.yellow))
                      ])
                    : SizedBox(height: 25),
                SizedBox(height: 10),
                ElevatedButton(
                    child: Text("Entrar"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      primary: Theme.of(context).buttonColor,
                      textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _login();
                      }
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
                Spacer(),
              ],
            )),
      ),
    );
  }
}
/*

classe Pessoa
{
  nome = "jose"
  idade = 17
}

Nome        idade
"Jose"      17
"Maria"     17

*/
