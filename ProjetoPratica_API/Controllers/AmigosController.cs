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
    public class AmigosController : Controller
    {
        public IRepository Repo { get; }
        public AmigosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllAmigos();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{UsuarioId}")]
        public async Task<IActionResult> Get(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetAmigosByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("todos/{UsuarioId}")]
        public async Task<IActionResult> GetTodasSituacoes(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetAllAmigosByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }



        [HttpPost]
        public async Task<IActionResult> post(Amigos modelo)
        {
            try
            {
                this.Repo.Add(modelo);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //return Created($"/api/amigos/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{AmigoId}")]
        public async Task<IActionResult> put(int AmigoId, Amigos model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var amigos = await this.Repo.GetAmigoById(AmigoId);
                if(amigos == null) return NotFound();

                this.Repo.Entry(amigos);
                this.Repo.Update(model);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    // amigos = await this.Repo.GetAmigoByID(AmigoId);
                    //return Created($"/api/amigos/{model.Id}", model);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }

         [HttpDelete("{AmigoId}")]
         public async Task<IActionResult> delete(int AmigoId)
         {
            try
            {
                //verifica se existe aluno a ser excluído
                var amigo = await this.Repo.GetAmigoById(AmigoId);
                if (amigo == null) return NotFound(); //método do EF
                this.Repo.Delete(amigo);
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

        [HttpPost]
        [Route("amg/")]
        public async Task<IActionResult> getAmigos(Amigos amigos)
        {
             try
            {
                var result = await this.Repo.GetAmigosByIds(amigos);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }
    }
}
