import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneyro_mobile/models/registro_model.dart';
import 'package:moneyro_mobile/ui/feed/feed.dart';
import 'package:moneyro_mobile/ui/mais/mais.dart';
import 'package:moneyro_mobile/ui/planilha/planilha.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:moneyro_mobile/ui/registro/despesa.dart';
import 'package:moneyro_mobile/ui/registro/receita.dart';

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
    
      DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    
  */
  _showMyDialog() {
    // playSom();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.white,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColorDark,
                bottom: TabBar(
                  indicatorColor: Theme.of(context).primaryColorLight,
                  tabs: [
                    Tab(
                        child: Row(children: <Widget>[
                      Text("Despesa"),
                      Icon(Icons.arrow_circle_up_rounded)
                    ])),
                    Tab(
                        child: Row(children: <Widget>[
                      Text("Receita"),
                      Icon(Icons.arrow_circle_down_rounded)
                    ])),
                  ],
                ),
                title: Text('Novo Registro'),
              ),
              body: TabBarView(
                children: [Despesa(), Receita()],
              ),
            ),
          ),
        );
      },
    );
  }

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
                  extendBody: true,
                  backgroundColor: Theme.of(context)
                      .backgroundColor, // erro do floating button
                  body: IndexedStack(
                    index: _selectedPage,
                    children: _children,
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation
                      .centerDocked, //specify the location of the FAB
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      _showMyDialog();
                    },
                    tooltip: "Adicionar registro",
                    backgroundColor: Theme.of(context).buttonColor,
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: Icon(Icons.add_rounded, size: 30.0),
                    ),
                    elevation: 2.0,
                  ),
                  bottomNavigationBar: BottomAppBar(
                    color: Theme.of(context).primaryColorDark,
                    notchMargin: 4,
                    shape: CircularNotchedRectangle(),
                    child: Container(
                      height: 60,
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
                          Spacer(flex: 5),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedPage = 2;
                              });
                            },
                            icon: Icon(Icons.calendar_view_day_rounded,
                                color: _selectedPage == 2
                                    ? Color(0xffed6b0e)
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
                  ),
                )));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
