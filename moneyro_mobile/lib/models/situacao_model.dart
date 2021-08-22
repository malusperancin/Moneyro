class Situacao {
  int id;
  String mensagem;
  String cor;

  Situacao(this.id, this.mensagem, this.cor);

  Situacao.fromObject(dynamic o) {
    this.id = o["id"];
    this.mensagem = o["mensagem"];
    this.cor = o["cor"];
    //this.imagem = o[imagem];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["mensagem"] = mensagem;
    map["cor"] = cor;

    return map;
  }

  Map toJson() => {'id': id, 'mensagem': mensagem, 'cor': cor};
}
