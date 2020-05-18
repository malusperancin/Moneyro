using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Cors;
using ProjetoPratica_API.Data;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Controllers
{
    [EnableCors("*")]
    [Route("api/[controller]")]
    [ApiController]
    public class ArtigosController : Controller
    {
        public IRepository Repo { get; }
        public ArtigosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllArtigos();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        // [HttpGet("{Artigo}")]      //CASO QUEIRA FILTRAR POR ASSUNTOS 
        // public async Task<IActionResult> Get(string Assunto)
        // {
        //     try
        //     {
        //         var result = await this.Repo.GetArtigoByAssunto(Assunto);
        //         return Ok(result);
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        // }

        [HttpPost]
        public async Task<IActionResult> post(Artigos modelo)
        {
            try
            {
                this.Repo.Add(modelo);

                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //return Created($"/api/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{ArtigoId}")]
        public async Task<IActionResult> put(int ArtigoId, Artigos model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var artigo = await this.Repo.GetArtigoById(ArtigoId);
                if (artigo == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //artigo = await this.Repo.GetArtigoByID(ArtigoId);
                    //return Created($"/api/usuarios/{model.Id}", model);
                    return Ok();
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }

        [HttpDelete("{ArtigoId}")]
        public async Task<IActionResult> delete(int ArtigoId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var artigo = await this.Repo.GetArtigoById(ArtigoId);
                if (artigo == null) return NotFound(); //método do EF
                this.Repo.Delete(artigo);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                }

            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }
    }
}