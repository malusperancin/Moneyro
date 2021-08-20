import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Moneyro/models/usuario_model.dart';

class APIServices {
  static final String url = 'http://192.168.15.90:5000/api/';
  //static final String url = 'http://192.168.15.155:5000/api/';
  //static final String url = 'http://143.106.203.92:5000/api/';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future login(Usuario usuario) async {
    return await http.post(Uri.parse(url + 'usuarios/login/'),
        headers: header, body: json.encode(usuario.toMap()));
  }

  static Future getUsuario(int id) async {
    return await http.get(Uri.parse(url + 'usuarios/' + id.toString()));
  }

  static Future getSituacoes() async {
    return await http.get(Uri.parse(url + 'situacoes'));
  }

  static Future getRegistros(int id) async {
    return await http.get(Uri.parse(url + 'registros/todos/' + id.toString()));
  }

  static Future getCompartilhados(int id) async {
    return await http
        .get(Uri.parse(url + 'compartilhadoRegistros/usu/' + id.toString()));
  }

  static Future getTags() async {
    return await http.get(Uri.parse(url + 'tags'));
  }

  /*

  static Future buscarEquipes() async {
    return await http.get(Uri.parse(url + 'equipes'));
  }

  static Future buscarLugares() async {
    return await http.get(Uri.parse(url + 'lugares'));
  }

  static Future buscarTipos() async {
    return await http.get(Uri.parse(url + 'tipos'));
  }

  static Future buscarEventoPorId(int id) async {
    return await http.get(Uri.parse(url + 'eventos/' + id.toString()));
  }

  static Future<bool> adicionarEvento(Evento evento) async {
    var resultado = await http.post(Uri.parse(url + "eventos"),
        headers: header, body: json.encode(evento.toJson()));
    return Future.value(resultado.statusCode == 200 ? true : false);
  }

  static Future editarEvento(Evento evento) async {
    return await http.put(Uri.parse(url + 'eventos/' + evento.id.toString()),
        headers: header, body: json.encode(evento.toJson()));
  }

  static Future<bool> deletarEvento(Evento evento) async {
    var resultado =
        await http.delete(Uri.parse(url + 'eventos/' + evento.id.toString()));
    return Future.value(resultado.statusCode == 200 ? true : false);
  }*/
}
