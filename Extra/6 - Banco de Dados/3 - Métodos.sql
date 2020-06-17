-- ========================================
-- ====== PROCS, TRIGGERS E FUNCTION ======
-- ========================================


--////////////////////////////
--//  PROCS FILTRO USUARIO  //
--////////////////////////////

-- ///// SIMPLES //////
create proc filtroUsuarios_sp
@filtro varchar(50) = null
as
select u.idUsuario, u.nome, u.apelido, u.foto
from Usuarios u
where 
u.nome like '%' + @filtro + '%' or 
u.apelido like '%' + @filtro + '%'

filtroUsuarios_sp 'is'

-- ///// COMPLETA /////
create proc filtroUsuarios_sp
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


--////////////////////////////
--//  TRIGGER ADD REGISTRO  //
--////////////////////////////
create trigger [dbo].[Add_tg] on [dbo].[Registros]
after insert
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
  Begin -- comp não nulo
   declare @qtdComp int = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@comp)
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor

   set @valor = @valor/(@qtdComp)

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
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor
  End
End

--////////////////////////////
--//  TRIGGER DEL REGISTRO  //
--////////////////////////////
create trigger [dbo].[Delete_tg] on [dbo].[Registros]
after delete
as
declare @idUsuario int = null
declare @saldo money = null
declare @comp varchar(50) = null
declare @idAmigo int = null
declare @valor money = null
Begin
 select @valor = quantia from deleted
 select @comp = compartilhamentos from deleted
 if(@comp is null)
  Begin
   select @idUsuario = idUsuario from deleted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo - @valor
   update Usuarios set saldo = @saldo where id = @idUsuario
  end
 else
  Begin -- comp não nulo
   declare @qtdComp int = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@comp)
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor

   set @valor = @valor/(@qtdComp)

   select @idUsuario = idUsuario from deleted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo - @valor
   update Usuarios set saldo = @saldo where id = @idUsuario

   declare amgCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@comp)
   open amgCursor 
   fetch next from amgCursor
   fetch next from amgCursor into @idAmigo
   while @@FETCH_STATUS = 0
   Begin 
    select @saldo = saldo from Usuarios where id = @idAmigo 
    update usuarios set saldo = @saldo - @valor  where id = @idAmigo
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor
  End
End


--///////////////////////////////
--//  TRIGGER UPDATE REGISTRO  //
--///////////////////////////////
create trigger [dbo].[Update_tg] on [dbo].[Registros]
after update
as
declare @idUsuario int = null
declare @saldo money = null
declare @compAnter varchar(50) = null
declare @compAtual varchar(50) = null
declare @idAmigo int = null
declare @valorAnter money = null
declare @valorAtual money = null
declare @dif money = null
Begin
 select @valorAnter = quantia from deleted
 select @valorAtual = quantia from inserted
 select @compAnter = compartilhamentos from deleted
 select @compAtual = compartilhamentos from inserted
 if(@compAnter is null and @compAtual is null) 
  Begin
   if(@valorAnter != @valorAtual)
    Begin
     set @dif = @valorAtual - @valorAnter
     select @idUsuario = idUsuario from inserted
     select @saldo = saldo from Usuarios where id = @idUsuario
     set @saldo = @saldo + @dif
     update Usuarios set saldo = @saldo where id = @idUsuario
    End
  end
 else -- se os comps for diferente e/ou diferente de null
 Begin
  if(@compAnter = @compAtual)
  Begin
   declare @qtdComp int = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAnter)
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor

   set @dif = @valorAtual - @valorAnter
   set @dif = @dif/(@qtdComp)

   select @idUsuario = idUsuario from inserted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo + @dif
   update Usuarios set saldo = @saldo where id = @idUsuario

   declare amgCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAnter)
   open amgCursor 
   fetch next from amgCursor
   fetch next from amgCursor into @idAmigo
   while @@FETCH_STATUS = 0
   Begin 
    select @saldo = saldo from Usuarios where id = @idAmigo
    update usuarios set saldo = @saldo + @dif where id = @idAmigo
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor
  End
 else -- se os comp mudaram
  Begin
  -- tirar de todo mundo do antigo
   set @qtdComp = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAnter)
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor
   set @dif = @valorAnter/(@qtdComp) 
   select @idUsuario = idUsuario from deleted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo - @dif
   update Usuarios set saldo = @saldo where id = @idUsuario

   declare amgCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAnter)
   open amgCursor 
   fetch next from amgCursor
   fetch next from amgCursor into @idAmigo
   while @@FETCH_STATUS = 0
   Begin 
    select @saldo = saldo from Usuarios where id = @idAmigo
    update usuarios set saldo = @saldo - @dif where id = @idAmigo
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor

  -- colocar nos novos
   set @qtdComp = 0
   declare qtdCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAtual)
   open qtdCursor
   fetch next from qtdCursor
   while @@FETCH_STATUS = 0
    Begin
     set @qtdComp =  @qtdComp + 1
     fetch next from qtdCursor
    End
   close qtdCursor
   deallocate qtdCursor

   set @dif = @valorAtual/(@qtdComp) 
   
   select @idUsuario = idUsuario from inserted
   select @saldo = saldo from Usuarios where id = @idUsuario
   set @saldo = @saldo + @dif
   update Usuarios set saldo = @saldo where id = @idUsuario

   declare amgCursor scroll cursor for
   SELECT * FROM dbo.splitstring(@compAtual)
   open amgCursor 
   fetch next from amgCursor
   fetch next from amgCursor into @idAmigo
   while @@FETCH_STATUS = 0
   Begin 
    select @saldo = saldo from Usuarios where id = @idAmigo
    update usuarios set saldo = @saldo + @dif where id = @idAmigo
    fetch next from amgCursor into @idAmigo
   End
   close amgCursor
   deallocate amgCursor
  End
 End
End


--/////////////////////
--//  PROC PLANILHA  //
--/////////////////////
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

--///////////////////////
--//  FUNÇÃO DE SPLIT  //
--///////////////////////
CREATE FUNCTION [dbo].[splitstring] ( @stringToSplit VARCHAR(Max) )
RETURNS
 @returnList TABLE ([Name] int)
AS
BEGIN
 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT
 declare @reg int
--DECLARE @stringToSplit VARCHAR(max) = NULL
-- SET @stringToSplit = LTRIM(@string)

 WHILE CHARINDEX(' ', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(' ', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  set @reg = cast(@name as int)

  INSERT INTO @returnList 
  SELECT @reg
  
  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END