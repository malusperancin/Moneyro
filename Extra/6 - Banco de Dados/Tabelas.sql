create table Tags
(
    id int identity primary key,
    nome varchar(25) not null
)

create table Assuntos
(
    id int identity primary key,
    nome varchar(50) not null
)

create table Tips
(
    id int identity primary key,
    idAssunto int,
    dica varchar(200),
    autor varchar(60) not null,
    CONSTRAINT FK_idAssuntoT FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(id)
)

create table Videos
(
    id int identity primary key,
    idAssunto int not null,
    video varchar(250) not null,
    titulo varchar(60) not null,
    CONSTRAINT FK_idAssuntoV FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(id)
)

create table Artigos
(
    id int identity primary key,
    idAssunto int not null,
    artigo varchar(300),
    titulo varchar(60) not null,
    CONSTRAINT FK_idAssuntoA FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(id)
)

create table Usuarios
(
    id int identity primary key,
    nome varchar(70) not null,
    apelido varchar(15) not null,
    email varchar(40) not null,
    celular varchar(14) not null,
    dataDeNascimento date not null,
    foto int not null,
    senha varchar(20) not null,
    cidade varchar(30) not null,
    estado varchar(25) not null,
    notificacoes bit not null,
    modoAnonimo bit not null,
    saldo money
)
/*
create table Receitas
(
    id int identity primary key,
    idUsuario int not null,
    idTag int not null,
    data date not null,
    nome varchar(40),
    quantia money not null,
    CONSTRAINT FK_idUsuario FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idTagR FOREIGN KEY (idTag)
    REFERENCES Tags(id)
)
create table Despesas
(
    id int identity primary key,
    idUsuario int not null,
    data date not null,
    nome varchar(40),
    idTag int,
    descricao varchar(60),
    lugar varchar(25),
    quantia money not null,
    idCompartilhamento int, 
    CONSTRAINT FK_idUsuarioDesp FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idTagDesp FOREIGN KEY (idTag)
    REFERENCES Tags(id),
    CONSTRAINT FK_idCompartilhamento FOREIGN KEY (idCompartilhamento)
    REFERENCES Compartilhamentos(id)
)*/

create table Amigos
(
    id int identity primary key,
    idAmigoA int not null,
    idAmigoB int not null,
    aceitou bit not null,
    CONSTRAINT FK_idUsuarioA1 FOREIGN KEY (idAmigoA)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idUsuarioA2 FOREIGN KEY (idAmigoB)
    REFERENCES Usuarios(id)
)

create table Metas(
 id int identity primary key,
 nome varchar(20) not null,
 objetivo money not null,
 atual money,
 dataLimite datetime not null,
 idUsuario int not null,
 idCompartilhamento int,
 CONSTRAINT FK_idCompartilhamentoM FOREIGN KEY (idCompartilhamento)
 REFERENCES Compartilhamentos(id)
)

create table Avaliacoes(
 id int identity primary key,
 qtdEstrelas tinyint not null,
 comentario varchar(250), 
 data datetime not null, 
 idUsuario int not null,
 CONSTRAINT FK_idUsuarioA FOREIGN KEY (idUsuario)
 REFERENCES Usuarios(id)
)
create table Compartilhamentos(
id int primary key identity,
idUsuario int not null,
constraint FK_idUsuario FOREIGN KEY (idUsuario)
REFERENCES Usuarios(id),
)

create table Registros
(
    id int identity primary key,
    idUsuario int not null,
    idTag int,
    nome varchar(40) not null,
    descricao varchar(60),
    lugar varchar(25),
    data date not null,
    quantia money not null, 
    CONSTRAINT FK_idUsuarioReg FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idTagReg FOREIGN KEY (idTag)
    REFERENCES Tags(id),
)
create table Ligacoes(
id int primary key identity,
idRegistro int,
idCompartilhamento int,
CONSTRAINT FK_idRegistro FOREIGN KEY (idRegistro)
REFERENCES Registros(id),
CONSTRAINT FK_idCompartilhamento FOREIGN KEY (idCompartilhamento)
REFERENCES Compartilhamentos(id)
)
