import 'dart:convert';

import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/compartilhados_model.dart';
import 'package:Moneyro/models/registro_model.dart';
import 'package:Moneyro/models/registros_dia_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import "package:collection/collection.dart";

class PlanilhaScreen extends StatefulWidget {
  PlanilhaScreen({Key key}) : super(key: key);

  @override
  _PlanilhaPageState createState() => _PlanilhaPageState();
}

class _PlanilhaPageState extends State<PlanilhaScreen> {
  List<RegistrosDia> registrosDias = [];

  Future<bool> fetchData() async {
    registrosDias = [];
    List<Compartilhados> compartilhados = [];
    List<Registro> registros = [];

    await APIServices.getRegistros(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        registros = list.map((model) => Registro.fromObject(model)).toList();
      }
    });

    await APIServices.getCompartilhados(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        compartilhados =
            list.map((model) => Compartilhados.fromObject(model)).toList();

        registros.forEach((reg) {
          for (int i = 0; i < compartilhados.length; i++) {
            if (compartilhados[i].idRegistro == reg.id)
              reg.usuarios.add(compartilhados[i]);
          }
        });
      }
    });

    for (int i = 0; i < registros.length; i++) {
      var data = registros[i].data;
      List<Registro> dia = [];

      for (; i < registros.length && registros[i].data == data; i++)
        dia.add(registros[i]);

      i--;

      registrosDias.add(new RegistrosDia(data, dia));
    }

    return true;
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
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[
                  cabecalho(
                      "Planilha", Icons.reorder_rounded, Colors.amber[500]),
                  AnimatedList(
                      shrinkWrap: true,
                      itemBuilder: (context, index, animation) {
                        return Container(
                          child: Text("teste"),
                        );

                        /*return SlideTransition(
                          child: ListTile(
                            title: Text(registros[index].nome),
                          ),
                        );*/
                      })
                ]));
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
