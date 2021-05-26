namespace ProjetoPratica_API.Models
{
    public class Salas
    {

        public Salas (int id, string nome, string professor, string codigo) 
        {
            Id = id;
            Nome = nome;
            this.setProfessor(professor);
            Codigo = codigo;
        }

        public Salas (int id, string nome, int idProfessor, string codigo, int nada) 
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
        //public string Professor { get; set; }

        private string professor;
        public string getProfessor(){
            return this.professor;
        }
        public void setProfessor(string prof)
        {
            this.professor = prof;
        }
    }
}