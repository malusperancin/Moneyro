import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/situacao_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneyro_mobile/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/ui/appBar/Cabecalho.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:soundpool/soundpool.dart';

import '../DiscoveryPage.dart';

class CofreScreen extends StatefulWidget {
  CofreScreen({Key key}) : super(key: key);

  @override
  _CofrePageState createState() => _CofrePageState();
}

class _CofrePageState extends State<CofreScreen> {
  final _url = 'http://localhost:8080/#/compra';
  Usuario usuario;
  Situacao situacao;
  bool editar = false;

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;
  TextEditingController _valorRecebido = new TextEditingController();

  bool get estaConectado => (connection.isConnected ? true : false);

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  connect(String address) async {
    try {
      await FlutterSession().set("cofre", address);
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');

      connection.input.listen((Uint8List data) {
        print(ascii.decode(data));
      }).onData((Uint8List data) {
        double valor = double.parse(String.fromCharCodes(data));
        setState(() {
          _valorRecebido.text =
              (double.parse(_valorRecebido.text) + valor).toString();
        });
        _showMyDialog(valor);
        print(_valorRecebido.text);
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  Future<void> send(String texto) async {
    connection.output.add(ascii.encode(texto));
    await connection.output.allSent;
  }

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

    String endereco = await FlutterSession().get('cofre');

    if (usuario.cofre >= 0) if (endereco != null) connect(endereco);

    return true;
  }

  /*
    sattus1: nao tem cofre
    2: tem 0 - 5
    3: ok 5 - 10
    4: uau 10 - 15
    5: rei 15 - infinito
  */

  Future<void> updateCofre() async {
    APIServices.updateUsuario(usuario).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          //usuario.saldo += valorRecebido;
          _valorRecebido.text = "0,00";
        });
      }
    });
  }

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
                onPressed: () async {
                  final BluetoothDevice selected =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DiscoveryPage();
                      },
                    ),
                  );

                  if (selected != null) {
                    print('Discovery -> selected ' + selected.address);
                    setState(() {
                      selectedDevice = selected;
                      connect(selectedDevice.address);
                    });
                  } else {
                    print('Discovery -> no device selected');
                  }
                })
          ],
        ));
  }

  Widget getCard() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFF545454)),
        padding: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          /*FormField(
                  "R\$" + valorRecebido.toStringAsFixed(2).replaceAll(".", ","),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 55,
                      fontFamily: 'Malu2',
                      color: Colors.white)),*/
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextFormField(
                controller: _valorRecebido,
                enabled: editar,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black54,
                style: TextStyle(color: Colors.black54, fontSize: 18),
                decoration: InputDecoration(
                    filled: editar,
                    labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: editar ? 22 : 40,
                        fontFamily: 'Malu2'),
                    fillColor: Colors.grey[200],
                    labelText: "Valor",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey[200], width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey[200], width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey[200], width: 1.0),
                    ))),
          ),
          SizedBox(height: 15),
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
                        child: Icon(Icons.edit_rounded, color: Colors.white)),
                    onTap: () {
                      editar = true;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  child: Container(
                      child: Padding(
                    child: Text("Cancelar"),
                    padding: EdgeInsets.all(5),
                  )),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[400],
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[200]),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  onPressed: () {
                    _valorRecebido.text = "";
                  }),
              ElevatedButton(
                  child: Padding(
                    child: Text(editar ? "Salvar alteração" : "Confirmar"),
                    padding: EdgeInsets.all(5),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[700],
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700]),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  onPressed: () {
                    //
                    // faz negocio no banco
                    if (editar)
                      editar = false;
                    else
                      updateCofre();
                  })
            ],
          ))
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    super.initState();
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
              Cabecalho(
                  cor: Colors.blue[500],
                  titulo: "Cofre",
                  icone: Icons.savings_rounded),
              Expanded(
                  child: usuario.cofre >= 0.0
                      // Tem cofre
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              getSituacao(),
                              // bluetooth ligado
                              _bluetoothState.isEnabled
                                  ? estaConectado
                                      // cofre conectado
                                      ? getCard()
                                      : getDesconectado()
                                  : SwitchListTile(
                                      title: const Text(
                                          'Ligue o seu bluetooth:',
                                          style: TextStyle(
                                              height: 0.8,
                                              fontSize: 20,
                                              fontFamily: 'Malu2',
                                              color: Colors.white)),
                                      value: _bluetoothState.isEnabled,
                                      onChanged: (bool value) {
                                        // Do the request and update with the true value then
                                        future() async {
                                          // async lambda seems to not working
                                          if (value)
                                            await FlutterBluetoothSerial
                                                .instance
                                                .requestEnable();
                                          else
                                            await FlutterBluetoothSerial
                                                .instance
                                                .requestDisable();
                                        }

                                        future().then((_) {
                                          setState(() {});
                                        });
                                      },
                                    ),
                            ])
                      // Não tem cofre
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Theme.of(context).backgroundColor,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.only(left: 20, bottom: 60),
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
                                padding: EdgeInsets.only(
                                    left: 25, right: 25, bottom: 100),
                                child: Column(children: <Widget>[
                                  Text(
                                      "Caso queira adquirir um, este botão te levará direto para nossa loja",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          fontFamily: 'Malu',
                                          color: Colors.white,
                                          height: .9)),
                                  SizedBox(height: 10.0), //<b>
                                  ListTile(
                                      title: ElevatedButton(
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
                                          }))
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
