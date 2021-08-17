class Compartilhados {
  int id;
  String foto;
  String nome;
  int idRegistro;

  Compartilhados(this.id, this.foto, this.nome, this.idRegistro);

  Compartilhados.fromObject(dynamic o) {
    this.id = o[0];
    this.foto = o[1];
    this.nome = o[2];
    this.idRegistro = o[3];
  }

  /* Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["foto"] = foto;
    map["nome"] = nome;
    map["idRegistro"] = idRegistro;

    return map;
  }*/
/*
  Map toJson() =>
      {'id': id, 'foto': foto, 'nome': nome, 'idRegistro': idRegistro};*/
}
