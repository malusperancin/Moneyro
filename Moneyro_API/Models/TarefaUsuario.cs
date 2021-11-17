using System;

namespace Moneyro_API.Models
{
    public class TarefaUsuario
    {
        public TarefaUsuario(string nomeAluno, string fotoAluno, bool concluido, double nota)
        {
            NomeAluno = nomeAluno;
            FotoAluno = fotoAluno;
            Concluido = concluido;
            Nota = nota;
        }
        public string NomeAluno { get; set; }
        public string FotoAluno { get; set; }
        public bool Concluido { get; set; }
        public double Nota { get; set; }
    }
}