using System;

namespace ProjetoPratica_API.Models
{
    public class Comunicados
    {
        public Comunicados (int id, int idSala, DateTime data, string descricao, string tipo)
        {
            Id = id;
            IdSala = idSala;
            Data = data;
            Descricao = descricao;
            Tipo = tipo;
        }
        public int Id { get; set; }
        public int IdSala { get; set; }
        public DateTime Data { get; set; }
        public string Descricao { get; set; }
        public string Tipo { get; set; }
    }
}