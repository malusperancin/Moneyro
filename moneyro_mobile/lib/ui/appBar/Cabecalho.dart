import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  const Cabecalho(
      {Key key, Color this.cor, String this.titulo, IconData this.icone})
      : super(key: key);

  final Color cor;
  final String titulo;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
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
}
