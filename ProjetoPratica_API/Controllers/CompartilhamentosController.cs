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
    public class CompartilhamentosController : Controller
    {
        public IRepository Repo { get; }
        public CompartilhamentosController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet("{CompartilhamentoCod}")]
        public async Task<IActionResult> Get(int CompartilhamentoCod)
        {
            try
            {
                var result = await this.Repo.GetCompartilhamentosByCodigo(CompartilhamentoCod);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{CompartilhamentoId}")]
        public async Task<IActionResult> Get(int CompartilhamentoId)
        {
            try
            {
                var result = await this.Repo.GetCompartilhamentoById(CompartilhamentoId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Compartilhamentos modelo)
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

        [HttpPut("CompartilhamentoId}")]
        public async Task<IActionResult> put(int CompartilhamentoId, Compartilhamentos model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var compartilhamento = await this.Repo.GetCompartilhamentoById(CompartilhamentoId);
                if (compartilhamento == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //compartilhamento = await this.Repo.GetCompartilhamentoByID(CompartilhamentoId);
                    //return Created($"/api/Compartilhamentos/{model.Id}", model);
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

        [HttpDelete("{CompartilhamentoId}")]
        public async Task<IActionResult> delete(int CompartilhamentoId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var compartilhamento = await this.Repo.GetCompartilhamentoById(CompartilhamentoId);
                if (compartilhamento == null) return NotFound(); //método do EF
                this.Repo.Delete(compartilhamento);
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