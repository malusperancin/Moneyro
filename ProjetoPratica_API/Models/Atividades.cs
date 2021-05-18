namespace ProjetoPratica_API.Models
{
    public class Atividades
    {
        public int Id { get; set; }
        public string Tipo { get; set; }
        public string Foto { get; set; }
        public bool Exclusivo { get; set; }
        public string Nome { get; set; }
    }
}