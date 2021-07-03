using System;

namespace ProjetoPratica_API.Models
{
    public class Notificacoes
    {

        public Notificacoes(int id, int idOrigem, int idDestino, string mensagem, byte visualizada, DateTime data, string tipo){
            Id = id;
            IdOrigem = idOrigem;
            IdDestino = idDestino;
            Mensagem = mensagem;
            Visualizada = visualizada;
            this.data = data;
            Tipo = tipo;
        }

        public Notificacoes(){
        }
        public int Id { get; set; }
        public int IdOrigem { get; set; }
        public int IdDestino { get; set; }
        public string Mensagem { get; set; }
        public byte Visualizada { get; set; }
        public DateTime data { get; set; }
        public string Tipo { get; set; }
    }
}