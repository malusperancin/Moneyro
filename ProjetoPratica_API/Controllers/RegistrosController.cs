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
    public class RegistrosController : Controller
    { //oi ta lendo?
        public IRepository Repo { get; }
        public RegistrosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllRegistros();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("todos/{UsuarioId}")]
        public async Task<IActionResult> Get(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetRegistrosByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("receitas/{UsuarioId}")]
        public async Task<IActionResult> GetReceitas(int UsuarioId)
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
         
        [HttpGet("despesas/{UsuarioId}")]
        public async Task<IActionResult> GetDespesas(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetDespesasByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{RegistroId}")]
        public async Task<IActionResult> GetRegistroById(int RegistroId)
        {
            try
            {
                var result = await this.Repo.GetRegistroById(RegistroId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("compartilhados/{UsuarioId}/{AmigoId}")]
        public async Task<IActionResult> GetRegistroById(int UsuarioId, int AmigoId)
        {
            try
            {
                var result = await this.Repo.GetRegistrosCompartilhados(UsuarioId, AmigoId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Registros modelo)
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

        [HttpPut("{RegistroId}")]
        public async Task<IActionResult> put(int RegistroId, Registros model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var registro = await this.Repo.GetRegistroById(RegistroId);
                if (registro == null) return NotFound();

                this.Repo.Entry(registro);
                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //despesa = await this.Repo.GetDespesaByID(DespesaId);
                    //return Created($"/api/despesas/{model.Id}", model);
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

        [HttpDelete("{RegistroId}")]
        public async Task<IActionResult> delete(int RegistroId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var registro = await this.Repo.GetRegistroById(RegistroId);
                if (registro == null) return NotFound(); //método do EF

                this.Repo.Delete(registro);
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