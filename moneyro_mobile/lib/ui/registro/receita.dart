import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/registro_model.dart';
import 'package:moneyro_mobile/models/tag_model.dart';
import 'package:moneyro_mobile/ui/planilha/planilha.dart';

class Receita extends StatefulWidget {
  BuildContext modal;
  Receita({Key key, this.modal}) : super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

final _valor = TextEditingController();
final _nome = TextEditingController();
final _data = TextEditingController();
final _local = TextEditingController();

Tag _tag;
bool quantiaInvalida = false;
List<Tag> tags = [];
var erro = '';
DateTime _dateTime = DateTime.now();

class _ReceitaState extends State<Receita> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
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

        setState(() {
          tags = list.map((model) => Tag.fromObject(model)).toList();
        });

        _tag = tags[0];
      }
    });

    return true;
  }

  Future<void> registrar() async {
    double valor = double.parse(_valor.text.toString());

    if (_valor.text == null || valor == 0) {
      quantiaInvalida = true;
      return;
    }

    Registro reg = new Registro(0, await FlutterSession().get('id'), _dateTime,
        _nome.text, _tag.id, null, valor);

    APIServices.addRegistro(reg).then((response) {
      if (response.statusCode == 200) {
        reg = new Registro.fromObject(json.decode(response.body));

        setState(() {});

        Navigator.pop(widget.modal);
      } else {
        erro = response.body;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      labelStyle:
                          TextStyle(color: Colors.white70, fontSize: 17),
                      fillColor: Colors.white,
                      focusColor: Colors.black,
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
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
                      labelStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                      fillColor: Colors.grey[200],
                      labelText: "Nome",
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
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
                      )))),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[200])),
                  onPressed: () => _selectDate(context),
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Data: " +
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
                            Icon(Icons.calendar_today, color: Colors.black54)
                          ])))),
          Spacer(),
          DropdownButton<Tag>(
            value: _tag,
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
              setState(() {
                _tag = newValue;
              });
            },
            items: tags.map<DropdownMenuItem<Tag>>((Tag valor) {
              return DropdownMenuItem<Tag>(
                value: valor,
                child: Text(valor.nome),
              );
            }).toList(),
          ),
          Spacer(flex: 5),
          ElevatedButton(
              child:
                  Padding(child: Text("Salvar"), padding: EdgeInsets.all(10)),
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
  }
}
