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
        public DbSet<Artigos> Artigos { get; set; }
        public DbSet<Assuntos> Assuntos { get; set; }
        public DbSet<Compartilhamentos> Compartilhamentos { get; set; }
        public DbSet<Registros> Registros { get; set; }
        public DbSet<Metas> Metas { get; set; }
        public DbSet<Ligacoes> Ligacoes { get; set; }
        public DbSet<Tags> Tags { get; set; }
        public DbSet<Videos> Videos { get; set; }
        public DbSet<Avaliacoes> Avaliacoes { get; set; }
        public DbSet<Tips> Tips { get; set; }
        public DbSet<Situacoes> Situacoes { get; set; }
    }
}