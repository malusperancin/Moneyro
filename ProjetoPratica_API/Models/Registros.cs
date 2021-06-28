using System;

namespace ProjetoPratica_API.Models
{
    public class Registros
    {
        public Registros(int id, int idUsuario, DateTime data, string nome, int idTag, string lugar, decimal quantia)
        {
            Id = id;
            IdUsuario = idUsuario;
            Data = data;
            Nome = nome;
            IdTag = idTag;
            Lugar = lugar;
            Quantia = quantia;
        }

        public Registros() {}

        public int Id { get; set; }

        public int IdUsuario { get; set; }

        public DateTime Data { get; set; }

        public string Nome { get; set; }

        public int IdTag { get; set; }

        public string Lugar { get; set; }

        public decimal Quantia { get; set; }
    }
}