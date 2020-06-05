-- INSERTS TESTES

insert into Usuarios
values('Giovanna Pavani Martelli', 'gigis', 'giovanna@gmail.com', '(19)99999-9999', '09/08/2004', 1, 'senha123', 'Campinas', 'São Paulo', 0, 1, 0)
insert into Usuarios
values('Maria Luiza Sperancin Mancebo', 'malulis', 'malu@gmail.com', '(19)99999-9999', '02/06/2004', 2, 'senha123', 'Valinhos', 'São Paulo',  0, 0, 1000000)
insert into Usuarios
values('Vinicius Martins Cotrim', 'venizius', 'vini@gmail.com', '(19)99999-9999', '12/02/2004', 3, 'senha123', 'Sumaré', 'São Paulo', 0, 0, 10)

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
