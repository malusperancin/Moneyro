using System;

namespace ProjetoPratica_API.Models
{
    public class Tarefas
    {
        public int Id { get; set; }
        public int IdSala { get; set; }
        public DateTime Data { get; set; }
        public DateTime DataEntregua { get; set; }
        public string Titulo { get; set; }
        public int IdAtividade { get; set; }
    }
}