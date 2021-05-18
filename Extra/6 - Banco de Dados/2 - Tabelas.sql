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
	professor bit,
	pontos int,
	idSala int,
	saldo money,
	CONSTRAINT FK_idSala FOREIGN KEY (idSala)
	REFERENCES Salas(id)
)

create table Perguntas
(
	id int identity primary key, 
	descricao varchar(300),
	idQuiz int not null
)

create table Respostas
(
	id int identity primary key, 
	descricao varchar(300), 
	idPergunta int,
	correta bit,
	CONSTRAINT FK_idPergunta FOREIGN KEY (idPergunta)
	REFERENCES Perguntas(id)
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


/************************************************************************/

create table Salas
(
id int primary key identity,
idProfessor int not null,
nome varchar(100) not null,
codigo varchar(10) not null,
CONSTRAINT FK_idProfessor FOREIGN KEY (idProfessor)
REFERENCES Usuarios(id)
)

create table Comunicados
(
id int primary key identity,
idSala int not null,
data date,
descricao varchar(600) not null,
CONSTRAINT FK_idSala1 FOREIGN KEY (idSala)
REFERENCES Salas(id)
)

create table Atividades
(
id int primary key identity,
tipo varchar(100) not null,
foto varchar(200),
exclusivo bit not null,
nome varchar(100)
)

create table Tarefas
(
id int primary key identity,
idSala int not null,
data date,
dataEntrega date,
titulo varchar(100),
idAtividade int not null,
CONSTRAINT FK_idAtividade FOREIGN KEY (idAtividade)
REFERENCES Atividades(id),
CONSTRAINT FK_idSala2 FOREIGN KEY (idSala)
REFERENCES Salas(id)
)


create table ProfessoresSalas
(
id int primary key identity,
idUsuario int not null,
idSala int not null,
CONSTRAINT FK_idUsuario3 FOREIGN KEY (idUsuario)
REFERENCES Usuarios(id),
CONSTRAINT FK_idSala3 FOREIGN KEY (idSala)
REFERENCES Salas(id)
)

create table TarefasAlunos
(
id int primary key identity,
idUsuario int not null,
idTarefa int not null,
concluido bit not null,
nota float,
CONSTRAINT FK_idUsuario2 FOREIGN KEY (idUsuario)
REFERENCES Usuarios(id),
CONSTRAINT FK_idTarefa FOREIGN KEY (idTarefa)
REFERENCES Tarefas(id)
)

create table Conquistas
(
id int primary key identity,
nome varchar(100) not null,
descricao varchar(100) not null,
foto varchar(100) not null,
pontos int not null,
objetivo int not null
)

create table UsuarioConquistas
(
id int primary key identity,
idUsuario int not null,
idConquista int not null,
CONSTRAINT FK_idUsuario1 FOREIGN KEY (idUsuario)
REFERENCES Usuarios(id),
CONSTRAINT FK_idConquista FOREIGN KEY (idConquista)
REFERENCES Conquistas(id)
)

create table Produtos
(
id int primary key identity,
nome varchar(100) not null,
foto varchar(100) not null,
preco float not null
)

create table ProdutoUsuario
(
id int primary key identity,
idUsuario int not null,
idProduto int not null,
CONSTRAINT FK_idUsuario4 FOREIGN KEY (idUsuario)
REFERENCES Usuarios(id),
CONSTRAINT FK_idProduto FOREIGN KEY (idProduto)
REFERENCES Produtos(id)
)

