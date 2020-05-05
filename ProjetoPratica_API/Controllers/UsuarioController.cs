using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : Controller
    {
        public IRepository Repo { get; }
        public UsuarioController(IRepository repo)
        {
            this.Repo = repo;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var result = await this.Repo.GetAllUsuariosAsync();
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
                var result = await this.Repo.GetAllUsuarioAsyncByID(UsuarioId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados AAA.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> post(Usuario modelo)
        {
            try
            {
                this.Repo.Add(modelo);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    //return Ok();
                    return Created($"/api/usuario/{modelo.Id}", modelo);
                }
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPut("{UsuarioId}")]
        public async Task<IActionResult> put(int UsuarioId, Usuario model)
        {
            try
            {
                //verifica se existe aluno a ser alterado
                var usuario = await this.Repo.GetAllUsuarioAsyncByID(UsuarioId);
                this.Repo.Update(model);
                //
                if (await this.Repo.SaveChangesAsync())
                {
                    //return Ok();
                    //pegar o aluno novamente, agora alterado para devolver pela rota abaixo
                    usuario = await this.Repo.GetAllUsuarioAsyncByID(UsuarioId);
                    return Created($"/api/aluno/{model.Id}", model);
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
                var usuario = await this.Repo.GetAllUsuarioAsyncByID(UsuarioId);
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
