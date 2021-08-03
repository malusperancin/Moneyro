import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcc/ui/cofre/cofre.dart';
import 'package:tcc/ui/feed/feed.dart';
import 'package:tcc/ui/login.dart';
import 'package:tcc/ui/mais/mais.dart';
import 'package:tcc/ui/planilha/planilha.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_session/flutter_session.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  List<Widget> _children = [
    new CofreScreen(),
    new PlanilhaScreen(),
    new FeedScreen(),
    new MaisScreen()
  ];

  int _selectedPage = 0;

  Future<void> createInstances() async {
    setState(() {
      _children = [
        new CofreScreen(),
        new PlanilhaScreen(),
        new FeedScreen(),
        new MaisScreen()
      ];
    });
  }

  Future<bool> fetchData() async {
    bool sessao_ativa = await FlutterSession().get("id") == null ? false : true;

    if (!sessao_ativa)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));

    return true;
  }

  /*
  Telas do menu:
    - Planilha
    - Cofre
    - Feed
    - Mais

  Telas do mais (só fazer se sobrar tempo): 
    - Amigos
    - Metas
    - Perfil
    - Sobre
    - Sair
  */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
                onRefresh: createInstances,
                child: Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body: IndexedStack(
                      index: _selectedPage,
                      children: _children,
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //specify the location of the FAB
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        setState(() { 
                          
                        });
                      },
                      tooltip: "Adicionar registro",
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Icon(Icons.add_rounded, size: 30.0),
                      ),
                      elevation: 2.0,
                    ),
                    bottomNavigationBar: BottomAppBar(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 70,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPage = 0;
                                });
                              },
                              icon: Icon(Icons.savings_rounded,
                                  color: _selectedPage == 0
                                      ? Colors.green[500]
                                      : Colors.green[100]),
                              iconSize: 35.0,
                              splashColor: Colors.green[50],
                              tooltip: 'Cofre',
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPage = 1;
                                });
                              },
                              icon: Icon(Icons.reorder_rounded,
                                  color: _selectedPage == 1
                                      ? Colors.amber[500]
                                      : Colors.amber[100]),
                              iconSize: 35.0,
                              splashColor: Colors.amber[50],
                              tooltip: 'Planilha',
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPage = 2;
                                });
                              },
                              icon: Icon(Icons.article_rounded,
                                  color: _selectedPage == 2
                                      ? Colors.indigo[500]
                                      : Colors.indigo[100]),
                              iconSize: 35.0,
                              splashColor: Colors.indigo[50],
                              tooltip: 'Feed',
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPage = 3;
                                });
                              },
                              icon: Icon(Icons.face_rounded,
                                  color: _selectedPage == 3
                                      ? Colors.cyan[500]
                                      : Colors.cyan[100]),
                              iconSize: 35.0,
                              splashColor: Colors.cyan[50],
                              tooltip: 'Mais',
                            )
                          ],
                        ),
                      ),
                      shape: CircularNotchedRectangle()
                    )));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
