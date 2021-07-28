class Usuario {
  int id;
  String nome;
  String apelido;
  String email;
  String celular;
  DateTime dataDeNascimento;
  String foto;
  String senha;
  String cidade;
  String estado;
  bool modoAnonimo;
  bool notificacoes;
  double saldo;
  bool professor;
  int idSala;
  int pontos;

  Usuario(
      this.id,
      this.nome,
      this.apelido,
      this.email,
      this.celular,
      this.dataDeNascimento,
      this.foto,
      this.senha,
      this.cidade,
      this.estado,
      this.modoAnonimo,
      this.notificacoes,
      this.saldo,
      this.professor,
      this.idSala,
      this.pontos);

  Usuario.login(this.apelido, this.senha);

  Usuario.fromObject(dynamic o) {
    this.id = o["id"];
    this.nome = o["nome"];
    this.apelido = o["apelido"];
    this.email = o["email"];
    this.celular = o["celular"];
    this.dataDeNascimento = o["dataDeNascimento"];
    this.foto = o["foto"];
    this.senha = o["senha"];
    this.cidade = o["cidade"];
    this.modoAnonimo = o["modoAnonimo"];
    this.notificacoes = o["notificacoes"];
    this.saldo = o["saldo"];
    this.professor = o["professor"];
    this.idSala = o["idSala"];
    this.pontos = o["pontos"];
  }

  Map toJson() => {
        'id': id,
        'nome': nome,
        'apelido': apelido,
        'email': email,
        'celular': celular,
        'dataDeNascimento': dataDeNascimento,
        'foto': foto,
        'senha': senha,
        'cidade': cidade,
        'estado': estado,
        'modoAnonimo': modoAnonimo,
        'notificacoes': notificacoes,
        'saldo': saldo,
        'professor': professor,
        'idSala': idSala,
        'pontos': pontos
      };
}