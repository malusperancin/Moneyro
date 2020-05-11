create table Tags
(
    idTag int identity primary key,
    nome varchar(25) not null
)

create table Assuntos
(
    idAssunto int identity primary key,
    assunto varchar(50) not null
)

create table Tips
(
    idTips int identity primary key,
    idAssunto int,
    dica varchar(200),
    autor varchar(60) not null,
    CONSTRAINT FK_idAssuntoT FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(idAssunto)
)

create table Videos
(
    idVideo int identity primary key,
    idAssunto int not null,
    video varchar(250) not null,
    titulo varchar(60) not null,
    CONSTRAINT FK_idAssuntoV FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(idAssunto)
)

create table Artigos
(
    idArtigo int identity primary key,
    idAssunto int not null,
    artigo varchar(300),
    titulo varchar(60) not null,
    CONSTRAINT FK_idAssuntoA FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(idAssunto)
)

create table Usuarios
(
    idUsuario int identity primary key,
    nome varchar(70) not null,
    apelido varchar(15) not null,
    email varchar(40) not null,
    celular varchar(14) not null,
    dataDeNascimento date not null,
    foto varchar(300),
    senha varchar(20) not null,
    cidade varchar(30) not null,
    estado varchar(25) not null,
    notificacoes bit not null,		 
    modoAnonimo bit not null,
    saldo money
)

create table Receitas
(
    idReceita int identity primary key,
    idUsuario int not null,
    idTag int not null,
    data Smalldatetime not null,
    nome varchar(40),
    quantia money not null,
    CONSTRAINT FK_idUsuario FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_idTagR FOREIGN KEY (idTag)
    REFERENCES Tags(idTag)
)

create table Compartilhamentos
(
    idCompartilhamento int identity primary key,
    codCompartilhamento int,
    idUsuario int not null,
    CONSTRAINT FK_idUsuarioComp FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(idUsuario)
)

create table Despesas
(
    idDespesa int identity primary key,
    idUsuario int not null,
    data Smalldatetime not null,
    nome varchar(40),
    idTag int,
    descricao varchar(60),
    lugar varchar(25),
    quantia money not null,
    idCompartilhamento int,
    CONSTRAINT FK_idUsuarioDesp FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_idTagDesp FOREIGN KEY (idTag)
    REFERENCES Tags(idTag),
    CONSTRAINT FK_idCompartilhamento FOREIGN KEY (idCompartilhamento)
    REFERENCES Compartilhamentos(idCompartilhamento)
)

create table Amigos
(
    idAmigos int identity primary key,
    idAmigo1 int not null,
    idAmigo2 int not null,
    CONSTRAINT FK_idUsuarioA1 FOREIGN KEY (idAmigo1)
    REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_idUsuarioA2 FOREIGN KEY (idAmigo2)
    REFERENCES Usuarios(idUsuario)
)

create table Metas(
 idMeta int identity primary key,
 nome varchar(20) not null,
 objetivo money not null,
 atual money,
 dataLimite datetime not null,
 idCompartilhamento int,
 CONSTRAINT FK_idCompartilhamentoM FOREIGN KEY (idCompartilhamento)
 REFERENCES Compartilhamentos(idCompartilhamento)
)

create table Avaliacoes(
 idAvaliacao int identity primary key,
 qtdEstrelas tinyint not null,
 comentario varchar(250), 
 data datetime not null, 
 usuario int not null,
 CONSTRAINT FK_idUsuario FOREIGN KEY (idUsuario)
 REFERENCES Usuarios(idUsuario)
)