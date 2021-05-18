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
    public class QuizController : Controller
    {
        public IRepository Repo { get; }
        public QuizController(IRepository repo)
        {
            this.Repo = repo;
        }

        [HttpGet("{QuizId}")]
        public async Task<IActionResult> Get(int QuizId)
        {
            try
            {
                var result = this.Repo.SpQuiz(QuizId);
                return Ok(result);
            }
            catch
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Falha no acesso ao banco de dados.");
            }
        }
    }
}