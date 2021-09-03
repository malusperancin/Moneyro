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
  YoutubePlayerController _controller = null;
  String erro = "";
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
          conteudos[index].curtidas += 1;
          conteudos[index].curtido = true;
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
          conteudos[index].curtidas -= 1;
          conteudos[index].curtido = true;
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
          Row(children: [
            Icon(Icons.format_quote_rounded, size: 25, color: Colors.white),
            Spacer(),
            Padding(
              child: Icon(Icons.calendar_today, size: 15, color: Colors.white),
              padding: EdgeInsets.only(right: 5),
            ),
            Text(
                "" +
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
          ]),
          Text(dica.titulo,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 22,
                  fontFamily: 'Malu2',
                  color: Colors.white)),
          Padding(
              padding: EdgeInsets.all(15),
              child: Text('"' + dica.texto + '"',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 17,
                      fontFamily: 'Malu',
                      color: Colors.white))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Padding(
                  child: Icon(Icons.info, size: 15, color: Colors.white),
                  padding: EdgeInsets.only(right: 5),
                ),
                Text(dica.assunto,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        fontFamily: 'Malu2',
                        color: Colors.grey)),
              ]),
              Row(
                children: [
                  MaterialButton(
                      onPressed: () {
                        dica.curtido
                            ? descurtir(dica.id, index)
                            : curtir(dica.id, index);
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                              child: Icon(Icons.favorite_rounded,
                                  size: 15,
                                  color: dica.curtido
                                      ? (Colors.white)
                                      : (Colors.grey)),
                            )
                          ]))),
                  GestureDetector(
                      onTap: () {
                        _launchURL(dica.link);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
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
        padding: EdgeInsets.only(left: 28, right: 28, top: 22, bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
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
              child: Icon(Icons.calendar_today, size: 15, color: Colors.white),
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
                  child: Icon(Icons.info, size: 15, color: Colors.white),
                  padding: EdgeInsets.only(right: 5),
                ),
                Text(noticia.assunto,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 14,
                        fontFamily: 'Malu2',
                        color: Colors.grey)),
              ]),
              Row(
                children: [
                  MaterialButton(
                      onPressed: () {
                        noticia.curtido
                            ? descurtir(noticia.id, index)
                            : curtir(noticia.id, index);
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 5),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                              child: Icon(Icons.favorite_rounded,
                                  size: 15,
                                  color: noticia.curtido
                                      ? (Colors.white)
                                      : (Colors.grey)),
                            )
                          ]))),
                  GestureDetector(
                      onTap: () {
                        _launchURL(noticia.link);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
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
                  "" +
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
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Text(video.texto,
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
                    child: Icon(Icons.info, size: 15, color: Colors.white),
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text(video.assunto,
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 14,
                          fontFamily: 'Malu2',
                          color: Colors.grey)),
                ]),
                Row(
                  children: [
                    MaterialButton(
                        onPressed: () {
                          video.curtido
                              ? descurtir(video.id, index)
                              : curtir(video.id, index);
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 5),
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
                              Container(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                                child: Icon(Icons.favorite_rounded,
                                    size: 15,
                                    color: video.curtido
                                        ? (Colors.white)
                                        : (Colors.grey)),
                              )
                            ]))),
                    GestureDetector(
                        onTap: () {
                          _launchURL(video.link);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.width * 0.05,
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
              padding: EdgeInsets.all(8),
              children: <Widget>[
                MaterialButton(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "Notícias",
                          style: TextStyle(color: Colors.white),
                        ))),
                MaterialButton(
                    color: Colors.white,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Dicas",
                            style: TextStyle(color: Colors.white)))),
                MaterialButton(
                    color: Colors.white,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Blogs",
                            style: TextStyle(color: Colors.white)))),
                MaterialButton(
                    color: Colors.white,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text("Vídeos",
                            style: TextStyle(color: Colors.white)))),
              ])),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // aqui só carrega quando já pegou os dados
            return CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColorDark,
                floating: true,
                expandedHeight: 118.0,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin, background: getCabecalho()),
              ),
              SliverList(delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (conteudos[index].tipo == "dica")
                    return getDica(conteudos[index], index);

                  if (conteudos[index].tipo == "video")
                    return getVideo(conteudos[index], index);

                  return getNoticia(conteudos[index], index);
                },
              ))
            ]);
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
