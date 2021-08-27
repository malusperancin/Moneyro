import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/tag_model.dart';

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

Tag tag = Tag(0, '');
DateTime _dateTime = DateTime.now();

class _DespesaState extends State<Despesa> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
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
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.0),
                      child: TextFormField(
                          controller: _valor,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black54,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 10),
                                  child: Icon(Icons.attach_money_rounded,
                                      color: Colors.black45)),
                              labelStyle: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              fillColor: Colors.white,
                              hoverColor: Colors.black,
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
                                          fontFamily: "Malu"),
                                    ),
                                    Icon(Icons.calendar_today,
                                        color: Colors.black54)
                                  ])))),
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
                  DropdownButton<Tag>(
                    value: tag,
                    icon: const Icon(Icons.local_offer_rounded),
                    iconSize: 24,
                    elevation: 2,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
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
                  )
                ]));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
