using System;

namespace ProjetoPratica_API.Data
{
    public class Avaliacoes
    {
        public int Id { get; set; }
        public int QtdEstrelas { get; set; }
        public string Comentario { get; set; }
        public DateTime Data { get; set; }
        public int IdUsuario { get; set; }
    }
}