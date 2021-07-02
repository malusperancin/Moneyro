using System.Collections.Generic;
using System.Threading.Tasks;
using ProjetoPratica_API.Models;
using System.Data;
using System;

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
        Task<Usuarios> GetUsuarioByNome(string nome);
        Task<Usuarios> GetUsuarioByApelido(string apelido);
        Task<Usuarios> GetUsuarioByEmail(string email);
        object SpVerificaConclusao(int UsuarioID, int AtividadeID);
        List<String> SpGetFotosByUsuario(int UsuarioId);
        void SpAddPontos(int UsuarioID, int AtividadeID, double Pontos, double Total);
        void SpCancelaProfessor(int id);
        void SpComprarProf(int UsuarioID);

        Task<Conquistas[]> GetAllConquistas();

        Task<Registros[]> GetAllRegistros();
        List<Registros> SpGetRegistrosCompartilhados(int UsuarioId, int AmigoId);
        Task<Registros> GetRegistroById(int Id);
        Task<Registros[]> GetReceitasByUsuario(int IdUsuario);
        Task<Registros[]> GetDespesasByUsuario(int IdUsuario);
        List<Registros> SpGetRegistrosByUsuario(int IdUsuario);

        List<Compartilhados> GetCompByIdRegistro(int RegistroId);
        Task<CompartilhadosRegistro> GetCompById(int IdCompartilhamento);


        Task<Metas[]> GetAllMetas();
        Task<Metas[]> GetMetasCompartilhadas(int UsuarioId, int AmigoId);
        Task<Metas> GetMetaById(int Id);
        Task<Metas[]> GetMetasByUsuario(int IdUsuario);

        Task<Amigos> GetAmigoById(int Id);
        Task<Amigos[]> GetAmigosByUsuario(int IdUsuario);
        Task<Amigos[]> GetAllAmigos();
        Task<Amigos[]> GetAmigosByIds(Amigos amigos);
        Task<Amigos[]> GetAllAmigosByUsuario(int IdUsuario);

        Task<Avaliacoes[]> GetAllAvaliacoes();
        Task<Avaliacoes> GetAvaliacaoById(int Id);

        Task<Tags[]> GetAllTags();
        Task<Tags> GetTagById(int Id);

        Task<Situacoes[]> GetAllSituacoes();
        Task<Notificacoes[]> GetNotificacoesByUsuarioVisu(int IdDestino);
        Task<Notificacoes> GetNotificacaoById(int Id);
        Task<Notificacoes[]> GetAllNotificacoes();
        List<object> GetNotificacoesByUsuario(int IdDestino);

        Task<Trocas[]> GetAllTrocas();
        void SpAddTrocaUsuario(int idUsuario, int idTroca);
        List<Trocas> SpGetTrocasByUsuario(int IdUsuario);

        Task<Tarefas> GetTarefaById(int Id);
        Task<Tarefas[]> GetAllTarefas();
        void SpDeletarPostagemById(Postagens post);

        Task<Comunicados[]> GetAllComunicados();
        Task<Comunicados> GetComunicadoById(int Id);

        Task<Atividades> GetAtividadeById(int Id);
        Task<Atividades[]> GetAllAtividades();

        Task<Compras[]> GetAllCompras();

        List<Quiz> SpQuiz(int QuizId);

        void SpCriarSala(ref Salas sala);
        void SpExcluirSala(int Id);
        List<Salas> GetSalasByIdProfessor(int IdProfessor);
        Task<Postagens> GetPostagemById(int Id);
        Task<Postagens[]> GetPostagensBySalaId(int Id);
        List<Postagens> SpGetPostagensBySalaCod(string codigo);
        Task<Salas[]> GetAllSalas();
        Salas SpGetSalaByCodigo(string codigo);
        Salas SpGetSalaById(int Id);
        void SpAtualizarUsuarioSala(int idUsu, int idSala);
        Task<Conteudos[]> GetAllConteudos();
        List<Conteudos> SpGetConteudosByUsuario(int UsuarioId);
        void SpCurtir(CurtidasUsuarios cu);
        void SpDescurtir(CurtidasUsuarios cu);
        List<TarefaUsuario> SpGetRelatorioTarefa(int TarefaId);
        Postagens SpAddTarefa(Postagens post);
        void SpSairRegistro(int IdRegistro, int IdCompartilhado);
        void SpUpdateCompartilhados(int IdRegistro, int IdCompartilhado);
        void SpDeleteRegistro(int RegistroId);
        void SpAddCompartilhados(int idRegistro, int idComp, int tam);
        void SpUpdateRegistro(Registros novo);
    }

}