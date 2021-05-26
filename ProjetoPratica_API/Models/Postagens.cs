using System;

namespace ProjetoPratica_API.Models
{
    public class Postagens
    {   
        public int Id { get; set; }
        public int IdSala { get; set; }
        public string Descricao { get; set; }
        public DateTime Data { get; set; }
        public string Tipo { get; set; }
        public DateTime DataEntrega { get; set; }
        public int IdAtividade { get; set; }
    }
}