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
    public class NotificacoesController : Controller
    {
        public IRepository Repo { get; }
        public NotificacoesController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllNotificacoes();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("todas/{UsuarioId}")]
        public async Task<IActionResult> Get(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetNotificacoesByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{NotificaoId}")]
        public async Task<IActionResult> GetById(int NotificaoId)
        {
            try
            {
                var result = await this.Repo.GetNotificacaoById(NotificaoId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("visu/{UsuarioId}")]
        public async Task<IActionResult> GetVisu(int NotificaoId)
        {
            try
            {
                var result = await this.Repo.GetNotificacoesByUsuarioVisu(NotificaoId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Notificacoes modelo)
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

        [HttpPut("{NotificacaoId}")]
        public async Task<IActionResult> put(int NotificacaoId, Notificacoes model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var notif = await this.Repo.GetNotificacaoById(NotificacaoId);
                if (notif == null) return NotFound();

                this.Repo.Entry(notif);
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

        [HttpDelete("{NotificacoesId}")]
        public async Task<IActionResult> delete(int NotificacaoId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var notif = await this.Repo.GetNotificacaoById(NotificacaoId);
                if (notif == null) return NotFound(); //método do EF
                this.Repo.Delete(notif);
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