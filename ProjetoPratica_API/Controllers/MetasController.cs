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
    public class MetasController : Controller
    {
        public IRepository Repo { get; }
        public MetasController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllMetas();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{MetaId}")]
        public async Task<IActionResult> Get(int MetaId)
        {
            try
            {
                var result = await this.Repo.GetMetaById(MetaId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("usu/{UsuarioId}")]
        public async Task<IActionResult> GetByUsuario(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetMetasByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Metas modelo)
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

        [HttpPut("{MetaId}")]
        public async Task<IActionResult> put(int MetaId, Metas model)
        {
            try
            {
                //verifica se existe meta a ser alterado
                var meta = await this.Repo.GetMetaById(MetaId);
                if (meta == null) return NotFound();
 
                this.Repo.Entry(meta);
                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //meta = await this.Repo.GetMetaByID(MetaId);
                    //return Created($"/api/usuarios/{model.Id}", model);
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

        [HttpDelete("{MetaId}")]
        public async Task<IActionResult> delete(int MetaId)
        {
            Console.WriteLine("entoru");
            try
            {
                //verifica se existe aluno a ser excluído
                var meta = await this.Repo.GetMetaById(MetaId);
                if (meta == null) return NotFound(); //método do EF
                this.Repo.Delete(meta);
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