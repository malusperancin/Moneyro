-- proc que retorna os ids dos usuários com quem uma despesa é compartilhada
create proc usuariosCOMP_sp
@idDespesa int = null
as
declare @codComp int = null
set @codComp = (select codCompartilhamento from COMPARTILHAMENTOS c, Despesas d where d.idDespesa = @idDespesa and c.idCompartilhamento = d.idCompartilhamento)
select idUsuario 
from
Compartilhamentos
where
codCompartilhamento = @codComp 

usuariosCOMP_sp 3


create trigger Receita_tg on Receitas
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
   select @saldo = saldo from Usuarios where idUsuario = @idUsuario
   set @saldo = @saldo + @dif
   update Usuarios set saldo = @saldo where idUsuario = @idUsuario
  End
 End
 else -- deleted
 Begin
  select @idUsuario = idUsuario from Deleted
  select @saldo = saldo from Usuarios where idUsuario = @idUsuario
  select @dif = quantia from Deleted
  set @saldo = @saldo - @dif
  update Usuarios set saldo = @saldo where idUsuario = @idUsuario
 End
-- inserted
select @idUsuario = idUsuario from Inserted
select @saldo = saldo from Usuarios where idUsuario = @idUsuario
select @dif = quantia from Inserted
set @saldo = @saldo + @dif
update Usuarios set saldo = @saldo where idUsuario = @idUsuario
End


create trigger Despesa_tg on Despesas
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
   select @saldo = saldo from Usuarios where idUsuario = @idUsuario
   set @saldo = @saldo + @dif
   update Usuarios set saldo = @saldo where idUsuario = @idUsuario
  End
 End
 else -- deleted
 Begin
  select @idUsuario = idUsuario from Deleted
  select @saldo = saldo from Usuarios where idUsuario = @idUsuario
  select @dif = quantia from Deleted
  set @saldo = @saldo + @dif
  update Usuarios set saldo = @saldo where idUsuario = @idUsuario
 End
-- inserted
select @idUsuario = idUsuario from Inserted
select @saldo = saldo from MUsuarios where idUsuario = @idUsuario
select @dif = quantia from Inserted
set @saldo = @saldo - @dif
update Usuarios set saldo = @saldo where idUsuario = @idUsuario
End