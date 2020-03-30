-- INSERTS TESTES

insert into MUsuarios values('Giovanna Pavani Martelli','gigis','giovanna@gmail.com','(19)99999-9999','09/08/2004','https://www.cecom.unicamp.br/wp-content/uploads/2020/02/1800x1200_coronavirus_1.jpg','senha123','Campinas','São Paulo','Brasil',0,1,0)
insert into MUsuarios values('Maria Luiza Sperancin Mancebo','malulis','malu@gmail.com','(19)99999-9999','02/06/2004','https://sigaband.files.wordpress.com/2013/11/6e6bd-f_216031.jpg','senha123','Valinhos','São Paulo','Brasil',0,0,1000000)
insert into MUsuarios values('Vinicius Martins Cotrim','venizius','vini@gmail.com','(19)99999-9999','12/02/2004','https://www.gfcasadecor.com/imagens/produtos/HA-3623/Detalhes/girafa-adulta-hansa-creation.jpg','senha123','Sumaré','São Paulo','Brasil',0,0,10)

insert into MAmigos values(2,3)

insert into MTags values('Alimentação')
insert into MTags values('Higiene')
insert into MTags values('Transporte')
insert into MTags values('Lazer')
insert into MTags values('Vestuário')

insert into MAssuntos values('Noticias')
insert into MAssuntos values('Estilo de Vida')
insert into MAssuntos values('Economizar')
insert into MAssuntos values('Investimento')
insert into MAssuntos values('Ganhar MONEY')

insert into MTips values(3,'Não gaste o que você não tem porr' )

insert into MVideos values(1,'https://www.youtube.com/watch?v=DPniYsHaE44')

insert into MArtigos values(3,'https://queroficarrico.com/blog/como-poupar-dinheiro/')

insert into MReceitas values(2, CAST(getDate() AS smalldatetime),'Mc Donalds',30) --se der ruim coloca '' em getDate()

insert into MDespesas values(1,CAST(getDate() AS smalldatetime),'Frango',1,'Comi um frangao show','Frango Assado',24,null)
-- o id de compartilhamento n pode ser 0, tem q ser null

--delete from MCompartilhamentos where iDcompartilhamento = 1
insert into MCompartilhamentos values(1, 3)

insert into MDespesas values(2, CAST(getDate() AS smalldatetime), 'Sorveto', 1, 'Fiquei feliz comendo sorveto', 'Sergel', 12, 1)

SELECT * FROM MRECEITAS
SELECT * FROM MDESPESAS
SELECT * FROM MUSUARIOS
SELECT * FROM MCOMPARTILHAMENTOS
SELECT * FROM MTAGS
SELECT * FROM MASSUNTOS
SELECT * FROM MARTIGOS
SELECT * FROM MVIDEOS
SELECT * FROM MAMIGOS
SELECT * FROM MTIPS

-- proc que retorna os ids dos usuários com quem uma despesa é compartilhada
create proc usuariosCOMP_sp
@idDespesa int = null
as
declare @codComp int = null
set @codComp = (select codCompartilhamento from MCOMPARTILHAMENTOS c, MDespesas d where d.idDespesa = @idDespesa and c.idCompartilhamento = d.idCompartilhamento)
select idUsuario 
from
MCompartilhamentos
where
codCompartilhamento = @codComp 

usuariosCOMP_sp 3


create trigger Receita_tg on MReceitas
for update, insert
as
Begin
declare @valorAnterior money = null
declare @valorAtual money = null
declare @idUsuario int = null
declare @saldo money = null
declare @dif money = null
-- update
If Exists (Select idReceita From Deleted)
 If Exists (Select idReceita From Inserted)
 Begin
  select @valorAnterior = quantia from Deleted
  select @valorAtual = quantia from Inserted
  if(@valorAtual != @valorAnterior)
  Begin
   select @idUsuario = idUsuario from Deleted
   set @dif = @valorAtual - @valorAnterior
   select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
   set @saldo = @saldo + @dif
   update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
  End
 End
 else -- deleted
 Begin
  select @idUsuario = idUsuario from Deleted
  select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
  select @dif = quantia from Deleted
  set @saldo = @saldo - @dif
  update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
 End
-- inserted
select @idUsuario = idUsuario from Inserted
select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
select @dif = quantia from Inserted
set @saldo = @saldo + @dif
update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
End


create trigger Despesa_tg on MDespesas
for update, insert
as
Begin
declare @valorAnterior money = null
declare @valorAtual money = null
declare @idUsuario int = null
declare @saldo money = null
declare @dif money = null
-- update
If Exists (Select idDespesa From Deleted)
 If Exists (Select idDespesa From Inserted)
 Begin
  select @valorAnterior = quantia from Deleted
  select @valorAtual = quantia from Inserted
  if(@valorAtual != @valorAnterior)
  Begin
   select @idUsuario = idUsuario from Deleted
   set @dif = @valorAnterior - @valorAtual
   select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
   set @saldo = @saldo + @dif
   update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
  End
 End
 else -- deleted
 Begin
  select @idUsuario = idUsuario from Deleted
  select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
  select @dif = quantia from Deleted
  set @saldo = @saldo + @dif
  update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
 End
-- inserted
select @idUsuario = idUsuario from Inserted
select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
select @dif = quantia from Inserted
set @saldo = @saldo - @dif
update MUsuarios set saldo = @saldo where idUsuario = @idUsuario
End