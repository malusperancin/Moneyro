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

       /* [HttpGet("curtidas/{UsuarioId}")]
        public async Task<IActionResult> GetUsuarioCurtida(int UsuarioId)
        {
            try
            {
                var result = await this.Repo.GetUsuarioCurtidaByIdUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }*/

       /* [HttpPut]
        [Route("cofre/{id}")]
        public async Task<IActionResult> updateCofre(Usuarios modelo)
        {
            try
            {
                this.Repo.Update(modelo);

                if (result == null)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Este apelido não está registrado T-T.");

                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }
*/
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

        [HttpPut]
        [Route("sala/{CodSala}")]
        public async Task<IActionResult> postSala(string CodSala, Usuarios usu)
        {
            try
            {
                var result = this.Repo.SpGetSalaByCodigo(CodSala);

                if (result == null)
                    return this.StatusCode(StatusCodes.Status409Conflict, "Essa sala não existe!");

                this.Repo.SpAtualizarUsuarioSala(usu.Id, result.Id);

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
                //verifica se existe aluno a ser alterado
                var usuario = await this.Repo.GetUsuarioById(UsuarioId);
                if (usuario == null) return NotFound(); //método do EF

                this.Repo.Entry(usuario);
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

        [HttpGet("fotos/{UsuarioId}")]
        //[Route("fotos/")]
        public async Task<IActionResult> getFotos(int UsuarioId)
        {
            try
            {
                var result = this.Repo.SpGetFotosByUsuario(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet]
        [Route("pontos/{UsuarioID}/{AtividadeID}/{Pontos}/{Total}")]
        public async Task<IActionResult> addPontos(int UsuarioID, int AtividadeID, double Pontos, double Total)
        {
            try
            {
                this.Repo.SpAddPontos(UsuarioID, AtividadeID, Pontos, Total);

                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet]
        [Route("postagens/{UsuarioID}/{AtividadeID}")]
        public async Task<IActionResult> verificaConclusao(int UsuarioID, int AtividadeID)
        {
            try
            {
                object ret = this.Repo.SpVerificaConclusao(UsuarioID, AtividadeID);

                return Ok(ret);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet]
        [Route("prof/{UsuarioID}")]
        public async Task<IActionResult> cancelarProfessor(int UsuarioID)
        {
            try
            {
                this.Repo.SpCancelaProfessor(UsuarioID);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

        [HttpGet("cmp-prof/{UsuarioId}")]
        public async Task<IActionResult> GetComprar(int UsuarioId)
        {
            try
            {
                this.Repo.SpComprarProf(UsuarioId);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }

    }
}
