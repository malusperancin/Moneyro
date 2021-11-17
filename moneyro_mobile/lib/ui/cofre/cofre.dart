import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/situacao_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:Moneyro/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:Moneyro/ui/appBar/Cabecalho.dart';
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

  // Coisas do card
  TextEditingController _valorRecebido = new TextEditingController();
  bool editar = false;
  double total = 0;

  // Classes do bluetooth
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice selectedDevice;
  BluetoothConnection connection;

  bool get estaConectado => (connection != null && connection.isConnected);

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');

      connection.input.listen((Uint8List data) {
        print("listen: " + ascii.decode(data));
      }).onData((Uint8List data) {
        String recebido = String.fromCharCodes(data);
        double valor = 0;

        switch (recebido) {
          case "a":
            valor = 0.10;
            break;
          case "b":
            valor = 0.05;
            break;
          case "c":
            valor = 0.50;
            break;
          case "d":
            valor = 0.25;
            break;
          case "e":
            valor = 1.00;
            break;
          default:
            valor = 0;
            break;
        }

        if (valor != 0) {
          total += valor;

          setState(() {
            _valorRecebido.text = total.toStringAsFixed(2);
          });

          _showMyDialog(valor);
        }
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui

    if (usuario == null)
      await APIServices.getUsuario(await FlutterSession().get('id'))
          .then((response) {
        if (response.statusCode == 200)
          usuario = new Usuario.fromObject(json.decode(response.body));
      });

    if (situacao == null)
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

    /*String endereco = await FlutterSession().get('cofre');

    if (endereco != null && _bluetoothState.isEnabled && usuario.cofre >= 0 && !estaConectado)
      connect(endereco);

     */

    return true;
  }

  Future<void> updateCofre() async {
    usuario.saldo += total;
    usuario.cofre += total;

    APIServices.updateUsuario(usuario).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          usuario.cofre += total;
          usuario.saldo += total;
          _valorRecebido.text = "";
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
                        color: Colors.white)),
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
                    selectedDevice = selected;
                    await connect(selectedDevice.address);
                    await FlutterSession().set("cofre", selectedDevice.address);
                    setState(() {});
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
        padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("R\$",
                  style: TextStyle(
                      height: 1,
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
              TextField(
                  enabled: editar,
                  controller: _valorRecebido,
                  keyboardType: TextInputType.number,
                  cursorHeight: 5,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: -10, bottom: -10, left: 15),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 5))),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 55,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
              SizedBox(height: 15),
              Row(
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
                        onTap: () {
                          setState(() {
                            editar = !editar;
                          });
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
                        setState(() {
                          _valorRecebido.text = "";
                          editar = false;
                        });
                      }),
                  ElevatedButton(
                      child: Padding(
                        child: Text(editar ? "Salvar" : "Confirmar"),
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
                      onPressed: () async {
                        if (editar)
                          editar = false;
                        else
                          await updateCofre();

                        setState(() {});
                      })
                ],
              )
            ]));
  }

  @override
  void initState() {
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

    _valorRecebido = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _valorRecebido.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[
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
                              SwitchListTile(
                                title: const Text('Seu bluetooth:',
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
                                      await FlutterBluetoothSerial.instance
                                          .requestEnable();
                                    else
                                      await FlutterBluetoothSerial.instance
                                          .requestDisable();
                                  }

                                  future().then((_) {
                                    setState(() {});
                                  });
                                },
                              ),
                              if (_bluetoothState.isEnabled)
                                estaConectado ? getCard() : getDesconectado()
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
            ]);
          } else {
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

    await pool.play(soundId);
  }
}
