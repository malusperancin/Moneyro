using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;
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

        public async Task<Usuarios[]> GetAllUsuarios()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuarios> consultaUsuarios = (IQueryable<Usuarios>)this.Context.Usuarios;
            Console.WriteLine("yess");
            //consultaUsuarios = consultaUsuarios.OrderBy(u => u.IdUsuario);
            return await consultaUsuarios.ToArrayAsync();
        }
        public async Task<Usuarios> GetUsuarioByID(int Id)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuarios> consultaUsuario = (IQueryable<Usuarios>)this.Context.Usuarios;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }

        public async Task<Receitas[]> GetAllReceitas()
        {

        }
        public async Task<Receitas> GetReceitaById(int Id)
        {

        }
        public async Task<Receitas> GetReceitasByUsuario(int UsuarioId)
        {

        }

        public async Task<Despesas[]> GetAllDespesas()
        {

        }
        public async Task<Despesas> GetDespesaById(int Id)
        {

        }
        public async Task<Despesas[]> GetDespesasByUsuario(int UsuarioId)
        {

        }

        public async Task<Metas[]> GetAllMetas()
        {

        }
        public async Task<Metas> GetMetaById(int Id)
        {

        }
        public async Task<Metas[]> GetMetasByUsuario(int UsuarioId)
        {

        }

        public async Task<Assuntos[]> GetAllAssuntos()
        {

        }
        public async Task<Assuntos> GetAssuntoById(int Id)
        {

        }


        public async Task<Tips[]> GetAllTips()
        {

        }
        public async Task<Tips[]> GetTipsByAssunto(string Assunto)
        {

        }
        public async Task<Tips> GetTipById(int Id)
        {

        }

        public async Task<Videos[]> GetAllVideos()
        {

        }
        public async Task<Videos> GetVideoById(int Id)
        {

        }

        public async Task<Amigos> GetAmigoById(int Id)
        {

        }
        public async Task<Amigos[]> GetAmigosByUsuario(int UsuarioId)
        {

        }
        public async Task<Amigos[]> GetAllAmigos()
        {

        }

        public async Task<Artigos[]> GetAllArtigos()
        {

        }
        public async Task<Artigos[]> GetArtigosByAssunto(string Assunto)
        {

        }
        public async Task<Artigos> GetArtigoById(int Id)
        {

        }

        public async Task<Compartilhamentos[]> GetCompartilhamentosByCodigo(int Codigo)
        {

        }
        public async Task<Compartilhamentos> GetCompartilhamentoById(int Id)
        {

        }

        public async Task<Avaliacoes[]> GetAllAvaliacoes()
        {

        }
        public async Task<Avaliacoes> GetAvaliacaoById(int Id)
        {

        }

        public async Task<Tags[]> GetAllTags()
        {

        }
        public async Task<Tags> GetTagById(int Id)
        {

        }
    }
}