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

        Task<Usuarios[]> GetAllUsuarios();
        Task<Usuarios> GetUsuarioById(int Id);
        Task<Usuarios> GetUsuarioByApelido(string apelido);
        Task<Usuarios> GetUsuarioByEmail(string email);

        Task<Receitas[]> GetAllReceitas();
        Task<Receitas> GetReceitaById(int Id);
        Task<Receitas[]> GetReceitasByUsuario(int IdUsuario);

        Task<Despesas[]> GetAllDespesas();
        Task<Despesas> GetDespesaById(int Id);
        Task<Despesas[]> GetDespesasByUsuario(int IdUsuario);

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

        Task<Artigos[]> GetAllArtigos();
        //Task<Artigos[]> GetArtigosByAssunto(string Assunto);
        Task<Artigos> GetArtigoById(int Id);

        Task<Compartilhamentos[]> GetCompartilhamentosByCodigo(int Codigo);
        Task<Compartilhamentos> GetCompartilhamentoById(int Id);

        Task<Avaliacoes[]> GetAllAvaliacoes();
        Task<Avaliacoes> GetAvaliacaoById(int Id);

        Task<Tags[]> GetAllTags();
        Task<Tags> GetTagById(int Id);
    }
}