class Situacao {
  int id;
  String frase;
  String cor;

  Situacao(this.id, this.frase, this.cor);

  Situacao.fromObject(dynamic o) {
    this.id = o["id"];
    this.frase = o["frase"];
    this.cor = o["cor"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["frase"] = frase;
    map["cor"] = cor;

    return map;
  }

  Map toJson() => {'id': id, 'frase': frase, 'cor': cor};
}
