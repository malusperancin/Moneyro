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
    public class UsuariosController : Controller
    {
        public IRepository Repo { get; }
        public UsuariosController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllUsuarios();
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("{UsuarioId}")]
        public async Task<IActionResult> Get(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetUsuarioById(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        [Route("login/")]
        public async Task<IActionResult> postLogin(Usuarios modelo)
        {
            try
            {
                var result = await this.Repo.GetUsuarioByApelido(modelo.Apelido);

                if (result == null)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Este apelido não está registrado T-T.");

                if (result.Senha != modelo.Senha)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Senha incorreta.");

                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Usuarios modelo)
        {
            try
            {
                if (this.Repo.GetUsuarioByEmail(modelo.Email).Result != null)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Este email já está cadastrado! \nTente outro...");

                if (this.Repo.GetUsuarioByApelido(modelo.Apelido).Result != null)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Este apelido já está em uso T-T. \nTente outro...");



                this.Repo.Add(modelo);
                //
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

        [HttpPut("{UsuarioId}")]
        public async Task<IActionResult> put(int UsuarioId, Usuarios model)
        {
            try
            {
                // //verifica se existe aluno a ser alterado
                 var usuario = await this.Repo.GetUsuarioById(UsuarioId);
                 if (usuario == null) return NotFound(); //método do EF

                this.Repo.Update(model);

                Console.WriteLine("DEU UPDATE");
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    Console.Write("ifzao");
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

        [HttpDelete("{UsuarioId}")]
        public async Task<IActionResult> delete(int UsuarioId)
        {
            try
            {
                //verifica se existe aluno a ser excluído
                var usuario = await this.Repo.GetUsuarioById(UsuarioId);
                if (usuario == null) return NotFound(); //método do EF
                this.Repo.Delete(usuario);
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
