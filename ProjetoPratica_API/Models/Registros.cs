using System;

namespace ProjetoPratica_API.Models
{
    public class Registros
    {
        public int Id { get; set; }

        public int IdUsuario { get; set; }

        public DateTime Data { get; set; }

        public string Nome { get; set; }

        public int IdTag { get; set; }

        public string Lugar { get; set; }

        public decimal Quantia { get; set; }

        public string Compartilhamentos { get; set; }
    }
}