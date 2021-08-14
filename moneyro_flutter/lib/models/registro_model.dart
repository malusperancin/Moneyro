class Registro {
  int id;
  int idUsuario;
  DateTime data;
  String nome;
  int idTag;
  String lugar;
  double quantia;


  Registro(this.id, this.idUsuario, this.data, this.nome, this.idTag,
      this.lugar, this.quantia);

  Registro.fromObject(dynamic o) {
    this.id = o["id"];
    this.idUsuario = o["idUsuario"];
    this.data = new DateTime.now();
    this.nome = o["nome"];
    this.idTag = o["idTag"];
    this.lugar = o["lugar"];
    this.quantia = o["quantia"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["idUsuario"] = idUsuario;
    map["data"] = data.toIso8601String();
    map["nome"] = nome;
    map["idTag"] = idTag;
    map["lugar"] = lugar;
    map["quantia"] = quantia;

    return map;
  }

  Map toJson() => {
    'id': id,
    'idUsuario': idUsuario,
    'data': data,
    'nome': nome,
    'idTag': idTag,
    'lugar': lugar,
    'quantia': quantia,
  };
}