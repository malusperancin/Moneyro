import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/conteudo_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {
  List<Conteudo> conteudos = [];
  List<Conteudo> filtrados = [];
  YoutubePlayerController _controller = null;
  String erro = "";
  int selecionado = 0;
  final _pesquisa = TextEditingController();

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui

    await APIServices.getConteudos(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        conteudos = list.map((model) => Conteudo.fromObject(model)).toList();
        filtrados = conteudos;
      }
    });

    return true;
  }

  void curtir(int idCont, int index) async {
    var map = Map<String, dynamic>();

    map["id"] = 1;
    map["idConteudo"] = idCont;
    map["idUsuario"] = await FlutterSession().get('id');

    APIServices.curtir(map).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          filtrados[index].curtidas += 1;
          filtrados[index].curtido = true;
        });
      } else {
        erro = response.body;
      }
    });
  }

  void descurtir(int idCont, int index) async {
    var map = Map<String, dynamic>();

    map["id"] = 1;
    map["idConteudo"] = idCont;
    map["idUsuario"] = await FlutterSession().get('id');

    APIServices.descurtir(map).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          filtrados[index].curtidas -= 1;
          filtrados[index].curtido = true;
        });
      } else {
        erro = response.body;
      }
    });
  }

  Widget getDica(Conteudo dica, int index) {
    return Container(
        margin: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.format_quote_rounded, size: 35, color: Colors.white),
            Row(children: [
              Padding(
                child:
                    Icon(Icons.calendar_today, size: 15, color: Colors.white),
                padding: EdgeInsets.only(right: 5),
              ),
              Text(
                  dica.data.day.toString() +
                      "/" +
                      dica.data.month.toString() +
                      "/" +
                      dica.data.year.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                      fontFamily: 'Malu2',
                      color: Colors.grey)),
            ])
          ]),
          Text(dica.titulo,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 25,
                  fontFamily: 'Malu2',
                  color: Colors.white)),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
              child: Text('"' + dica.texto + '"',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 17,
                      height: 1,
                      fontFamily: 'Malu',
                      color: Colors.white))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                  child: Icon(Icons.info, size: 14, color: Colors.grey),
                  padding: EdgeInsets.only(right: 5),
                ),
                Text(dica.assunto,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                        fontFamily: 'Malu2',
                        color: Colors.grey)),
              ]),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        dica.curtido
                            ? descurtir(dica.id, index)
                            : curtir(dica.id, index);
                      },
                      child: Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color:
                                  dica.curtido ? (Colors.red) : (Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            Text(
                              dica.curtidas.toString(),
                              style: TextStyle(
                                color: dica.curtido
                                    ? (Colors.white)
                                    : (Colors.grey[600]),
                                fontWeight: FontWeight.w100,
                                fontSize: 15,
                                fontFamily: 'Malu2',
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.favorite_rounded,
                                size: 15,
                                color: dica.curtido
                                    ? (Colors.white)
                                    : (Colors.grey)),
                          ]))),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        _launchURL(dica.link);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.open_in_new_rounded,
                            size: 15, color: (Colors.grey)),
                      ))
                ],
              )
            ],
          )
        ]));
  }

  Widget getNoticia(Conteudo noticia, int index) {
    return Container(
        margin: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(color: Colors.black54),
        padding: EdgeInsets.only(left: 26, right: 26, top: 22, bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(noticia.titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 24,
                      fontFamily: 'Malu2',
                      height: 0.9,
                      color: Colors.white)),
              SizedBox(height: 5),
              Row(children: [
                Padding(
                  child:
                      Icon(Icons.calendar_today, size: 15, color: Colors.white),
                  padding: EdgeInsets.only(right: 5),
                ),
                Text(
                    noticia.data.day.toString() +
                        "/" +
                        noticia.data.month.toString() +
                        "/" +
                        noticia.data.year.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        fontFamily: 'Malu2',
                        color: Colors.grey)),
              ]),
              Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
                  child: Column(children: [
                    Text(noticia.texto,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            height: 0.9,
                            fontSize: 17,
                            fontFamily: 'Malu',
                            color: Colors.white)),
                    SizedBox(height: 15),
                    Image.network(
                      noticia.imagem,
                      fit: BoxFit.fill,
                    )
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Padding(
                      child: Icon(Icons.info, size: 14, color: Colors.grey),
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Text(noticia.assunto,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                            fontFamily: 'Malu2',
                            color: Colors.grey)),
                  ]),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            noticia.curtido
                                ? descurtir(noticia.id, index)
                                : curtir(noticia.id, index);
                          },
                          child: Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                  color: noticia.curtido
                                      ? (Colors.red)
                                      : (Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                Text(
                                  noticia.curtidas.toString(),
                                  style: TextStyle(
                                    color: noticia.curtido
                                        ? (Colors.white)
                                        : (Colors.grey[600]),
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15,
                                    fontFamily: 'Malu2',
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.favorite_rounded,
                                    size: 15,
                                    color: noticia.curtido
                                        ? (Colors.white)
                                        : (Colors.grey)),
                              ]))),
                      SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            _launchURL(noticia.link);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.open_in_new_rounded,
                                size: 15, color: (Colors.grey)),
                          ))
                    ],
                  )
                ],
              )
            ]));
  }

  Widget getVideo(Conteudo video, int index) {
    return Container(
        margin: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(color: Colors.black54),
        padding: EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(video.titulo,
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 22,
                    fontFamily: 'Malu2',
                    height: 0.9,
                    color: Colors.white)),
            SizedBox(height: 5),
            Row(children: [
              Padding(
                child:
                    Icon(Icons.calendar_today, size: 15, color: Colors.white),
                padding: EdgeInsets.only(right: 5),
              ),
              Text(
                  video.data.day.toString() +
                      "/" +
                      video.data.month.toString() +
                      "/" +
                      video.data.year.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                      fontFamily: 'Malu2',
                      color: Colors.grey)),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
                child: Column(children: [
                  Text(video.texto,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          height: 0.9,
                          fontSize: 17,
                          fontFamily: 'Malu',
                          color: Colors.white)),
                  SizedBox(height: 10),
                  YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                          video.link), //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                  )
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Padding(
                    child: Icon(Icons.info, size: 14, color: Colors.grey),
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text(video.assunto,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 15,
                          fontFamily: 'Malu2',
                          color: Colors.grey)),
                ]),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          video.curtido
                              ? descurtir(video.id, index)
                              : curtir(video.id, index);
                        },
                        child: Container(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: video.curtido
                                    ? (Colors.red)
                                    : (Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Text(
                                video.curtidas.toString(),
                                style: TextStyle(
                                  color: video.curtido
                                      ? (Colors.white)
                                      : (Colors.grey[600]),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15,
                                  fontFamily: 'Malu2',
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.favorite_rounded,
                                  size: 15,
                                  color: video.curtido
                                      ? (Colors.white)
                                      : (Colors.grey)),
                            ]))),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _launchURL(video.link);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.open_in_new_rounded,
                              size: 15, color: (Colors.grey)),
                        ))
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget getCabecalho() {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
          child: TextFormField(
              controller: _pesquisa,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black54, fontSize: 15),
              decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Icon(Icons.search, color: Colors.black45)),
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 15),
                  fillColor: Colors.white,
                  focusColor: Colors.black,
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  )))),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColorDark,
              Color(0xFF000e3b),
            ],
          )),
          height: 55,
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              children: <Widget>[
                MaterialButton(
                    onPressed: () {
                      if (selecionado == 1) {
                        setState(() {
                          selecionado = 0;
                          filtrados = conteudos;
                        });
                      } else {
                        setState(() {
                          selecionado = 1;
                          filtrados = conteudos
                              .where((element) => element.tipo == "noticia")
                              .toList();
                        });
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: selecionado == 1
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "Notícias",
                          style: TextStyle(color: Colors.white),
                        ))),
                MaterialButton(
                    onPressed: () {
                      if (selecionado == 2) {
                        setState(() {
                          selecionado = 0;
                          filtrados = conteudos;
                        });
                      } else {
                        setState(() {
                          selecionado = 2;
                          filtrados = conteudos
                              .where((element) => element.tipo == "dica")
                              .toList();
                        });
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: selecionado == 2
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Dicas",
                            style: TextStyle(color: Colors.white)))),
                MaterialButton(
                    onPressed: () {
                      if (selecionado == 3) {
                        setState(() {
                          selecionado = 0;
                          filtrados = conteudos;
                        });
                      } else {
                        setState(() {
                          selecionado = 3;
                          filtrados = conteudos
                              .where((element) => element.tipo == "blog")
                              .toList();
                        });
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: selecionado == 3
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Blogs",
                            style: TextStyle(color: Colors.white)))),
                MaterialButton(
                    onPressed: () {
                      if (selecionado == 4) {
                        selecionado = 0;
                        setState(() {
                          filtrados = conteudos;
                        });
                      } else {
                        selecionado = 4;
                        setState(() {
                          filtrados = conteudos
                              .where((element) => element.tipo == "video")
                              .toList();
                        });
                      }
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: selecionado == 4
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Vídeos",
                            style: TextStyle(color: Colors.white)))),
              ])),
    ]);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // aqui só carrega quando já pegou os dados
    return Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            floating: true,
            expandedHeight: 118.0,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin, background: getCabecalho()),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            if (filtrados[index].tipo == "dica")
              // && (selecionado == 0 || selecionado == 2))
              return getDica(filtrados[index], index);

            if (filtrados[index].tipo == "noticia")
              // && (selecionado == 0 || selecionado == 1))
              return getNoticia(filtrados[index], index);

            if (filtrados[index].tipo == "video")
              // && (selecionado == 0 || selecionado == 4))
              return getVideo(filtrados[index], index);

            if (filtrados[index].tipo == "blog")
              // && (selecionado == 0 || selecionado == 3))
              return getNoticia(filtrados[index], index);

            return null;
          }, childCount: filtrados.length))
        ]));
  }
}
