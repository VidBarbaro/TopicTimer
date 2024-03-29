using Microsoft.AspNetCore.Mvc;
using TopicTimerBLL;

namespace TopicTimerAPI.Controllers
{
    [ApiController]
    [Route("Authenticator")]
    public class AuthenticatorController : ControllerBase
    {
        

        private readonly ILogger<AuthenticatorController> _logger;

        public AuthenticatorController(ILogger<AuthenticatorController> logger)
        {
            _logger = logger;
        }

        [Route("check")]
        [HttpGet]
        public IActionResult Check(string username, string password)
        {
            Authenticator authenticator = new Authenticator();
            Guid returnGuid = authenticator.Check(username, password);
            if (returnGuid == Guid.Empty)
            {
                return NotFound("This username and password combination arent linked to a user");
            }
            else 
            {
                return Ok(returnGuid);
            }

        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update(string username, string password, string newPassword)
        {
            Authenticator authenticator = new Authenticator();
            bool returnBool = authenticator.Update(username, password, newPassword);
            if (!returnBool)
            {
                return BadRequest("Password changed Failed : 1 or more given parameters arent matching requirements");
            }
            else
            {
                return Ok("Password changed succesfully");
            }

        }

        [Route("delete")]
        [HttpDelete]
        public IActionResult Delete(string username, string password)
        {
            Authenticator authenticator = new Authenticator();
            bool returnBool = authenticator.Delete(username, password);
            if (!returnBool)
            {
                return NotFound("User delete failed : This username and password combination arent linked to a user");
            }
            else
            {
                return Ok("User deleted succesfully");
            }

        }
    }
}