namespace ProjetoPratica_API.Models
{
    public class Trocas
    {
        public Trocas(int id, string nome, string foto, int preco){
            Id = id;
            Nome = nome;
            Foto = foto;
            Preco = preco;
        }
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Foto { get; set; }
        public int Preco { get; set; }
    }
}