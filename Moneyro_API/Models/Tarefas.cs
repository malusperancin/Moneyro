using System;

namespace Moneyro_API.Models
{
    public class Tarefas
    {
        public Tarefas (int id, int idSala, DateTime data, DateTime dataEntrega, string titulo, string tipo)
        {
            Id = id;
            IdSala = idSala;
            Data = data;
            DataEntrega = dataEntrega;
            Titulo = titulo;
            Tipo = tipo;
        }
        public int Id { get; set; }
        public int IdSala { get; set; }
        public DateTime Data { get; set; }
        public DateTime DataEntrega { get; set; }
        public string Titulo { get; set; }
        public int IdAtividade { get; set; }
        public string Tipo { get; set; }
    }
}