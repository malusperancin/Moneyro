using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Data
{
    public class MoneyroContext : DbContext
    {
        public MoneyroContext(DbContextOptions<MoneyroContext> options) : base(options)
        {
        }
        public DbSet<Usuario> Usuario { get; set; }
        public DbSet<Usuario[]> Usuarios { get; set; }
    }
}