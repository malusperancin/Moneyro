import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receita extends StatefulWidget {
  Receita({Key key}) : super(key: key);

  @override
  _ReceitaState createState() => _ReceitaState();
}

final _valor = TextEditingController();
final _nome = TextEditingController();
final _data = TextEditingController();
final _local = TextEditingController();

String tag = "One";
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

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 15),
                  fillColor: Colors.white,
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
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
      Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: TextFormField(
              controller: _nome,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  filled: true,
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 15),
                  fillColor: Colors.grey[200],
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  labelText: "Nome",
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  )))),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              color: Colors.grey[200],
              onPressed: () => _selectDate(context),
              child: Text(
                "Data : " +
                    _dateTime.day.toString() +
                    "/" +
                    _dateTime.month.toString() +
                    "/" +
                    _dateTime.year.toString(),
              ),
            ),
          ],
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: TextFormField(
              controller: _local,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  filled: true,
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 15),
                  fillColor: Colors.grey[200],
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  labelText: "Local",
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
                  )))),
      DropdownButton<String>(
        value: tag,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            tag = newValue;
          });
        },
        items: <String>["One", "Two", "Free", "Four"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]);
  }
}
