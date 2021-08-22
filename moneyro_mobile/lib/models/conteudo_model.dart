class Conteudo {
  int id;
  String titulo;
  String link;
  String texto;
  String imagem;
  String assunto;
  int curtidas;
  String tipo;
  DateTime data;
  bool emAlta;
  bool curtido;

  Conteudo(
      int id,
      String titulo,
      String link,
      String texto,
      String imagem,
      String assunto,
      int curtidas,
      String tipo,
      DateTime data,
      bool emAlta,
      bool curtido);

  Conteudo.fromObject(dynamic o) {
    this.id = o["id"];
    this.titulo = o["titulo"];
    this.link = o["link"];
    this.texto = o["texto"];
    this.imagem = o["imagem"];
    this.assunto = o["assunto"];
    this.curtidas = o["curtidas"];
    this.tipo = o["tipo"];
    this.data = DateTime.tryParse(o["data"]);
    this.emAlta = o["emAlta"];
    this.curtido = o["curtido"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["titulo"] = titulo;
    map["link"] = link;
    map["texto"] = texto;
    map["imagem"] = imagem;
    map["assunto"] = assunto;
    map["curtidas"] = curtidas;
    map["tipo"] = tipo;
    map["data"] = data.toIso8601String();
    map["emAlta"] = emAlta;
    map["curtido"] = curtido;

    return map;
  }

  Map toJson() => {
        'id': id,
        'titulo': titulo,
        'link': link,
        'texto': texto,
        'imagem': imagem,
        'assunto': assunto,
        'curtidas': curtidas,
        'tipo': tipo,
        'data': data,
        'emAlta': emAlta,
        'curtido': curtido
      };
}
