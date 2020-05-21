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
    public class ReceitasController : Controller
    {
        public IRepository Repo { get; }
        public ReceitasController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllReceitas();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{ReceitaId}")]
        public async Task<IActionResult> Get(int ReceitaId)
        {
            try
            {
                var result = await this.Repo.GetReceitaById(ReceitaId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("usu/{UsuarioId}")]
        public async Task<IActionResult> GetByUsu(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetReceitasByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Receitas modelo)
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

        [HttpPut("{ReceitaId}")]
        public async Task<IActionResult> put(int ReceitaId, Receitas model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var receita = await this.Repo.GetReceitaById(ReceitaId);
                if (receita == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //receita = await this.Repo.GetReceitaByID(ReceitaId);
                    //return Created($"/api/receitas/{model.Id}", model);
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

        [HttpDelete("{ReceitaId}")]
        public async Task<IActionResult> delete(int ReceitaId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var receita = await this.Repo.GetReceitaById(ReceitaId);
                if (receita == null) return NotFound(); //método do EF
                this.Repo.Delete(receita);
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