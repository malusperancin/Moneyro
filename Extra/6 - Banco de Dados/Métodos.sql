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

create proc filtroUsuarios_sp
@filtro varchar(50) = null
as
select u.idUsuario, u.nome, u.apelido, u.foto
from Usuarios u
where 
u.nome like '%' + @filtro + '%' or 
u.apelido like '%' + @filtro + '%'

filtroUsuarios_sp 'is'


create table Amigos
(
    idAmigos int identity primary key,
    idAmigo1 int not null,
    idAmigo2 int not null,
    aceitou int not null,
    CONSTRAINT FK_idUsuarioA1 FOREIGN KEY (idAmigo1)
    REFERENCES Usuarios(idUsuario),
    CONSTRAINT FK_idUsuarioA2 FOREIGN KEY (idAmigo2)
    REFERENCES Usuarios(idUsuario)
)
drop table amigos

insert into amigos values(2, 3, 1)
insert into amigos values(1, 2, 0)

alter proc filtroUsuarios_sp
@filtro varchar(50) = null,
@idUsuario int = null
as
declare @idAmigo int
declare @nome varchar(100)
declare @apelido varchar(20)
declare @foto varchar(300)
declare @aceitou int
Begin
create table #ListaUsuarios
(
  id int primary key identity,
  idAmigo int,
  nome varchar(100),
  apelido varchar(20),
  foto varchar(300),
  aceitou int
)
declare listAmigosCursor scroll cursor for
select u.idUsuario, u.nome, u.apelido, u.foto
from Usuarios u
where 
u.nome like '%' + @filtro + '%' or 
u.apelido like '%' + @filtro + '%'
open listAmigosCursor
fetch next from listAmigosCursor into @idAmigo, @nome, @apelido, @foto
while @@FETCH_STATUS = 0
begin
 select @aceitou = aceitou from Amigos where idAmigo1=@idUsuario and idAmigo2=@idAmigo or idAmigo2=@idUsuario and idAmigo1=@idAmigo
 insert into #ListaUsuarios values(@idAmigo, @nome, @apelido, @foto, @aceitou)
 fetch next from listAmigosCursor into @idAmigo, @nome, @apelido, @foto
end
close listAmigosCursor
deallocate listAmigosCursor
-- a.aceitou 
select * from amigos

--a.idAmigo1 = @thisUsuario and a.idAmigo2 = @outroUsuario or
--a.idAmigo1 = @outroUsuario and a.idAmigo2 = @thisUsuario and

-- ERRADA
/*create trigger Registro_tg on Registros
for update, insert
as
Begin
declare @valorAnterior money = null
declare @valorAtual money = null
declare @idUsuario int = null
declare @saldo money = null
declare @dif money = null
declare @compAtual varchar(50) = null
declare @compAnterior varchar(50) = null
-- update
If Exists (Select id From Deleted)
 If Exists (Select id From Inserted)
 Begin
  select @valorAnterior = quantia from Deleted
  select @valorAtual = quantia from Inserted
  select @compAnterior = compartilhamentos from Deleted
  select @compAtual = compartilhamentos from Inserted

  if(@valorAtual != @valorAnterior)
  Begin
   set @dif = @valorAtual - @valorAnterior
   if(@compAtual == @compAnterior && @compAtual == null) -- apenas 1 usuario
   Begin 
     select @idUsuario = idUsuario from Deleted
     select @saldo = saldo from Usuarios where idUsuario = @idUsuario
     set @saldo = @saldo + @dif
   End
   else if(@compAnterior != @compAtual)
   Begin 
   declare anterCursor scroll cursor for
   SELECT value FROM STRING_SPLIT(@compAnterior, ' ')
   declare atualCursor scroll cursor for
   SELECT value FROM STRING_SPLIT(@compAtual, ' ')  
   open anterCursor  
   open antualCursor
   fetch next from anterCursor into @idAmigoAnt
   fetch next from atualCursor into @idAmigoAtu
   while @@FETCH_STATUS = 0
   begin
   if(@idAmigoAnt == @idAmigoAtu)
   Begin
    select @saldo = saldo from Usuarios where idUsuario = @idAmigoAnt
    set @saldo = @saldo + @dif
    fetch next from anterCursor into @idAmigoAnt
    fetch next from atualCursor into @idAmigoAtu
   End
   else
   Begin
    if(@idAmigoAnt < idAmigoAtu)
    Begin  
     select @saldo = saldo from Usuarios where idUsuario = @idAmigoAnt
     set @saldo = @saldo + @dif
     fetch next from anterCursor into @idAmigoAnt
    End
    else
    Begin
     select @saldo = saldo from Usuarios where idUsuario = @idAmigoAtu
     set @saldo = @saldo + @dif
     fetch next from anterCursor into @idAmigoAtu
    End
   End
   close anterCursor
   deallocate anterCursor
   close atualCursor
   deallocate atualCursor
  End
 End
 else -- deleted
 Begin
  select @idUsuario = idUsuario from Deleted
  select @compAnterior = compartilhamentos from Deleted
  select @dif = quantia from Deleted
  
  select @saldo = saldo from Usuarios where idUsuario = @idUsuario
  set @saldo = @saldo - @dif
  update Usuarios set saldo = @saldo where idUsuario = @idUsuario
  
  if(@compAnterior != null)
  Begin 
   declare amgCursor scroll cursor for
   SELECT value FROM STRING_SPLIT(@compAnterior, ' ')
   open amgCursor 
   fetch next from amgCursor into @idAmigo
   Begin 
    select @saldo = saldo from Usuarios where idUsuario = @idAmigo
    set @saldo = @saldo - @dif
    fetch next from anterCursor into @idAmigoAnt
   End 
  End
 End
else
Begin
-- inserted
select @idUsuario = idUsuario from Inserted
select @dif = quantia from Inserted
select @compAtual = compartilhamentos from Inserted

select @saldo = saldo from Usuarios where idUsuario = @idUsuario
set @saldo = @saldo + @dif
update Usuarios set saldo = @saldo where idUsuario = @idUsuario

if(@compAtual != null)
  Begin 
   declare amgCursor scroll cursor for
   SELECT value FROM STRING_SPLIT(@compAnterior, ' ')
   open amgCursor 
   fetch next from amgCursor into @idAmigo
   Begin 
    select @saldo = saldo from Usuarios where idUsuario = @idAmigo
    set @saldo = @saldo + @dif
    fetch next from anterCursor into @idAmigoAnt
   End 
  End
End*/

//-------------------------
//   TRIGGER LINDISSIMA
//------------------------
create trigger RegistroAdd_tg on Registros
for insert
as
declare @idUsuario int = null
declare @saldo money = null
declare @comp varchar(50) = null
declare @idAmigo int = null
declare @valor money = null
Begin
 select @valor = quantia from inserted
 select @comp = compartilhamentos from inserted
 if(@comp is null)
  Begin
   select @idUsuario = idUsuario from inserted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo + @valor
   update Usuarios set saldo = @saldo where id = @idUsuario
  end
 else
  Begin
   declare @qtdComp int = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(' 1 ')
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor

   set @valor = @valor/(@qtdComp +1)

   select @idUsuario = idUsuario from inserted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo + @valor
   update Usuarios set saldo = @saldo where id = @idUsuario

   declare amgCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@comp)
   open amgCursor 
   fetch next from amgCursor
   fetch next from amgCursor into @idAmigo
   while @@FETCH_STATUS = 0
   Begin 
    select @saldo = saldo from Usuarios where id = @idAmigo
    update usuarios set saldo = @saldo + @valor  where id = @idAmigo
    --print cast(@idAmigo as varchar) + ' ' + cast(@saldo as varchar)
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor
  End
end

select * from despesas
select * from receitas
select * from usuarios

create proc planilha_sp
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