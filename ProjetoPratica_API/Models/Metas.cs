using System;

namespace ProjetoPratica_API.Models
{
    public class Metas
    {
        public int Id { get; set; }

        public int IdUsuario { get; set; }

        public string Nome { get; set; }

        public decimal Objetivo { get; set; }

        public decimal Atual { get; set; }

        public DateTime DataLimite { get; set; }

        public int IdCompartilhamento { get; set; }
    }
}