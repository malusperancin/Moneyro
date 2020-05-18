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
    public class AvaliacoesController : Controller
    {
        public IRepository Repo { get; }
        public AvaliacoesController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllAvaliacoes();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{AvaliacaoId}")]
        public async Task<IActionResult> Get(int AvaliacaoId)
        {
            try
            {
                var result = await this.Repo.GetAvaliacaoById(AvaliacaoId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Avaliacoes modelo)
        {
            try
            {
                this.Repo.Add(modelo);

                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    // return Created($"/api/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{AvaliacaoId}")]
        public async Task<IActionResult> put(int AvaliacaoId, Avaliacoes model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var avaliacao = await this.Repo.GetAvaliacaoById(AvaliacaoId);
                if (avaliacao == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //avaliacao = await this.Repo.GetAvaliacaoByID(AvaliacaoId);
                    //return Created($"/api/avaliacoes/{model.Id}", model);
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

        [HttpDelete("{AvaliacaoId}")]
        public async Task<IActionResult> delete(int AvaliacaoId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var avaliacao = await this.Repo.GetAvaliacaoById(AvaliacaoId);
                if (avaliacao == null) return NotFound(); //método do EF
                this.Repo.Delete(avaliacao);
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