import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:Moneyro/data/api_services.dart';
import 'package:Moneyro/models/registro_model.dart';
import 'package:Moneyro/models/tag_model.dart';

class Receita extends StatefulWidget {
  BuildContext modal;
  Receita({Key key}) : super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

class _ReceitaState extends State<Receita> {
  final _valor = TextEditingController();
  final _nome = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Tag> tags;
  Tag _tag;

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
    if (tags == null || tags.length == 0)
      await APIServices.getTags().then((response) {
        if (response.statusCode == 200) {
          Iterable list = json.decode(response.body);

          tags = list.map((model) => Tag.fromObject(model)).toList();
          _tag = tags[0];
        }
      });

    return true;
  }

  Future<void> registrar() async {
    double valor = double.parse(_valor.text.toString());

    Registro reg = new Registro(0, await FlutterSession().get('id'), _dateTime,
        _nome.text, _tag.id, null, valor);

    APIServices.addRegistro(reg).then((response) {
      if (response.statusCode == 200)
        reg = new Registro.fromObject(json.decode(response.body));
        //Navigator.pop(context, reg);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _valor.dispose();
    _nome.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding:
                EdgeInsets.only(top: 28, bottom: 30, left: 20, right: 20),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              child: TextFormField(
                                  validator: (String value) {
                                    double valor = 0;

                                    value = _valor.text.replaceAll(",", ".");

                                    if (value == null || value.isEmpty)
                                      return 'Insira um valor';

                                    try { valor = double.parse(value); }
                                    catch(e) { return 'Insira um valor válido'; }

                                    if(valor == 0)
                                      return 'Insira um valor maior que zero';

                                    return null;
                                  },
                                  onSaved: (String texto) {
                                    FlutterMoneyFormatter fmf =
                                    FlutterMoneyFormatter(
                                        amount: -double.parse(
                                            texto.replaceAll(",", ".")));
                                    _valor.text = fmf.output.nonSymbol;
                                  },
                                  cursorWidth: 1,
                                  controller: _valor,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black54,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 32),
                                  decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 0, top: 20, bottom: 20),
                                          child: Icon(
                                              Icons.attach_money_rounded,
                                              color: Colors.black45,
                                              size: 35)),
                                      labelStyle: TextStyle(
                                          color: Colors.white70, fontSize: 17),
                                      fillColor: Colors.white,
                                      focusColor: Colors.black,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 3),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ))),
                              padding: EdgeInsets.symmetric(horizontal: 60)),
                          SizedBox(height: 25),
                          TextFormField(
                              validator: (String value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira um nome';
                                }
                                return null;
                              },
                              controller: _nome,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black54,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  filled: true,
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                  fillColor: Colors.white,
                                  labelText: "Nome",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      15.0, 25.0, 15.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey[400], width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey[400], width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey[600], width: 1.5),
                                  ))),
                          SizedBox(height: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () => _selectDate(context),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(Icons.calendar_today,
                                        color: Colors.black54)
                                  ])),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 18, right: 5, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[400], width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),

                              child: DropdownButton<Tag>(
                                value: _tag,
                                icon: Icon(Icons.arrow_drop_down_rounded),
                                iconSize: 42,
                                underline: SizedBox(),
                                onChanged: (Tag newValue) {
                                  setState(() {
                                    _tag = newValue;
                                  });
                                },
                                items: tags
                                    .map<DropdownMenuItem<Tag>>((Tag valor) {
                                  return DropdownMenuItem<Tag>(
                                    value: valor,
                                    child: Text(valor.nome),
                                  );
                                }).toList(),
                              )),
                          Spacer(flex: 2),
                          ElevatedButton(
                              child: Text("Adicionar"),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 22),
                                primary: Theme.of(context).buttonColor,
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  registrar();
                                }
                              }),
                        ])));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
