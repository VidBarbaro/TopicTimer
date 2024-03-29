using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using TopicTimerBLL;
using TopicTimerDAL;
using TopicTimerDTO;

namespace TopicTimerAPI.Controllers
{
    [Route("User")]
    [ApiController]
    public class UserController : ControllerBase
    {
        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] UserDTO userDTO)
        {
            UserHandler userHandler = new UserHandler();
            userHandler.Create(userDTO);
            return Ok("User created succesfully");
        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update([FromBody] UserDTO userDTO)
        {
            UserHandler userHandler = new UserHandler();
            userHandler.Update(userDTO);
            return Ok("User updated succesfully");
        }


        [Route("get")]
        [HttpGet]
        public IActionResult Get(Guid ID)
        {
            UserHandler userHandler = new UserHandler();
            UserDTO user = userHandler.Get(ID);
            if (user == null)
                return NotFound("This user doenst exist");
            return Ok(user);
        }
    }
}
