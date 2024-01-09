using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Text.Json;
using TopicTimerBLL;
using TopicTimerDAL;
using TopicTimerDTO;

namespace TopicTimerAPI.Controllers
{
    [Route("Theme")]
    [ApiController]
    public class ThemeController : ControllerBase
    {
        [Route("add")]
        [HttpPost]
        public IActionResult Add([FromBody] ThemeDTO themeDTO)
        {
            ThemeHandler themeHandler = new ThemeHandler();
            themeHandler.Create(themeDTO);
            return Ok("theme added succesfully");
        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update([FromBody] ThemeDTO themeDTO)
        {
            ThemeHandler themeHandler = new ThemeHandler();
            themeHandler.Update(themeDTO);
            return Ok("theme updated succesfully");
        }

        [Route("delete")]
        [HttpDelete]
        public IActionResult Delete(string ID)
        {
            ThemeHandler themeHandler = new ThemeHandler();
            themeHandler.Delete(ID);
            return Ok("theme Deleted succesfully");
        }

        [Route("get")]
        [HttpGet]
        public IActionResult GetAll(Guid ID)
        {
            ThemeHandler themeHandler = new ThemeHandler();
            IEnumerable<ThemeDTO> themes = themeHandler.GetAll(ID);
            if (themes.Count() == 0)
                return NotFound("This user doenst have themes");
            return Ok(themes);
        }
    }
}
