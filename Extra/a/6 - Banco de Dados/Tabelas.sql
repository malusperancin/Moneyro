create table MTags
(
    idTag int identity primary key,
    nome varchar(25) not null
)

create table MAssuntos
(
    idAssunto int identity primary key,
    assunto varchar(50) not null
)

create table MTips
(
    idTips int identity primary key,
    idAssunto int,
    dica varchar(200),
    CONSTRAINT FK_idAssuntoT FOREIGN KEY (idAssunto)
    REFERENCES MAssuntos(idAssunto)
)

create table MVideos
(
    idVideo int identity primary key,
    idAssunto int not null,
    video varchar(250) not null,
    CONSTRAINT FK_idAssuntoV FOREIGN KEY (idAssunto)
    REFERENCES MAssuntos(idAssunto)
)

create table MArtigos
(
    idArtigo int identity primary key,
    idAssunto int not null,
    artigo varchar(300),
    CONSTRAINT FK_idAssuntoA FOREIGN KEY (idAssunto)
    REFERENCES MAssuntos(idAssunto)
)

create table MUsuarios
(
    idUsuario int identity primary key,
    nome varchar(70) not null,
    apelido varchar(20) not null,
    email varchar(40) not null,
    celular varchar(14) not null,
    dataDeNascimento date not null,
    foto varchar(300),
    senha varchar(20) not null,
    cidade varchar(30) not null,
    estado varchar(25) not null,
    pais varchar(25) not null,
    notificacoes bit not null,		 
    modoAnonimo bit not null,
    saldo money
)

create table MReceitas
(
    idReceita int identity primary key,
    idUsuario int not null,
    data Smalldatetime not null,
    nome varchar(40),
    quantia money not null,
    CONSTRAINT FK_idUsuario FOREIGN KEY (idUsuario)
    REFERENCES MUsuarios(idUsuario)
)

create table MDespesas
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
    REFERENCES MUsuarios(idUsuario),
    CONSTRAINT FK_idTagDesp FOREIGN KEY (idTag)
    REFERENCES MTags(idTag),
    CONSTRAINT FK_idCompartilhamento FOREIGN KEY (idCompartilhamento)
    REFERENCES MCompartilhamentos(idCompartilhamento)
)

create table MCompartilhamentos
(
    idCompartilhamento int identity primary key,
	codCompartilhamento int,
    idUsuario int not null,
    CONSTRAINT FK_idUsuarioComp FOREIGN KEY (idUsuario)
    REFERENCES MUsuarios(idUsuario)
)

create table MAmigos
(
    idAmigos int identity primary key,
    idAmigo1 int not null,
    idAmigo2 int not null,
    CONSTRAINT FK_idUsuarioA1 FOREIGN KEY (idAmigo1)
    REFERENCES MUsuarios(idUsuario),
    CONSTRAINT FK_idUsuarioA2 FOREIGN KEY (idAmigo2)
    REFERENCES MUsuarios(idUsuario)
)

-- util: 
-- alter table MTips ALTER COLUMN idAssunto int null
