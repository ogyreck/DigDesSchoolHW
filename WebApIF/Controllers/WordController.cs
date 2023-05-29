using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using WebApIF.Models;

namespace WebApIF.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WordController : ControllerBase
    {
        private static List<UnqWords>  unqWords = new List<UnqWords>();

        private readonly DataContext _context;



        public WordController(DataContext context)
        { _context = context; }

        [HttpGet]
        public async Task<ActionResult<List<UnqWords>>> Get()
        {

            return Ok(await _context.UnqWords.ToListAsync());
        }


        [HttpPost]
        public async Task<ActionResult<List<UnqWords>>> AddText(Text text)
        {
            TextCounter.TextCounter1 tc = new TextCounter.TextCounter1();
            Dictionary<string, int> unqWDs = tc.ProcessTextMultithreaded(text.text);
            var reversedDictionaryUnq = unqWDs.Reverse().ToDictionary(x => x.Key, x => x.Value);

            foreach (var unqWord in unqWDs)
            {

                UnqWords unqWordNew = new UnqWords()
                {

                    word = unqWord.Key,
                    count = unqWord.Value,
                };
                _context.UnqWords.Add(unqWordNew);
                await _context.SaveChangesAsync();

            }
            return Ok(await _context.UnqWords.ToListAsync());
        }
        [HttpDelete]
        public async Task<ActionResult<List<UnqWords>>> Delete()
        {
            _context.UnqWords.ExecuteDelete();

            await _context.SaveChangesAsync();

            return Ok(await _context.UnqWords.ToListAsync());

        }
    }
}
