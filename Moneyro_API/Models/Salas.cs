namespace Moneyro_API.Models
{
    public class Salas
    {

        public Salas (int id, string nome, int idProfessor, string professor, string codigo) 
        {
            Id = id;
            Nome = nome;
            IdProfessor = idProfessor;
            Professor = professor;
            Codigo = codigo;
        }

        public Salas () 
        {
        }
        public int Id { get; set; }
        public string Nome { get; set; }
        public int IdProfessor { get; set; }
        public string Professor { get; set; }
        public string Codigo { get; set; }
    }
}