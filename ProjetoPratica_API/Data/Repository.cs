using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;

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

        public async Task<Usuario[]> GetAllUsuariosAsync()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuario> consultaUsuarios = (IQueryable<Usuario>)this.Context.Usuarios;
            consultaUsuarios = consultaUsuarios.OrderBy(u => u.Id);
            return await consultaUsuarios.ToArrayAsync();
        }
        public async Task<Usuario> GetAllUsuarioAsyncByID(int Id)
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Usuario> consultaUsuario = (IQueryable<Usuario>)this.Context.Usuario;
            consultaUsuario = consultaUsuario.OrderBy(u => u.Id).Where(usuario => usuario.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaUsuario.FirstOrDefaultAsync();
        }
    }
}