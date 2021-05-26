namespace ProjetoPratica_API.Models
{
    public class Salas
    {
        public Salas (string nome, string professor, string codigo) 
        {
            Nome = nome;
            this.professor = professor;
            Codigo = codigo;
        }

        public Salas (int id, string nome, string professor, string codigo) 
        {
            Id = id;
            Nome = nome;
            this.professor = professor;
            Codigo = codigo;
        }

        public Salas (int id, string nome, int idProfessor, string codigo) 
        {   
            Id = id;
            Nome = nome;
            IdProfessor = idProfessor;
            Codigo = codigo;
        }

        public int Id { get; set; }
        public int IdProfessor { get; set; }
        public string Nome { get; set; }
        public string Codigo { get; set; }

        private string professor;
        public string getProfessor(){
            return this.professor;
        }
        public void setProfessetProfessor(string prof)
        {
            this.professor = prof;
        }
    }
}