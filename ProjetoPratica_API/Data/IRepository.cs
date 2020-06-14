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
        void Entry<T>(T entity) where T : class;
        Task<bool> SaveChangesAsync();

        Task<Usuarios[]> GetAllUsuarios();
        Task<Usuarios> GetUsuarioById(int Id);
        Task<Usuarios> GetUsuarioByApelido(string apelido);
        Task<Usuarios> GetUsuarioByEmail(string email);
       
        Task<Registros[]> GetAllRegistros();
        Task<Registros>   GetRegistroById(int Id);
        Task<Registros[]> GetReceitasByUsuario(int IdUsuario);
        Task<Registros[]> GetDespesasByUsuario(int IdUsuario);
        Task<Registros[]> GetRegistrosByUsuario(int IdUsuario);


        Task<Metas[]> GetAllMetas();
        Task<Metas> GetMetaById(int Id);
        Task<Metas[]> GetMetasByUsuario(int IdUsuario);

        Task<Assuntos[]> GetAllAssuntos();
        Task<Assuntos> GetAssuntoById(int Id);

        Task<Tips[]> GetAllTips();
        // Task<Tips[]> GetTipsByAssunto(string Assunto);
        Task<Tips> GetTipById(int Id);

        Task<Videos[]> GetAllVideos();
        Task<Videos> GetVideoById(int Id);

        Task<Amigos> GetAmigoById(int Id);
        Task<Amigos[]> GetAmigosByUsuario(int IdUsuario);
        Task<Amigos[]> GetAllAmigos();
        Task<Amigos[]> GetAmigosByIds(Amigos amigos);
        Task<Artigos[]> GetAllArtigos();
        //Task<Artigos[]> GetArtigosByAssunto(string Assunto);
        Task<Artigos> GetArtigoById(int Id);

        Task<Avaliacoes[]> GetAllAvaliacoes();
        Task<Avaliacoes> GetAvaliacaoById(int Id);

        Task<Tags[]> GetAllTags();
        Task<Tags> GetTagById(int Id);

        Task<Situacoes[]> GetAllSituacoes();
    }
}