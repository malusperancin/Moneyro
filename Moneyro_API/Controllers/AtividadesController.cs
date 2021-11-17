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
    public class AtividadesController : Controller
    {
        public IRepository Repo { get; }
        public AtividadesController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllAtividades();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{IdAtividade}")]
        public async Task<IActionResult> Get(int IdAtividade)
        {
            try
            {
                var result = await this.Repo.GetAtividadeById(IdAtividade);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Salas modelo)
        {
            try
            {
                this.Repo.Add(modelo);

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

        [HttpPut("{IdAtividade}")]
        public async Task<IActionResult> put(int IdAtividade, Atividades model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                 var ativ = await this.Repo.GetAtividadeById(IdAtividade);
                 if (ativ == null) return NotFound(); //método do EF

                this.Repo.Entry(ativ);
                this.Repo.Update(model);
                
                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //usuario = await this.Repo.GetUsuarioByID(UsuarioId);
                    //return Created($"/api/usuarios/{model.Id}", model);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            // retorna BadRequest se não conseguiu alterar
            return BadRequest();
        }

        [HttpDelete("{IdAtividade}")]
        public async Task<IActionResult> delete(int IdAtividade)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var ativ = await this.Repo.GetAtividadeById(IdAtividade);
                if (ativ == null) return NotFound(); //método do EF
                    this.Repo.Delete(ativ);
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
