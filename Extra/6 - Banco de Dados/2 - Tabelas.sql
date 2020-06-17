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
    dica varchar(200) not null,
    autor varchar(60) not null,
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
    artigo varchar(300) not null,
    titulo varchar(60) not null,
	foto varchar(300),
    CONSTRAINT FK_idAssuntoA FOREIGN KEY (idAssunto)
    REFERENCES Assuntos(id)
)

create table Situacoes
(
	id int identity primary key,
	mensagem varchar(200),
	cor varchar(7)
)

create table Usuarios
(
    id int identity primary key,
    nome varchar(70) not null,
    apelido varchar(15) not null,
    email varchar(40) not null,
    celular varchar(15) not null,
    dataDeNascimento date not null,
    foto int not null,
    senha varchar(20) not null,
    cidade varchar(30) not null,
    estado varchar(25) not null,
    notificacoes bit not null,
    modoAnonimo bit not null,
    saldo money
)

create table Registros
(
    id int identity primary key,
    idUsuario int not null,
    idTag int,
	nome varchar(40) not null,
	lugar varchar(25),
	data date not null,
    quantia money not null,
    compartilhamentos varchar(50) 
    CONSTRAINT FK_idUsuarioReg FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idTagReg FOREIGN KEY (idTag)
    REFERENCES Tags(id),
)

create table Amigos
(
    id int identity primary key,
    idAmigoA int not null,
    idAmigoB int not null,
    aceitou int not null,
    CONSTRAINT FK_idUsuarioA1 FOREIGN KEY (idAmigoA)
    REFERENCES Usuarios(id),
    CONSTRAINT FK_idUsuarioA2 FOREIGN KEY (idAmigoB)
    REFERENCES Usuarios(id)
)

create table Metas
(
	id int identity primary key,
	nome varchar(20) not null,
	objetivo money not null,
	atual money,
	dataLimite datetime not null,
	compartilhamentos varchar(50),
	idUsuario int not null,
	CONSTRAINT FK_idUsuarioM FOREIGN KEY (idUsuario)
    REFERENCES Usuarios(id)
)

create table Avaliacoes
(
	id int identity primary key,
	qtdEstrelas tinyint not null,
	comentario varchar(250), 
	data datetime not null, 
	idUsuario int not null,
	CONSTRAINT FK_idUsuarioA FOREIGN KEY (idUsuario)
	REFERENCES Usuarios(id)
)

create table Notificacoes
(
	id int primary key identity,
	idOrigem int,
	idDestino int not null,
	mensagem varchar(150) not null,
	visualizada TINYINT not null,
	data date,
	CONSTRAINT FK_idOrigem FOREIGN KEY (idOrigem)
	REFERENCES Usuarios(id),
	CONSTRAINT FK_idDestino FOREIGN KEY (idDestino)
	REFERENCES Usuarios(id)
)