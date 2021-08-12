import 'package:Moneyro/models/usuario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaisScreen extends StatefulWidget {
  MaisScreen({Key key}) : super(key: key);

  @override
  _MaisPageState createState() => _MaisPageState();
}

class _MaisPageState extends State<MaisScreen> {

  Usuario user = new Usuario.vazio();

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    user.foto = "status1.png";//await FlutterSession().get('foto');
    user.saldo = 118.25;//await FlutterSession().get('saldo');
    user.pontos = 25;//await FlutterSession().get('pontos');
    user.nome = "Maria Luiza";//await FlutterSession().get('nome');
    user.email = "malu@gmail.com";//await FlutterSession().get('email');
    user.apelido = "maru";//await FlutterSession().get('apelido');

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
                                      fontFamily: 'Malu2',
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
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 45),
              children: <Widget>[
                cabecalho("Você", Icons.face_rounded, Colors.cyan[500]),
                // INFORMAÇÕES DO USUARIO
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              child: Image.asset("assets/images/"+user.foto,
                              )),
                          Flexible(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(user.apelido,
                                        style: TextStyle(
                                            height: 2,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25,
                                            fontFamily: 'Malu2',
                                            color: Colors.white)),
                                    Text(user.nome,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            height: 0.8,
                                            fontFamily: 'Malu',
                                            color: Colors.white)),
                                    Text(user.email,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            height: 1,
                                            fontFamily: 'Malu',
                                            color: Colors.white)),
                                  ],
                                ),
                              )
                          )
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
                              Text(user.saldo.toStringAsFixed(2).replaceAll(".", ","),
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
                              Text(user.pontos.toString(),
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
                // ROTA -
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: MaterialButton(
                    color: Color(0xFF545454),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: (){},
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_rounded,color: Colors.amber, size: 35),
                          Spacer(flex: 1),
                          Text("Nome",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  fontFamily: 'Malu2',
                                  color: Colors.amber)),
                          Spacer(flex: 10),
                          Icon(Icons.navigate_next_rounded, color: Colors.amber, size: 35)
                        ],
                      ),
                    ),
                  ),
                ),
                // ROTA -
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: MaterialButton(
                    color: Color(0xFF545454),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: (){},
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_rounded,color: Colors.blueAccent, size: 35),
                          Spacer(flex: 1),
                          Text("Nome",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  fontFamily: 'Malu2',
                                  color: Colors.blueAccent)),
                          Spacer(flex: 10),
                          Icon(Icons.navigate_next_rounded, color: Colors.blueAccent, size: 35)
                        ],
                      ),
                    ),
                  ),
                ),
                // ROTA -
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: MaterialButton(
                    color: Color(0xFF545454),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: (){},
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_rounded,color: Colors.green, size: 35),
                          Spacer(flex: 1),
                          Text("Nome",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  fontFamily: 'Malu2',
                                  color: Colors.green)),
                          Spacer(flex: 10),
                          Icon(Icons.navigate_next_rounded, color: Colors.green, size: 35)
                        ],
                      ),
                    ),
                  ),
                ),
                // SAIR
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: MaterialButton(
                    color: Color(0xFF545454),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: (){},
                    child: Container(
                      child: Row(
                        children: [
                          Text("Sair",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  fontFamily: 'Malu2',
                                  color: Colors.redAccent)),
                          Spacer(),
                          Icon(Icons.logout_rounded, color: Colors.redAccent, size: 35)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
