import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const _url = 'https://localhost:8080/cadastro';
void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

final _apelidoController = TextEditingController();
final _senhaController = TextEditingController();

class _HomePageState extends State<HomeScreen> {
  Future<void> createInstances() async {}

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
                // Usuario usu = new Usuario(
                //     nome: _apelidoController.text,
                //     data: _senhaController.text);
                // if(usuarioService.login(usu){
                //  Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (_) =>
                //         CofreScreen(id: usu.id)));
                // }
                // else{
                //   _senhnaController.setText("");
                //   _senhnaController.setErrorText("Apelido e/ou senha incorretos");
                //}
              },
            ),
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
