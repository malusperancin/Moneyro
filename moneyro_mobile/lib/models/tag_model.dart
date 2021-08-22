class Tag {
  int id;
  String nome;

  Tag(this.id, this.nome);

  Tag.fromObject(dynamic o) {
    this.id = o["id"];
    this.nome = o["nome"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["nome"] = nome;

    return map;
  }

  Map toJson() => {'id': id, 'nome': nome};
}
