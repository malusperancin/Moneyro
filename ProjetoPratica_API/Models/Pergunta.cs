namespace ProjetoPratica_API.Models
{
    public class Pergunta
    {
        public int Id { get; set; }
        public string Descricao { get; set; }
        public bool Correta { get; set; }
        public string[] Respostas { get; set; }
    }
}