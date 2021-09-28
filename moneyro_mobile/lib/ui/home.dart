import 'package:flutter/material.dart';
import 'package:Moneyro/ui/feed/feed.dart';
import 'package:Moneyro/ui/mais/mais.dart';
import 'package:Moneyro/ui/planilha/planilha.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:Moneyro/ui/registro/despesa.dart';
import 'package:Moneyro/ui/registro/receita.dart';

import '../login.dart';
import 'cofre/cofre.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  List<Widget> _children;
  int _selectedPage = 0;

  Future<bool> fetchData() async {
    var id = await FlutterSession().get("id");
    bool sessaoAtiva = id == null || id <= 0 ? false : true;

    if (!sessaoAtiva)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));

    if (_children == null || _children.length == 0)
      _children = [
        new CofreScreen(),
        new PlanilhaScreen(),
        new FeedScreen(),
        new MaisScreen()
      ];

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

  _showMyDialog() {
    // playSom();

    var despesa = Despesa();
    var receita = Receita();

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding:
              EdgeInsets.only(left: 25, right: 25, bottom: 75, top: 55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.black12,
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                primary: false,
                centerTitle: true,
                backgroundColor: Theme.of(context).primaryColorDark,
                title: Text('Novo Registro',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        fontFamily: 'Malu2',
                        color: Colors.white)),
                toolbarHeight: 85,
                bottom: TabBar(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.deepPurple,
                  ),
                  indicatorWeight: 5,
                  indicatorColor: Theme.of(context).primaryColorLight,
                  tabs: [
                    Tab(
                        child: Text("Despesa",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1.8,
                                fontFamily: 'Malu2',
                                color: Colors.white))),
                    Tab(
                        child: Text("Receita",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                height: 1.8,
                                fontFamily: 'Malu2',
                                color: Colors.white))),
                  ],
                ),
              ),
              body: TabBarView(
                children: [despesa, receita],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Scaffold(
              extendBody: true,
              backgroundColor: Theme.of(context).backgroundColor,
              body: IndexedStack(
                index: _selectedPage,
                children: _children,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //specify the location of the FAB
              resizeToAvoidBottomInset: false,
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
                notchMargin: 8,
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
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
