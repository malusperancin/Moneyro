using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Data
{
    public class MoneyroContext : DbContext
    {
        public MoneyroContext(DbContextOptions<MoneyroContext> options) : base(options)
        {
        }

        public DbSet<Usuarios> Usuarios { get; set; }
        public DbSet<Amigos> Amigos { get; set; }
        public DbSet<Conquistas> Conquistas { get; set; }
        public DbSet<Registros> Registros { get; set; }
        public DbSet<Metas> Metas { get; set; }
        public DbSet<Tags> Tags { get; set; }
        public DbSet<Conteudos> Conteudos { get; set; }
        public DbSet<Avaliacoes> Avaliacoes { get; set; }
        public DbSet<Situacoes> Situacoes { get; set; }
        public DbSet<Notificacoes> Notificacoes { get; set; }
        public DbSet<Salas> Salas { get; set; }
        public DbSet<Atividades> Atividades { get; set; }
        public DbSet<Comunicados> Comunicados { get; set; }
        public DbSet<Tarefas> Tarefas { get; set; }
        public DbSet<Trocas> Trocas { get; set; }
        public DbSet<Postagens> Postagens { get; set; }
        public DbSet<Compras> Compras { get; set; }
        public DbSet<CurtidasUsuarios> CurtidasUsuarios { get; set; }
        public DbSet<CompartilhadosRegistro> CompartilhadosRegistro { get; set; }
    }
}