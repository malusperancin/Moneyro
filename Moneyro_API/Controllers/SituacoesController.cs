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
    public class SituacoesController : Controller
    {
        public IRepository Repo { get; }
        public SituacoesController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllSituacoes();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        // [HttpGet("{TagId}")]
        // public async Task<IActionResult> Get(int TagId)
        // {
        //     try
        //     {
        //         var result = await this.Repo.GetTagById(TagId);
        //         return Ok(result);
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        // }

        // [HttpPost]
        // public async Task<IActionResult> post(Tags modelo)
        // {
        //     try
        //     {
        //         this.Repo.Add(modelo);

        //         if (await this.Repo.SaveChangesAsync())
        //         {
        //             return Ok();
        //             // return Created($"/api/{modelo.Id}", modelo);
        //         }
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        //     return BadRequest();
        // }

        // [HttpPut("{TagId}")]
        // public async Task<IActionResult> put(int TagId, Tags model)
        // {
        //     try
        //     {
        //         //verifica se existe aluno a ser alterado
        //         var tag = await this.Repo.GetTagById(TagId);
        //         if (tag == null) return NotFound();

        //         this.Repo.Update(model);

        //         if (await this.Repo.SaveChangesAsync())
        //         {

        //             //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
        //             //tag = await this.Repo.GetTagByID(TagId);
        //             //return Created($"/api/tags/{model.Id}", model);
        //             return Ok();
        //         }
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        //     // retorna BadRequest se não conseguiu alterar
        //     return BadRequest();
        // }

    //     [HttpDelete("{TagId}")]
    //     public async Task<IActionResult> delete(int TagId)
    //     {
    //         try
    //         {
    //             //verifica se existe aluno a ser excluído
    //             var tag = await this.Repo.GetTagById(TagId);
    //             if (tag == null) return NotFound(); //método do EF
    //             this.Repo.Delete(tag);
    //             //
    //             if (await this.Repo.SaveChangesAsync())
    //             {
    //                 return Ok();
    //             }

    //         }
    //         catch
    //         {
    //             return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
    //         }
    //         return BadRequest();
    //     }
    }
}