namespace Moneyro_API.Models
{
    public class Quiz
    {
        public Quiz (string pergunta, string alternativa, bool correta){
            Descricao = pergunta;
            Alternativa = alternativa;
            Correta = correta;
        }

        public Quiz (string pergunta, string[] alternativas, int resposta){
            Descricao = pergunta;
            Alternativas = alternativas;
            Resposta = resposta;
        }

        public int Id { get; set; }
        public string Descricao { get; set; }
        public bool Correta { get; set; }
        public string Alternativa { get; set; }
        public string[] Alternativas { get; set; }
        public int Resposta { get; set; }
    }
}