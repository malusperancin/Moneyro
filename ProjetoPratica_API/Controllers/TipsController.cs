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
    public class TipsController : Controller
    {
        public IRepository Repo { get; }
        public TipsController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllTips();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        // [HttpGet("{Assunto}")]      CASO QUEIRA FILTRAR POR ASSUNTO COLOCA NESSE
        // public async Task<IActionResult> Get(string Assunto)
        // {
        //     try
        //     {
        //         var result = await this.Repo.GetTipsByAssunto(Assunto);
        //         return Ok(result);
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        // }

        [HttpPost]
        public async Task<IActionResult> post(Tips modelo)
        {
            try
            {
                this.Repo.Add(modelo);

                if (await this.Repo.SaveChangesAsync())
                {
                    return Ok();
                    //return Created($"/api/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{TipId}")]
        public async Task<IActionResult> put(int TipId, Tips model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var tip = await this.Repo.GetTipById(TipId);
                if (tip == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //tip = await this.Repo.GetTipByID(TipId);
                    //return Created($"/api/tips/{model.Id}", model);
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

        [HttpDelete("{TipId}")]
        public async Task<IActionResult> delete(int TipId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var tip = await this.Repo.GetTipById(TipId);
                if (tip == null) return NotFound(); //método do EF
                this.Repo.Delete(tip);
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