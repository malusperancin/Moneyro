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
    public class CurtidasUsuariosController : Controller
    {
        public IRepository Repo { get; }
        public CurtidasUsuariosController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpPut]
        public async Task<IActionResult> postDescurtir(CurtidasUsuarios modelo)
        {
            try
            {
                this.Repo.SpDescurtir(modelo);
                return Ok();
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
            return BadRequest();
        }

        [HttpPost]
        public async Task<IActionResult> postCurtir(CurtidasUsuarios model)
        {
            try
            {
                this.Repo.SpCurtir(model);
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