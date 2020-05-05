namespace ProjetoPratica_API.Models
{
    public class Usuario
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Apelido { get; set; }
        public string Email { get; set; }
        public string Celular { get; set; }
        public string DataDeNascimento { get; set; }
        public string Foto { get; set; }
        public string Senha { get; set; }
        public string Cidade { get; set; }
        public string Estado { get; set; }
        public string Pais { get; set; }
        public bool ModoAnonimo { get; set; }
        public bool Notificacoes { get; set; }
        public double Saldo { get; set; }
    }
}
