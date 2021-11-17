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
    public class RegistrosController : Controller
    {
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
                var result = this.Repo.SpGetRegistrosByUsuario(UsuarioId);
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
                var result = this.Repo.SpGetRegistrosCompartilhados(UsuarioId, AmigoId);
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
                    return Ok(modelo);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPost]
        [Route("app/")]
        public async Task<IActionResult> postApp(Registros modelo)
        {
            try
            {
                this.Repo.PostRegistroApp(modelo);
                return Ok();
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

                if(model.Quantia > 0)
                {
                    this.Repo.Update(model);
                    if (await this.Repo.SaveChangesAsync())
                        return Ok(model);
                }
                else
                {
                    this.Repo.SpUpdateRegistro(model);
                    return Ok(model);   
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
                this.Repo.SpDeleteRegistro(RegistroId);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }
    }
}