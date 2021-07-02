namespace ProjetoPratica_API.Models
{
    public class Compartilhados
    {
        public Compartilhados(int id, string foto, string nome){
            Id = id;
            Foto = foto;
            Nome = nome;
        }
        public int Id { get; set; }
        public string Foto { get; set; }
        public string Nome { get; set; }
    }
}