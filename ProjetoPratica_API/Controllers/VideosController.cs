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
    public class VideosController : Controller
    {
        public IRepository Repo { get; }
        public VideosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
             Console.WriteLine("entrouaaa");
            try
            {
                Console.WriteLine("entrou");
                var result = await this.Repo.GetAllVideos();
                Console.WriteLine("1");
                return Ok(result);
            }
            catch
            {
                Console.WriteLine("catch");
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        // [HttpGet("{Video}")]      CASO QUEIRA FILTRAR POR ASSUNTO COLOCA NESSE
        // public async Task<IActionResult> Get(string Assunto)
        // {
        //     try
        //     {
        //         var result = await this.Repo.GetVideoByAssunto(Assunto);
        //         return Ok(result);
        //     }
        //     catch
        //     {
        //         return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
        //     }
        // }

        [HttpPost]
        public async Task<IActionResult> post(Videos modelo)
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

        [HttpPut("{VideoId}")]
        public async Task<IActionResult> put(int VideoId, Videos model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var video = await this.Repo.GetVideoById(VideoId);
                if (video == null) return NotFound();

                this.Repo.Update(model);

                if (await this.Repo.SaveChangesAsync())
                {

                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    //video = await this.Repo.GetVideoByID(VideoId);
                    //return Created($"/api/videos/{model.Id}", model);
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

        [HttpDelete("{VideoId}")]
        public async Task<IActionResult> delete(int VideoId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var video = await this.Repo.GetVideoById(VideoId);
                if (video == null) return NotFound(); //método do EF
                this.Repo.Delete(video);
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