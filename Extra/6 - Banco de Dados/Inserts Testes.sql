-- INSERTS TESTES

insert into Usuarios
values('Giovanna Pavani Martelli', 'gigis', 'giovanna@gmail.com', '(19)99999-9999', '09/08/2004', 1, 'senha123', 'Campinas', 'SP', 0, 0, -10,0,0,null)
insert into Usuarios
values('Maria Luiza Sperancin Mancebo', 'malulis', 'malu@gmail.com', '(19)99999-9999', '02/06/2004', 2, 'senha123', 'Valinhos', 'SP',  0, 0, 1000000,0,300,1)
insert into Usuarios
values('Vinicius Martins Cotrim', 'venizius', 'vini@gmail.com', '(19)99999-9999', '12/02/2004', 3, 'senha123', 'Sumaré', 'SP', 0, 0, 10,1,100,null)

insert into Amigos
values(2, 3)

insert into Tags
values('Alimentação')
insert into Tags
values('Higiene')
insert into Tags
values('Transporte')
insert into Tags
values('Lazer')
insert into Tags
values('Vestuário')

insert into Assuntos
values('Noticias')
insert into Assuntos
values('Estilo de Vida')
insert into Assuntos
values('Economizar')
insert into Assuntos
values('Investimento')
insert into Assuntos
values('Ganhar MONEY')

insert into Tips
values(3, 'Não gaste o que você não tem porr' )

insert into Videos
values(1, 'https://www.youtube.com/watch?v=DPniYsHaE44')

insert into Artigos
values(3, 'https://queroficarrico.com/blog/como-poupar-dinheiro/')

insert into Receitas
values(2, CAST(getDate() AS smalldatetime), 'Mc Donalds', 30)
--se der ruim coloca '' em getDate()

insert into Despesas
values(1, CAST(getDate() AS smalldatetime), 'Frango', 1, 'Comi um frangao show', 'Frango Assado', 24, null)
-- o id de compartilhamento n pode ser 0, tem q ser null

--delete from MCompartilhamentos where iDcompartilhamento = 1
insert into Compartilhamentos
values(1, 3)

insert into Despesas
values(2, CAST(getDate() AS smalldatetime), 'Sorveto', 1, 'Fiquei feliz comendo sorveto', 'Sergel', 12, 1)

SELECT *
FROM RECEITAS
SELECT *
FROM DESPESAS
SELECT *
FROM USUARIOS
SELECT *
FROM COMPARTILHAMENTOS
SELECT *
FROM TAGS
SELECT *
FROM ASSUNTOS
SELECT *
FROM ARTIGOS
SELECT *
FROM VIDEOS
SELECT *
FROM AMIGOS
SELECT *
FROM TIPS

insert into Compartilhamentos
values(1, 1)
insert into Registros
values(3,4, 'Uniformes', 'Uniformes para o time ebinha','Centauro',CAST(getDate() AS smalldatetime),  -240)
insert into Registros
values(2,6,'Mesadinha mes de junho',null,null,CAST(getDate() AS smalldatetime), 300)
insert into Compartilhamentos
values(1)
insert into Ligacoes values(1,1)


select r.nome,r.quantia from Ligacoes l, Compartilhamentos c, Registros r where
c.idUsuario = 1 and
r.id = l.idRegistro

/*//tenho: usuario  ///quero:todas as suas tarefas e comunicados TESTE*/
select t.titulo,c.descricao from TarefasAlunos ta,Tarefas t, Comunicados c
where
ta.idUsuario = 2 and
ta.idTarefa = t.id and
t.idSala = c.idSala 

select * from Usuarios
insert into Salas values(1,'Testes','testes')
insert into Salas values(1,'Sala da Mala','aabc123')
insert into Salas values(2,'Sala de Danca','aabc123')

insert into ProfessoresSalas values (2,3)
insert into ProfessoresSalas values (1,1)

insert into Atividades values(' ',' ',0,' ')
insert into Atividades values('quiz','quiz1.png',0,'Quiz 1')
insert into Atividades values('quiz','quiz2.png',0,'Quiz 2')
insert into Atividades values('jogo','jogo.png',1,'The Game')


insert into Tarefas values(1,GETDATE(),GETDATE()+30,'Facam quiz 1',1)
insert into ProfessoresSalas values(1,1)

insert into Atividades values (1,GETDATE(),'Oi amigos olha q sala legal essa novo né bjs')

insert into Produtos values('Perfil Apaixonado ','perfil4.png', 20)
insert into Produtos values('Perfil Chiq','perfil5.png', 20)
insert into Produtos values('Perfil Caipira','perfil6.png', 20)
insert into Produtos values('Perfil Guei','perfil7.png', 20)
insert into Produtos values('Perfil Brabo','perfil8.png', 20)
insert into Produtos values('Perfil Garota','perfil9.png', 20)
insert into Produtos values('Perfil Pepinha','perfil10.png', 20)
insert into Produtos values('Perfil Estrela','perfil11.png', 20)
insert into Produtos values('Perfil Brasil','perfil12.png', 20)


insert into ProdutoUsuario values(1,4)
insert into ProdutoUsuario values(2,3)
insert into ProdutoUsuario values(3,1)


insert into Conquistas values('')


insert into Perguntas values('Quem descobriu o Brasil?')
insert into Perguntas values('Qual é a mais gay?')

insert into Respostas values('Rodrigo',1,0)
insert into Respostas values('Pablo Vittar',1,1)
insert into Respostas values('Pablo Victor',1,0)
insert into Respostas values('Pedro Alvares Cabral',1,0)

insert into Respostas values('Rodrigo',2,0)
insert into Respostas values('Vinicius',2,0)
insert into Respostas values('As duas',2,1)
insert into Respostas values('Nenhuma',2,0)


select * from postagens
insert into postagens values(2, 'aloalo', GETDATE(), 'comunicado', GETDATE(),1)
insert into postagens values(3, 'atividade da malu', GETDATE(), 'atividade', GETDATE(),3)
