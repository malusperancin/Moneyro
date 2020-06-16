using System;

namespace ProjetoPratica_API.Models
{
    public class Notificacoes
    {
        public int Id { get; set; }
        public int IdOrigem { get; set; }
        public int IdDestino { get; set; }
        public string Mensagem { get; set; }
        public byte Visualizada { get; set; }
         public DateTime data { get; set; }
    }
}