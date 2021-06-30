using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System;

namespace ProjetoPratica_API.Data
{
    public class Repository : IRepository
    {
        public MoneyroContext Context { get; }
        public Repository(MoneyroContext context)
        {
            this.Context = context;
        }
        public void Add<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Add(entity);
        }
        public void Delete<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Remove(entity);
        }
        public async Task<bool> SaveChangesAsync()
        {
            // Como é tipo Task vai gerar thread, então vamos definir o método como assíncrono (async)
            // Por ser assíncrono, o return deve esperar (await) se tem alguma coisa para salvar no BD
            // Ainda verifica se fez alguma alteração no BD, se for maior que 0 retorna true ou false
            return (await this.Context.SaveChangesAsync() > 0);
        }
        public void Update<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Update(entity);
        }

        public void Entry<T>(T entity) where T : class
        {
            this.Context.Entry(entity).State = EntityState.Detached;
        }

        public async Task<Usuarios[]> GetAllUsuarios()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuarios> consultaUsuarios = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuarios = consultaUsuarios.OrderByDescending(u => u.Id).Where(user => user.ModoAnonimo == false);

            return await consultaUsuarios.ToArrayAsync();
        }
        public async Task<Usuarios> GetUsuarioById(int Id)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuarios> consultaUsuario = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

        public async Task<Usuarios> GetUsuarioByNome(string nome)
        {
            IQueryable<Usuarios> consultaUsuario = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuario = consultaUsuario.Where(usuario => usuario.Nome.Equals(nome));
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

        public async Task<Usuarios> GetUsuarioByApelido(string apelido)
        {
            IQueryable<Usuarios> consultaUsuario = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Apelido.Equals(apelido));
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

        public async Task<Usuarios> GetUsuarioByEmail(string email)
        {
            IQueryable<Usuarios> consultaUsuario = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Email == email);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

        public async Task<Usuarios> GetUsuarioCurtidaByIdUsuario(int UsuarioId)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuarios> consultaCurtidas = (IQueryable<Usuarios>)this.Context.CurtidasUsuarios;
            consultaCurtidas = consultaCurtidas.OrderBy(u => u.Id).Where(usuario => usuario.Id == UsuarioId);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaCurtidas.FirstOrDefaultAsync();
        }

        public async Task<Conquistas[]> GetAllConquistas()
        {
            IQueryable<Conquistas> consultaConquistas = (IQueryable<Conquistas>)this.Context.Conquistas;
            return await consultaConquistas.ToArrayAsync();
        }

        public async Task<Registros[]> GetAllRegistros()
        {
            IQueryable<Registros> consultaRegistros = (IQueryable<Registros>)this.Context.Registros;
            return await consultaRegistros.ToArrayAsync();
        }

        public async Task<Registros> GetRegistroById(int Id)
        {
            IQueryable<Registros> consultaRegistro = (IQueryable<Registros>)this.Context.Registros;
            consultaRegistro = consultaRegistro.OrderBy(r => r.Id).Where(registro => registro.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaRegistro.FirstOrDefaultAsync();
        }

        public async Task<Registros[]> GetDespesasByUsuario(int IdUsuario)
        {
            IQueryable<Registros> consultaRegistros = (IQueryable<Registros>)this.Context.Registros;
            consultaRegistros = consultaRegistros.Where(registro => registro.IdUsuario == IdUsuario);
            consultaRegistros = consultaRegistros.OrderByDescending(r => r.Data).Where(registro => registro.Quantia < 0);
            return await consultaRegistros.ToArrayAsync();
        }

        public async Task<Registros[]> GetReceitasByUsuario(int IdUsuario)
        {
            IQueryable<Registros> consultaRegistros = (IQueryable<Registros>)this.Context.Registros;
            consultaRegistros = consultaRegistros.Where(registro => registro.IdUsuario == IdUsuario);
            consultaRegistros = consultaRegistros.OrderByDescending(r => r.Data).Where(registro => registro.Quantia > 0);
            return await consultaRegistros.ToArrayAsync();
        }
        public async Task<Metas[]> GetMetasCompartilhadas(int UsuarioId, int AmigoId)
        {
            IQueryable<Metas> consultaMeta = (IQueryable<Metas>)this.Context.Metas;
            consultaMeta = consultaMeta.OrderByDescending(r => r.DataLimite)
                                               .Where(Meta => Meta.IdUsuario == UsuarioId &&
                                                              Meta.Compartilhamentos.Contains(" " + AmigoId + " ") ||
                                                              Meta.IdUsuario == AmigoId &&
                                                              Meta.Compartilhamentos.Contains(" " + UsuarioId + " "));
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaMeta.ToArrayAsync();
        }

        public async Task<Metas[]> GetAllMetas()
        {
            IQueryable<Metas> consultaMetas = (IQueryable<Metas>)this.Context.Metas;
            return await consultaMetas.ToArrayAsync();
        }
        public async Task<Metas> GetMetaById(int Id)
        {
            IQueryable<Metas> consultaMeta = (IQueryable<Metas>)this.Context.Metas;
            consultaMeta = consultaMeta.OrderBy(m => m.Id).Where(meta => meta.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaMeta.FirstOrDefaultAsync();
        }
        public async Task<Metas[]> GetMetasByUsuario(int IdUsuario)
        {
            IQueryable<Metas> consultaMeta = (IQueryable<Metas>)this.Context.Metas;
            consultaMeta = consultaMeta.OrderBy(m => m.DataLimite).Where(meta => meta.IdUsuario == IdUsuario || meta.Compartilhamentos.Contains(" " + IdUsuario + " "));
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaMeta.ToArrayAsync();
        }

        public async Task<Amigos[]> GetAmigosByIds(Amigos amigos)
        {
            IQueryable<Amigos> consultaAmigos = (IQueryable<Amigos>)this.Context.Amigos;

            // consultaAmigos = consultaAmigos.Where(a => a.Aceitou == true);
            consultaAmigos = consultaAmigos.OrderBy(a => a.Id).Where(a => a.IdAmigoA == amigos.IdAmigoA && a.IdAmigoB == amigos.IdAmigoB);
            //consultaAmigos = consultaAmigos.Where(a => a.Aceitou == 1);

            return await consultaAmigos.ToArrayAsync();
        }

        public async Task<Amigos> GetAmigoById(int Id)
        {
            IQueryable<Amigos> consultaAmigo = (IQueryable<Amigos>)this.Context.Amigos;
            consultaAmigo = consultaAmigo.OrderBy(a => a.Id).Where(amigo => amigo.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaAmigo.FirstOrDefaultAsync();
        }

        public async Task<Amigos[]> GetAmigosByUsuario(int IdUsuario)
        {
            IQueryable<Amigos> consultaAmigos = (IQueryable<Amigos>)this.Context.Amigos;

            consultaAmigos = consultaAmigos.OrderByDescending(a => a.Aceitou).Where(a => a.IdAmigoA == IdUsuario || a.IdAmigoB == IdUsuario);
            consultaAmigos = consultaAmigos.Where(a => a.Aceitou == 0);

            return await consultaAmigos.ToArrayAsync();
        }

        public async Task<Amigos[]> GetAllAmigosByUsuario(int IdUsuario)
        {
            IQueryable<Amigos> consultaAmigos = (IQueryable<Amigos>)this.Context.Amigos;
            consultaAmigos = consultaAmigos.OrderByDescending(a => a.Aceitou).Where(a => a.IdAmigoA == IdUsuario || a.IdAmigoB == IdUsuario);

            return await consultaAmigos.ToArrayAsync();
        }

        public async Task<Amigos[]> GetAllAmigos()
        {
            IQueryable<Amigos> consultaAmigos = (IQueryable<Amigos>)this.Context.Amigos;
            return await consultaAmigos.ToArrayAsync();
        }
        public async Task<Avaliacoes[]> GetAllAvaliacoes()
        {
            IQueryable<Avaliacoes> consultaAvaliacao = (IQueryable<Avaliacoes>)this.Context.Avaliacoes;
            return await consultaAvaliacao.ToArrayAsync();
        }

        public async Task<Avaliacoes> GetAvaliacaoById(int Id)
        {
            IQueryable<Avaliacoes> consultaAvaliacao = (IQueryable<Avaliacoes>)this.Context.Avaliacoes;
            consultaAvaliacao = consultaAvaliacao.OrderBy(a => a.Id).Where(avaliacao => avaliacao.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaAvaliacao.FirstOrDefaultAsync();
        }

        public async Task<Tags[]> GetAllTags()
        {
            IQueryable<Tags> consultaTag = (IQueryable<Tags>)this.Context.Tags;
            return await consultaTag.ToArrayAsync();
        }

        public async Task<Tags> GetTagById(int Id)
        {
            IQueryable<Tags> consultaTag = (IQueryable<Tags>)this.Context.Tags;
            consultaTag = consultaTag.OrderBy(t => t.Id).Where(tag => tag.Id == Id);

            return await consultaTag.FirstOrDefaultAsync();
        }

        public async Task<Situacoes[]> GetAllSituacoes()
        {
            IQueryable<Situacoes> consultaSituacoes = (IQueryable<Situacoes>)this.Context.Situacoes;
            return await consultaSituacoes.ToArrayAsync();
        }

        public async Task<Notificacoes[]> GetAllNotificacoes()
        {
            IQueryable<Notificacoes> consultaNotificacoes = (IQueryable<Notificacoes>)this.Context.Notificacoes;
            return await consultaNotificacoes.ToArrayAsync();
        }
        public async Task<Notificacoes> GetNotificacaoById(int Id)
        {
            IQueryable<Notificacoes> consultaNotificacao = (IQueryable<Notificacoes>)this.Context.Notificacoes;
            consultaNotificacao = consultaNotificacao.OrderBy(t => t.Id).Where(not => not.Id == Id);

            return await consultaNotificacao.FirstOrDefaultAsync();
        }

        public async Task<Notificacoes[]> GetNotificacoesByUsuario(int IdDestino)
        {
            IQueryable<Notificacoes> consultaNotificacao = (IQueryable<Notificacoes>)this.Context.Notificacoes;
            consultaNotificacao = consultaNotificacao.OrderBy(t => t.Visualizada).Where(not => not.IdDestino == IdDestino);

            return await consultaNotificacao.ToArrayAsync();
        }

        public async Task<Notificacoes[]> GetNotificacoesByUsuarioVisu(int IdDestino)
        {
            IQueryable<Notificacoes> consultaNotificacao = (IQueryable<Notificacoes>)this.Context.Notificacoes;
            consultaNotificacao = consultaNotificacao.OrderBy(t => t.Visualizada).Where(not => not.IdDestino == IdDestino && not.Visualizada == 0);

            return await consultaNotificacao.ToArrayAsync();
        }

        public async Task<Tarefas> GetTarefaById(int Id)
        {
            IQueryable<Tarefas> consultaTarefas = (IQueryable<Tarefas>)this.Context.Tarefas;
            consultaTarefas = consultaTarefas.OrderBy(t => t.Id).Where(tarefa => tarefa.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaTarefas.FirstOrDefaultAsync();
        }

        public async Task<Tarefas[]> GetAllTarefas()
        {
            IQueryable<Tarefas> consultaTarefas = (IQueryable<Tarefas>)this.Context.Tarefas;
            return await consultaTarefas.ToArrayAsync();
        }

        public async Task<Salas[]> GetAllSalas()
        {
            IQueryable<Salas> consultaSalas = (IQueryable<Salas>)this.Context.Salas;
            return await consultaSalas.ToArrayAsync();
        }

        public async Task<Comunicados[]> GetAllComunicados()
        {
            IQueryable<Comunicados> consultaComunicados = (IQueryable<Comunicados>)this.Context.Comunicados;
            return await consultaComunicados.ToArrayAsync();
        }

        public async Task<Comunicados> GetComunicadoById(int Id)
        {
            IQueryable<Comunicados> consultaComunicados = (IQueryable<Comunicados>)this.Context.Comunicados;
            consultaComunicados = consultaComunicados.OrderBy(c => c.Id).Where(com => com.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaComunicados.FirstOrDefaultAsync();
        }

        public async Task<Atividades[]> GetAllAtividades()
        {
            IQueryable<Atividades> consultaAtividades = (IQueryable<Atividades>)this.Context.Atividades;
            consultaAtividades = consultaAtividades.OrderBy(a => a.Id).Where(ativ => ativ.Id > 0);
            return await consultaAtividades.ToArrayAsync();
        }

        public async Task<Atividades> GetAtividadeById(int Id)
        {
            IQueryable<Atividades> consultaAtividades = (IQueryable<Atividades>)this.Context.Atividades;
            consultaAtividades = consultaAtividades.OrderBy(a => a.Id).Where(ativ => ativ.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaAtividades.FirstOrDefaultAsync();
        }

        public async Task<Compras[]> GetAllCompras()
        {
            IQueryable<Compras> consultaCompras = (IQueryable<Compras>)this.Context.Compras;
            return await consultaCompras.ToArrayAsync();
        }

        public async Task<Trocas[]> GetAllTrocas()
        {
            IQueryable<Trocas> consultaTrocas = (IQueryable<Trocas>)this.Context.Trocas;
            return await consultaTrocas.ToArrayAsync();
        }

        public List<Salas> GetSalasByIdProfessor(int IdProfessor)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getSalasProfessor " + IdProfessor;

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Salas>();

            while (leitor.Read())
            {
                Salas dados = new Salas(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (int)leitor["idProfessor"],
                    (string)leitor["professor"],
                    (string)leitor["codigo"]);

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public async Task<Postagens[]> GetPostagensBySalaId(int Id)
        {
            IQueryable<Postagens> consultaPostagens = (IQueryable<Postagens>)this.Context.Postagens;
            consultaPostagens = consultaPostagens.OrderBy(p => p.IdSala).Where(post => post.IdSala == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaPostagens.ToArrayAsync();
        }


        public async Task<Postagens> GetPostagemById(int Id)
        {
            IQueryable<Postagens> consultaPostagens = (IQueryable<Postagens>)this.Context.Postagens;
            consultaPostagens = consultaPostagens.OrderBy(p => p.Id).Where(postagem => postagem.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaPostagens.FirstOrDefaultAsync();
        }

        public async Task<Conteudos[]> GetAllConteudos()
        {
            IQueryable<Conteudos> consultaConteudos = (IQueryable<Conteudos>)this.Context.Conteudos;
            return await consultaConteudos.ToArrayAsync();
        }


        /* =========================== SPs ================================*/

        public List<Conteudos> SpGetConteudosByUsuario(int UsuarioId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getConteudosUsu " + UsuarioId;

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Conteudos>();

            while (leitor.Read())
            {
                Conteudos dados = new Conteudos(
                    (int)leitor["id"],
                    (string)leitor["titulo"],
                    (string)leitor["link"],
                    (string)leitor["texto"],
                    (string)leitor["imagem"],
                    (string)leitor["assunto"],
                    (int)leitor["curtidas"],
                    (string)leitor["tipo"],
                    (DateTime)leitor["data"],
                    (bool)leitor["emAlta"],
                    (bool)leitor["curtido"]
                );

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public Salas SpGetSalaByCodigo(string codigo)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getSalaByCod '" + codigo + "'";

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Salas>();

            while (leitor.Read())
            {
                Salas dados = new Salas(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (int)leitor["idProfessor"],
                    (string)leitor["professor"],
                    (string)leitor["codigo"]
                );

                result.Add(dados);
            }

            con.Close();
            return result[0];
        }

        public Salas SpGetSalaById(int Id)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getSalaById " + Id;

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Salas>();

            while (leitor.Read())
            {
                Salas dados = new Salas(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (int)leitor["idProfessor"],
                    (string)leitor["professor"],
                    (string)leitor["codigo"]);

                result.Add(dados);
            }

            con.Close();
            return result[0];
        }

        public List<Quiz> SpQuiz(int QuizId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_quiz " + QuizId;

            SqlDataReader leitor = cmd.ExecuteReader();

            var aux = new List<Quiz>();

            while (leitor.Read())
            {
                Quiz dados = new Quiz(
                    (string)leitor["pergunta"],
                    (string)leitor["alternativa"],
                    (bool)leitor["correta"]);

                aux.Add(dados);
            }

            string pergunta = "";
            string[] alternativas;

            var result = new List<Quiz>();

            for (int i = 0; i < aux.Count; i += 4)
            {
                alternativas = new string[4];
                int correta = -1;

                for (int j = 0; j < 4; j++)
                {
                    alternativas[j] = aux[i + j].Alternativa;
                    pergunta = aux[i].Descricao;

                    if (aux[i + j].Correta)
                        correta = j;
                }

                result.Add(new Quiz(aux[i].Descricao, alternativas, correta));
            }

            con.Close();
            return result;
        }


        public void SpCriarSala(ref Salas sala)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            var result = new string(
            Enumerable.Repeat(chars, 6)
                .Select(s => s[random.Next(s.Length)])
                .ToArray());

            sala.Codigo = result;

            cmd.CommandText = "sp_CriarSala " + sala.IdProfessor + ", '" + sala.Nome + "' , '" + sala.Codigo + "'";
            cmd.ExecuteNonQuery();

            con.Close();
        }

        public void SpExcluirSala(int id)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_DeletarSala " + id;
            cmd.ExecuteNonQuery();

            con.Close();
        }

        public void SpDeletarPostagemById(Postagens post)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            if (post.Tipo == "atividade")
                cmd.CommandText = "sp_DeletarTarefa " + post.Id;
            else
                cmd.CommandText = "sp_DeletarComunicado " + post.Id;

            cmd.ExecuteNonQuery();

            con.Close();
        }


        public List<Postagens> SpGetPostagensBySalaCod(string codigo)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_GetPostagensCod '" + codigo + "'";

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Postagens>();

            while (leitor.Read())
            {
                Postagens dados = new Postagens(
                    (int)leitor["id"],
                    (int)leitor["idSala"],
                    (string)leitor["descricao"],
                    (DateTime)leitor["data"],
                    (string)leitor["tipo"],
                    (DateTime)leitor["dataEntrega"],
                    (int)leitor["idAtividade"]);

                result.Add(dados);
            }

            result.Reverse();

            con.Close();
            return result;
        }

        public void SpAtualizarUsuarioSala(int idUsu, int idSala)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_updateSalaUsuario " + idSala + ", " + idUsu;

            cmd.ExecuteNonQuery();
            con.Close();
        }

        public List<Trocas> SpGetTrocasByUsuario(int IdUsuario)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getTrocasByUsuario " + IdUsuario;

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<Trocas>();

            while (leitor.Read())
            {
                Trocas dados = new Trocas(
                    (int)leitor["id"],
                    (string)leitor["nome"],
                    (string)leitor["foto"],
                    (int)leitor["preco"]);

                result.Add(dados);
            }
            con.Close();
            return result;
        }

        public void SpAddTrocaUsuario(int IdUsuario, int IdTroca)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_addTrocaUsuario " + IdUsuario + ", " + IdTroca;

            SqlDataReader leitor = cmd.ExecuteReader();

            con.Close();
        }

        public List<String> SpGetFotosByUsuario(int UsuarioId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getFotosByUsuario " + UsuarioId;

            SqlDataReader leitor = cmd.ExecuteReader();
            var result = new List<String>();
            while (leitor.Read())
                result.Add((string)leitor["foto"]);

            con.Close();
            return result;
        }

        public void SpDescurtir(CurtidasUsuarios cu)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_descurtirConteudo " + cu.IdUsuario + "," + cu.IdConteudo;
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public void SpCancelaProfessor(int id)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_cancelaprof " + id;
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public void SpCurtir(CurtidasUsuarios cu)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_curtirConteudo " + cu.IdUsuario + "," + cu.IdConteudo;
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public List<TarefaUsuario> SpGetRelatorioTarefa(int TarefaId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getRelatorioTarefa " + TarefaId;

            SqlDataReader leitor = cmd.ExecuteReader();
            var result = new List<TarefaUsuario>();

            while (leitor.Read())
            {
                TarefaUsuario dados = new TarefaUsuario(
                    (string)leitor["nomeAluno"],
                    (string)leitor["fotoAluno"],
                    (bool)leitor["concluido"],
                    (double)leitor["nota"]);

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public Postagens SpAddTarefa(Postagens post)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            if (post.Tipo == "comunicado")
                cmd.CommandText = "sp_addComunicado " + post.IdSala + ", '" + post.Descricao + "', '" + post.Data + "', '" + post.Tipo + "', '" + post.DataEntrega + "', " + post.IdAtividade;
            else
                cmd.CommandText = "sp_addTarefa " + post.IdSala + ", '" + post.Descricao + "', '" + post.Data + "', '" + post.Tipo + "', '" + post.DataEntrega + "', " + post.IdAtividade;

            SqlDataReader leitor = cmd.ExecuteReader();

            while (leitor.Read())
                post.Id = Convert.ToInt32(leitor["id"]);

            con.Close();
            return post;
        }

        public void SpAddPontos(int UsuarioID, int AtividadeID, double Pontos, double Total)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_addPontos " + UsuarioID + ", " + AtividadeID + ", " + Pontos + ", " + Total;

            cmd.ExecuteReader();
            con.Close();
        }

        public object SpVerificaConclusao(int UsuarioID, int AtividadeID)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_verificaConclusao " + UsuarioID + ", " + AtividadeID;

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<object>();

            while (leitor.Read())
            {
                object[] dados = {
                    leitor["nota"],
                    leitor["concluido"]
                };

                result.Add(dados);
            }

            con.Close();

            return result[0];

        }

        public void SpComprarProf(int UsuarioID)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_comprarProf " + UsuarioID;

            cmd.ExecuteReader();
            con.Close();
        }

        public void SpUpdateRegistro(Registros novo, Registros an)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            //cmd.CommandText = $"update registros set idTag={novo.IdTag}, nome={novo.Nome}, lugar={novo.Lugar},"" + UsuarioID;

            //if()

            cmd.ExecuteReader();
            con.Close();
        }

        public void SpDeleteRegistro(int RegistroId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_apagarRegistro " + RegistroId;

            cmd.ExecuteNonQuery();
            con.Close();
        }

        public List<Registros> SpGetRegistrosCompartilhados(int UsuarioId, int AmigoId)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getRegistrosCompartilhados " + UsuarioId + "," + AmigoId;

            SqlDataReader leitor = cmd.ExecuteReader();
            var result = new List<Registros>();

            while (leitor.Read())
            {
                Registros dados = new Registros(
                    (int)leitor["id"],
                    (int)leitor["idUsuario"],
                    (DateTime)leitor["data"],
                    (string)leitor["nome"],
                    (int)leitor["idTag"],
                    (string)leitor["lugar"],
                    (decimal)leitor["quantia"]);

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public List<Registros> SpGetRegistrosByUsuario(int IdUsuario)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_getRegistrosUsuario " + IdUsuario;

            SqlDataReader leitor = cmd.ExecuteReader();
            var result = new List<Registros>();

            while (leitor.Read())
            {
                Registros dados = new Registros(
                    (int)leitor["id"],
                    (int)leitor["idUsuario"],
                    (DateTime)leitor["data"],
                    (string)leitor["nome"],
                    (int)leitor["idTag"],
                    (string)leitor["lugar"],
                    (decimal)leitor["quantia"]);

                result.Add(dados);
            }

            con.Close();
            return result;
        }

        public List<object> GetCompByIdRegistro(int RegistroId)
        {
            SqlConnection conn = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand("comando", conn);
            cmd.CommandText = "select u.foto, u.id,u.nome from Usuarios u, CompartilhadosRegistro rg where rg.idRegistro = " + RegistroId + " and u.id = rg.idCompartilhado ";

            SqlDataReader leitor = cmd.ExecuteReader();

            var result = new List<object>();

            while (leitor.Read())
            {
                object[] dados = {
                    leitor["id"],
                    leitor["foto"],
                    leitor["nome"]
                };

                result.Add(dados);
            }

            conn.Close();

            return result;
        }

        public void SpSairRegistro(int IdRegistro, int IdCompartilhado)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_sairRegistro " + IdRegistro + ", " + IdCompartilhado;

            cmd.ExecuteNonQuery();

            con.Close();
        }

        public void SpUpdateCompartilhados(int IdRegistro, int IdCompartilhado)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);
            cmd.CommandText = "sp_updateCompartilhados " + IdRegistro + ", " + IdCompartilhado;

            cmd.ExecuteNonQuery();

            con.Close();
        }

        public async Task<CompartilhadosRegistro> GetCompById(int IdCompartilhamento)
        {
            IQueryable<CompartilhadosRegistro> consultaComp = (IQueryable<CompartilhadosRegistro>)this.Context.CompartilhadosRegistro;
            consultaComp = consultaComp.OrderBy(c => c.Id).Where(comp => comp.Id == IdCompartilhamento);
            // aqui efetivamente ocorre o SELECT no BD
            return consultaComp.FirstOrDefault();
        }

        public void SpAddCompartilhados(int idRegistro, int idComp, int tam)
        {
            SqlConnection con = new SqlConnection(this.Context.Database.GetDbConnection().ConnectionString);
            con.Open();

            SqlCommand cmd = new SqlCommand("comando", con);

            cmd.CommandText = "sp_addCompartilhados " + idRegistro + "," + idComp + "," + tam;

            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}