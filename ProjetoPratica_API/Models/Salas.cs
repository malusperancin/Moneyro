namespace ProjetoPratica_API.Models
{
    public class Salas
    {

        public Salas (int id, string nome, int idProfessor, string professor, string codigo) 
        {
            Id = id;
            Nome = nome;
            Professor = professor;
            IdProfessor = idProfessor;
            Codigo = codigo;
        }

        public int Id { get; set; }
        public int IdProfessor { get; set; }
        public string Nome { get; set; }
        public string Codigo { get; set; }
        public string Professor { get; set; }
    }
}