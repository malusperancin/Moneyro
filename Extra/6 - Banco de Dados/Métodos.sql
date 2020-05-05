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

select * from despesas
select * from receitas
select * from usuarios

alter proc planilha_sp
@id int = null
as
declare @idRegistro int
declare @data datetime
declare @idTag int
declare @nome varchar(40)
declare @quantia money
Begin
create table #Planilha
(
  id int primary key identity,
  idRegistro int,
  data datetime,
  idTag int,
  nome varchar(50),
  quantia money
)
declare receitaCursor scroll cursor for
select 
idReceita as 'idRegistro', data as 'data', idTag as 'idTag', nome as 'nome', quantia as 'quantia'
from
Receitas
where idUsuario = @id
open receitaCursor
fetch next from receitaCursor into @idRegistro, @data, @idTag, @nome, @quantia
while @@FETCH_STATUS = 0
begin
 insert into #Planilha values(@idRegistro, @data, @idTag, @nome, @quantia)
 fetch next from receitaCursor into @idRegistro, @data, @idTag, @nome, @quantia
end
close receitaCursor
deallocate receitaCursor

declare despesaCursor scroll cursor for
select idDespesa as 'idRegistro', data as 'data', idTag as 'idTag', nome as 'nome', quantia as 'quantia'
from
Despesas
where idUsuario = @id
open despesaCursor
fetch next from despesaCursor into @idRegistro, @data, @idTag, @nome, @quantia
while @@FETCH_STATUS = 0
begin
 insert into #Planilha values(@idRegistro, @data, @idTag, @nome, -@quantia)
 fetch next from despesaCursor into @idRegistro, @data, @idTag, @nome, @quantia
end
close despesaCursor
deallocate despesaCursor
select * from #Planilha group by data
End

planilha_sp 2

select count(data), data from receitas where idUsuario=2 group by data
select count(data), data from despesas where idUsuario=2 group by data

alter table despesas
ALTER COLUMN data date not null

insert into receitas values(2, GETDATE(), 'salario', 1.00, 2)
insert into receitas values(2, GETDATE(), 'salariosds', 2.00, 2)

create proc countDias_sp
@id int = null
Begin
select count(data), data from receitas where idUsuario=2 group by data
select count(data), data from despesas where idUsuario=2 group by data
End