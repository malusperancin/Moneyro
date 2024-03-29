using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Cors;
using Moneyro_API.Data;
using Moneyro_API.Models;

namespace Moneyro_API.Controllers
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
                var result = await this.Repo.GetPostagensBySalaId(SalaId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("codigo/{codigoSala}")]
        public async Task<IActionResult> GetPostagensBySalaCod(string codigoSala)
        {
            try
            {
                var result = this.Repo.SpGetPostagensBySalaCod(codigoSala);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Postagens modelo)
        {
            try
            {
                var result = this.Repo.SpAddTarefa(modelo);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpDelete("{PostagemId}")]
        public async Task<IActionResult> delete(int PostagemId)
        {
            try
            {
                //verifica se existe postagem a ser excluído
                Postagens postagem = await this.Repo.GetPostagemById(PostagemId);

                if (postagem == null) return NotFound();
                
                this.Repo.SpDeletarPostagemById(postagem);

                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
    }
}
}