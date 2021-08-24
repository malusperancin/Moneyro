import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyro_mobile/ui/feed/feed.dart';
import 'package:moneyro_mobile/ui/mais/mais.dart';
import 'package:moneyro_mobile/ui/planilha/planilha.dart';
import 'package:flutter_session/flutter_session.dart';

import '../login.dart';
import 'cofre/cofre.dart';

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

  int _selectedPage = 2;

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
    var id = await FlutterSession().get("id");
    bool sessao_ativa = id == null || id <= 0 ? false : true;

    if (!sessao_ativa)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));

    return true;
  }

  /*
  Telas do menu:
    - Planilha (só fazer se sobrar tempo)
    - Cofre
    - Feed (só fazer se sobrar tempo)
    - Mais (só fazer se sobrar tempo)

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
                child: SafeArea(
                    child: Scaffold(
                        backgroundColor: Theme.of(context).backgroundColor,
                        body: IndexedStack(
                          index: _selectedPage,
                          children: _children,
                        ),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation
                                .centerDocked, //specify the location of the FAB
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            setState(() {});
                          },
                          tooltip: "Adicionar registro",
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: Icon(Icons.add_rounded, size: 30.0),
                          ),
                          elevation: 2.0,
                        ),
                        bottomNavigationBar: BottomAppBar(
                            color: Theme.of(context).primaryColorDark,
                            notchMargin: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: 65,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedPage = 0;
                                      });
                                    },
                                    icon: Icon(Icons.savings_rounded,
                                        color: _selectedPage == 0
                                            ? Colors.green[500]
                                            : Colors.white30),
                                    iconSize: 35.0,
                                    splashColor: Colors.green[50],
                                    tooltip: 'Cofre',
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedPage = 1;
                                      });
                                    },
                                    icon: Icon(Icons.reorder_rounded,
                                        color: _selectedPage == 1
                                            ? Colors.amber[500]
                                            : Colors.white30),
                                    iconSize: 35.0,
                                    splashColor: Colors.amber[50],
                                    tooltip: 'Planilha',
                                  ),
                                  Spacer(flex: 4),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedPage = 2;
                                      });
                                    },
                                    icon: Icon(Icons.calendar_view_day_rounded,
                                        color: _selectedPage == 2
                                            ? Colors.indigo[500]
                                            : Colors.white30),
                                    iconSize: 35.0,
                                    splashColor: Colors.indigo[50],
                                    tooltip: 'Feed',
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedPage = 3;
                                      });
                                    },
                                    icon: Icon(Icons.face_rounded,
                                        color: _selectedPage == 3
                                            ? Colors.cyan[500]
                                            : Colors.white30),
                                    iconSize: 35.0,
                                    splashColor: Colors.cyan[50],
                                    tooltip: 'Mais',
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            shape: CircularNotchedRectangle()))));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
