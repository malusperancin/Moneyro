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
    public class TarefasController : Controller
    {
        public IRepository Repo { get; }
        public TarefasController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllTarefas();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{TarefaId}")]
        public async Task<IActionResult> Get(int TarefaId)
        {
            try
            {
                var result = await this.Repo.GetTarefaById(TarefaId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        
        [HttpPost]
        public async Task<IActionResult> post(Tarefas modelo)
        {
            try
            {
                // if (this.Repo.GetTarefaById(modelo.id).Result != null)
                //     return this.StatusCode(StatusCodes.Status409Conflict, "Este email já está cadastrado! \nTente outro...");

                this.Repo.Add(modelo);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //return Created($"/api/usuarios/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{TarefaId}")]

        [HttpDelete("{TarefaId}")]
        public async Task<IActionResult> delete(int TarefaId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var tarefa = await this.Repo.GetTarefaById(TarefaId);
                if (tarefa == null) return NotFound(); //método do EF
                this.Repo.Delete(tarefa);
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
