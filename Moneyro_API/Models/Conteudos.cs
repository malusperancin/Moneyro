using System;
namespace Moneyro_API.Models
{
    public class Conteudos
    {
        public Conteudos(int id, string titulo, string link, string texto, string imagem, string assunto, int curtidas, string tipo, DateTime data, bool emAlta, bool curtido){
            Id = id;
            Titulo = titulo;
            Link = link;
            Texto = texto;
            Imagem = imagem;
            Assunto = assunto;
            Curtidas = curtidas;
            Tipo = tipo;
            Data = data;
            EmAlta = emAlta;
            Curtido = curtido;
        }
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Link { get; set; }
        public string Texto { get; set; }
        public string Imagem { get; set; }
        public string Assunto { get; set; }
        public int Curtidas { get; set; }
        public string Tipo { get; set; }
        public DateTime Data { get; set; }
        public bool EmAlta { get; set; }
        public bool Curtido { get; set; }
    }
}