import 'dart:convert';

import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/compartilhados_model.dart';
import 'package:moneyro_mobile/models/registro_model.dart';
import 'package:moneyro_mobile/models/tag_model.dart';
import 'package:moneyro_mobile/models/registros_dia_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:intl/intl.dart';
import 'package:moneyro_mobile/ui/appBar/Cabecalho.dart';

class PlanilhaScreen extends StatefulWidget {
  PlanilhaScreen({Key key}) : super(key: key);

  @override
  _PlanilhaPageState createState() => _PlanilhaPageState();
}

class _PlanilhaPageState extends State<PlanilhaScreen> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<RegistrosDia> registrosDias = [];
  List<Tag> tags = [];

  Future<bool> fetchData() async {
    List<Compartilhados> compartilhados = [];
    List<Registro> registros = [];

    await APIServices.getTags().then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        tags = list.map((model) => Tag.fromObject(model)).toList();
      }
    });

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

  List<Widget> getCompartilhados(Registro reg) {
    List<Widget> ret = [];

    if (reg.usuarios.length == 0) return ret;

    for (Compartilhados user in reg.usuarios)
      ret.add(Container(
          width: 40,
          height: 40,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child:
                  Image.asset("assets/images/perfil" + user.foto + ".png"))));

    return ret;
  }

  Widget Dia(BuildContext context, int index, animation) {
    RegistrosDia item = registrosDias[index];

    List<Widget> registros = [];
    NumberFormat formatter = NumberFormat("00.00");

    for (Registro reg in item.registros) {
      registros.add(SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: SizedBox(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
            decoration: BoxDecoration(
                color: reg.quantia < 0 ? Colors.red[400] : Colors.green[800],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(reg.nome,
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 30,
                                fontFamily: 'Malu2',
                                color: Colors.white)),
                        Padding(
                            padding:
                                EdgeInsets.only(right: 5, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.local_offer,
                                    size: 22, color: Colors.white),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(tags[reg.idTag].nome.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 20,
                                        fontFamily: 'Malu',
                                        color: Colors.white)),
                              ],
                            )),
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          child: Row(
                            children: [
                              Text("R\$",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 15,
                                      fontFamily: 'Malu2',
                                      color: Colors.white)),
                              Text(
                                  reg.quantia >= 0
                                      ? formatter.format(reg.quantia).toString()
                                      : formatter
                                          .format(reg.quantia)
                                          .toString()
                                          .substring(1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 30,
                                      fontFamily: 'Malu2',
                                      color: Colors.white))
                            ],
                          ),
                          padding: EdgeInsets.only(right: 5),
                        ),
                        Row(
                          children: getCompartilhados(reg),
                        )
                      ])
                ]),
          ),
        ),
      ));
    }

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Padding(
                        child: Icon(Icons.calendar_today,
                            size: 22.0, color: Colors.white),
                        padding: EdgeInsets.only(right: 6),
                      ),
                      Text(
                          "" +
                              item.data.day.toString() +
                              "/" +
                              item.data.month.toString() +
                              "/" +
                              item.data.year.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 22,
                              fontFamily: 'Malu',
                              color: Colors.white))
                    ],
                  )),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: registros)
            ]));
  }

  void inserirRegistro(Registro r) {
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));

    /*
    inserirNoDia
    registrosDias = []
      ..add(r)
      ..addAll(registrosDias);*/
  }

  void removerRegistro(Registro r) {
    listKey.currentState.removeItem(
        0, (_, animation) => Dia(context, 0, animation),
        duration: const Duration(milliseconds: 500));

    /*
      remover do vetor
      _items.removeAt(0);
      */
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return Column(
              children: [
                Cabecalho(
                    titulo: "Planilha",
                    icone: Icons.reorder_rounded,
                    cor: Colors.amber[500]),
                Expanded(
                    child: AnimatedList(
                  shrinkWrap: true,
                  key: listKey,
                  initialItemCount: registrosDias.length,
                  itemBuilder: (context, index, animation) {
                    return Dia(context, index, animation); // Refer step 3
                  },
                )),
                SizedBox(
                  height: 60,
                )
              ],
            );
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
