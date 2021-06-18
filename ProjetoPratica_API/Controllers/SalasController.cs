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
    public class SalasController : Controller
    {
        public IRepository Repo { get; }
        public SalasController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllSalas();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }


        [HttpGet("{CodSala}")]
        public async Task<IActionResult> Get(string CodSala)
        {
            try
            {
                var result = this.Repo.SpGetSalaByCodigo(CodSala);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }


        [HttpGet("id/{IdSala}")]
        public async Task<IActionResult> GetById(int IdSala)
        {
            try
            {
                var result = this.Repo.SpGetSalaById(IdSala);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("professor/{IdProfessor}")]
        public async Task<IActionResult> GetByIdProfessor(int IdProfessor)
        {
            try
            {
                var result = this.Repo.GetSalasByIdProfessor(IdProfessor);
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
                this.Repo.SpCriarSala(ref modelo);
                var sala = this.Repo.SpGetSalaByCodigo(modelo.Codigo);
                return Ok(sala);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }


        [HttpPut("{CodSala}")]
        public async Task<IActionResult> put(string CodSala, int IdUsuario, Salas model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var sala = this.Repo.SpGetSalaByCodigo(CodSala);
                if (sala == null) return NotFound(); //método do EF

                this.Repo.Entry(sala);
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

        [HttpDelete("{IdSala}")]
        public async Task<IActionResult> delete(int IdSala)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                this.Repo.SpExcluirSala(IdSala);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("relatorio/{IdTarefa}")]
        public async Task<IActionResult> GetRelatorioTarefa(int IdTarefa)
        {
            try
            {
                var result = this.Repo.SpGetRelatorioTarefa(IdTarefa);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

    }
}
