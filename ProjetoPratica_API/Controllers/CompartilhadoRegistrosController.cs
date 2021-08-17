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
        public CompartilhadoRegistrosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet("{RegistroId}")]
        public async Task<IActionResult> GetCompByIdRegistro(int RegistroId)
        {
            try
            {
                var result = this.Repo.GetCompByIdRegistro(RegistroId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("usu/{IdUsuario}")]
        public async Task<IActionResult> GetCompByIdUsuario(int IdUsuario)
        {
            try
            {
                var result = this.Repo.GetCompByIdUsuario(IdUsuario);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost("{RegistroId}")]
        public async Task<IActionResult> post(int[] compartilhados, int RegistroId)
        {
            try
            {
                foreach (int comp in compartilhados)
                    this.Repo.SpAddCompartilhados(RegistroId, comp, compartilhados.Length + 1);

                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
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


        [HttpPut("{RegistroId}")]
        public async Task<IActionResult> update(int RegistroId, int[] compartilhados)
        {
            try
            {
                List<Compartilhados> lista = this.Repo.GetCompByIdRegistro(RegistroId);
                List<int> antigos = new List<int>();
                List<int> novos = compartilhados.ToList();

                List<int> cantigos = new List<int>();
                List<int> cnovos = compartilhados.ToList();

                for (int i = 0; i<lista.Count; i++)
                {
                    cantigos.Add(lista.ElementAt(i).Id);
                    antigos.Add(lista.ElementAt(i).Id);
                }

                foreach (int antigo in cantigos)
                    antigos.Remove(cnovos.Find(p => p == antigo));

                foreach (int novo in cnovos)
                    novos.Remove(cantigos.Find(p => p == novo));

                foreach (int antigo in antigos)
                    this.Repo.SpSairRegistro(RegistroId, antigo);

                foreach (int novo in novos)
                   this.Repo.SpAddCompartilhados(RegistroId, novo, compartilhados.Length + 1);

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