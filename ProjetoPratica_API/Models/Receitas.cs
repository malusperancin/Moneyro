using System;

namespace ProjetoPratica_API.Models
{
    public class Receitas
    {
        public int Id { get; set; }
        public int IdUsuario { get; set; }
        public int IdTag { get; set; }
        public string Nome { get; set; }
        public decimal Quantia { get; set; }
        public DateTime Data { get; set; }
    }
}