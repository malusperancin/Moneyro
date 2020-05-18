using System.Threading.Tasks;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Data
{
    public interface IRepository
    {
        // Métodos genéricos
        void Add<T>(T entity) where T : class;
        void Update<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;
        Task<bool> SaveChangesAsync();

        Task<Usuarios[]> GetAllUsuariosAsync();
        Task<Usuarios> GetAllUsuarioAsyncByID(int id);
    }
}