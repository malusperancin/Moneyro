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
    public class PostagensController : Controller
    {
        public IRepository Repo { get; }
        public PostagensController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet("{SalaId}")]
        public async Task<IActionResult> Get(int SalaId)
        {
            try
            {
                var result =  await this.Repo.GetPostagensBySalaId(SalaId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        /*[HttpDelete("{PostagemId}")]
        public async Task<IActionResult> delete(int PostagemId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var postagem = await this.Repo.GetComunicadoById(PostagemId);
                if (postagem == null) return NotFound(); //método do EF
                    this.Repo.Delete(postagem);
               
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
        }*/
    }
}