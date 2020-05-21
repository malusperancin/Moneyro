using System;

namespace ProjetoPratica_API.Models
{
    public class Usuarios
    {
        // [Key]
        //public Usuarios(int id, string nome, string apelido, string email, string celular, DateTime data, int foto)
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Apelido { get; set; }
        public string Email { get; set; }
        public string Celular { get; set; }
        public DateTime DataDeNascimento { get; set; }
        public int Foto { get; set; }
        public string Senha { get; set; }
        public string Cidade { get; set; }
        public string Estado { get; set; }
        public bool ModoAnonimo { get; set; }
        public bool Notificacoes { get; set; }
        public decimal Saldo { get; set; }
    }
}
