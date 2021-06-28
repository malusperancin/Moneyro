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
    public class CompartilhadoRegistrosController : Controller
    { 
        public IRepository Repo { get; }
        public CompartilhadoRegistrosController (IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet("{RegistroId}")]
        public async Task<IActionResult> GetCompByIdRegistro(int RegistroId)
        {
            try
            {
                var result = await this.Repo.GetCompByIdRegistro(RegistroId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(CompartilhadosRegistro modelo)
        {
            try
            {
                this.Repo.Add(modelo);

                if (await this.Repo.SaveChangesAsync())
                    return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }

            return BadRequest();
        }

        [HttpDelete("{CompartilhamentoId}")]
        public async Task<IActionResult> delete(int CompartilhamentoId)
        {
            try
            {
                var registro = await this.Repo.GetCompById(CompartilhamentoId);
                if (registro == null) return NotFound();

                this.Repo.Delete(registro);
                
                if (await this.Repo.SaveChangesAsync())
                    return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }

            return BadRequest();
        }

        [HttpDelete("{RegistroId}/{CompartilhadoId}")]
        public async Task<IActionResult> delete(int RegistroId, int CompartilhadoId)
        {
            try
            {
                this.Repo.SpSairRegistro(RegistroId, CompartilhadoId);
                
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }

            return BadRequest();
        }

        /*[HttpPut]
        public async Task<IActionResult> put(CompartilhadosRegistro model)
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
                    return Ok();
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }*/
    }
}