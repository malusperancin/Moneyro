import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/data/api_services.dart';
import 'package:moneyro_mobile/models/conteudo_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedScreen> {
  List<Conteudo> conteudos = [];
  YoutubePlayerController _controller = null;

  Future<bool> fetchData() async {
    // se precisar pegar algo do banco ou da sessao faz aqui
    conteudos = [];

    await APIServices.getConteudos(await FlutterSession().get('id'))
        .then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        conteudos = list.map((model) => Conteudo.fromObject(model)).toList();
      }
    });
    return true;
  }

  Widget getDica(Conteudo dica) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.format_quote_rounded, size: 50, color: Colors.white),
              Text(dica.titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 35,
                      fontFamily: 'Malu2',
                      color: Colors.white)),
              Text(dica.texto,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 20,
                      fontFamily: 'Malu',
                      color: Colors.white)),
              Row(children: <Widget>[
                Icon(Icons.calendar_today_rounded, color: Colors.white70),
                Text(
                    dica.data.day.toString() +
                        "/" +
                        dica.data.month.toString() +
                        "/" +
                        dica.data.year.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        fontFamily: 'Malu',
                        color: Colors.white70)),
              ])
            ]));
  }

  Widget getNoticia(Conteudo noticia) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.only(left: 25, right: 25, top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Text(noticia.titulo,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
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
                "" +
                    noticia.data.day.toString() +
                    "/" +
                    noticia.data.month.toString() +
                    "/" +
                    noticia.data.year.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                    fontFamily: 'Malu2',
                    color: Colors.grey)),
          ]),
          Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: [
                Text(noticia.texto,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 0.9,
                        fontSize: 15,
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
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.info, size: 20, color: Colors.white),
                    Text(noticia.assunto,
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 15,
                            fontFamily: 'Malu',
                            color: Colors.white)),
                  ]),
              Row(
                children: [
                  Text(
                    noticia.curtidas.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: noticia.curtido ? (Colors.red) : (Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: Icon(Icons.favorite, size: 15, color: Colors.white),
                  )
                ],
              )
            ],
          )
        ]));
  }

  Widget getBlog(Conteudo blog) {
    return Text("Blog");
  }

  Widget getVideo(Conteudo video) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
      Container(
          decoration: BoxDecoration(color: Colors.black),
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(video.titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 20,
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
                        fontSize: 12,
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
                            fontSize: 15,
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
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.info, size: 20, color: Colors.white),
                        Text(video.assunto,
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 15,
                                fontFamily: 'Malu',
                                color: Colors.white)),
                      ]),
                  Row(
                    children: [
                      Text(
                        video.curtidas.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                video.curtido ? (Colors.red) : (Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child:
                            Icon(Icons.favorite, size: 15, color: Colors.white),
                      )
                    ],
                  )
                ],
              )
            ],
          ))
    ]));
  }

  Widget getCabecalho() {
    return Column(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xFF073763)),
          child: Row(children: <Widget>[
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }

                String pesquisa = textEditingValue.text.toLowerCase();

                List<String> ret = [];

                conteudos.forEach((Conteudo conteudo) {
                  ret.addAll(conteudo.texto
                      .split(" ")
                      .where((String palavra) => palavra.contains(pesquisa)));
                  ret.addAll(conteudo.assunto
                      .split(" ")
                      .where((String palavra) => palavra.contains(pesquisa)));
                  ret.addAll(conteudo.titulo
                      .split(" ")
                      .where((String palavra) => palavra.contains(pesquisa)));
                });

                return ret.toSet().toList();
              },
              onSelected: (String selection) {
                print('pesquisar com $selection');
              },
            )
          ])),
      Container(
          decoration: BoxDecoration(color: Color(0xFF20124D)),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8),
              children: <Widget>[
                Container(width: 150, height: 150, child: Text("Text"))
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
            return ListView(children: <Widget>[
              getCabecalho(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: conteudos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (conteudos[index].tipo == "dica")
                    return getDica(conteudos[index]);

                  if (conteudos[index].tipo == "video")
                    return getVideo(conteudos[index]);

                  if (conteudos[index].tipo == "blog")
                    return getBlog(conteudos[index]);

                  return getNoticia(conteudos[index]);
                },
              )
            ]);
          } else {
            // aqui eh tipo uma tela de espera
            return CircularProgressIndicator();
          }
        });
  }
}
