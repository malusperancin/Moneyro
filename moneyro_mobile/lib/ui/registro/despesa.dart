import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/registro_model.dart';
import 'package:moneyro_mobile/models/tag_model.dart';
import 'package:moneyro_mobile/ui/planilha/planilha.dart';

class Despesa extends StatefulWidget {
  Despesa({Key key}) : super(key: key);

  @override
  _DespesaState createState() => _DespesaState();
}

final _valor = TextEditingController();
final _nome = TextEditingController();
final _data = TextEditingController();
final _local = TextEditingController();
List<Tag> tags = new List<Tag>();
var erro = '';

Tag tag = Tag(0, '');
DateTime _dateTime = DateTime.now();

class _DespesaState extends State<Despesa> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2020, 1),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                surface: Theme.of(context).primaryColorDark,
              ),
            ),
            child: child,
          );
        },
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime)
      setState(() {
        _dateTime = picked;
      });
  }

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    await APIServices.getTags().then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        tags = list.map((model) => Tag.fromObject(model)).toList();

        if (tag.id == 0) tag = tags[0];
      }
    });

    return true;
  }

  Future<void> registrar() async {
    Registro reg = new Registro(
        1,
        await FlutterSession().get('id'),
        _dateTime,
        _nome.text,
        tag.id,
        _local.text,
        -double.parse(_valor.value.toString()));

    APIServices.addRegistro(reg).then((response) {
      if (response.statusCode == 200) {
        reg = new Registro.fromObject(json.decode(response.body));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => PlanilhaScreen()));
      } else {
        erro = response.body;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: <Widget>[
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextFormField(
                          controller: _valor,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black54,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 10),
                                  child: Icon(Icons.attach_money_rounded,
                                      color: Colors.black45)),
                              labelStyle: TextStyle(
                                  color: Colors.white70, fontSize: 17),
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              )))),
                  Spacer(flex: 3),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                          controller: _nome,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black54,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              fillColor: Colors.grey[200],
                              labelText: "Nome",
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              )))),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey[200])),
                          onPressed: () => _selectDate(context),
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Data : " +
                                          _dateTime.day.toString() +
                                          "/" +
                                          _dateTime.month.toString() +
                                          "/" +
                                          _dateTime.year.toString(),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Icon(Icons.calendar_today,
                                        color: Colors.black54)
                                  ])))),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                          controller: _local,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black54,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 15),
                              fillColor: Colors.grey[200],
                              labelText: "Local",
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.grey[200], width: 1.0),
                              )))),
                  Spacer(),
                  DropdownButton<Tag>(
                    value: tag,
                    icon: const Icon(Icons.local_offer_rounded),
                    iconSize: 24,
                    elevation: 2,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black54,
                    ),
                    onChanged: (Tag newValue) {
                      tag = newValue;
                    },
                    items: tags.map<DropdownMenuItem<Tag>>((Tag value) {
                      return DropdownMenuItem<Tag>(
                        value: value,
                        child: Text(value.nome),
                      );
                    }).toList(),
                  ),
                  Spacer(flex: 5),
                  ElevatedButton(
                      child: Padding(
                          child: Text("Salvar"), padding: EdgeInsets.all(10)),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark,
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        registrar();
                      }),
                  Spacer(),
                ]));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
