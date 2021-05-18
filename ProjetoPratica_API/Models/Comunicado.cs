using System;

namespace ProjetoPratica_API.Models
{
    public class Comunicados
    {
        public int Id { get; set; }
        public int IdSala { get; set; }
        public DateTime Data { get; set; }
        public string Descricao { get; set; }
    }
}