using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using TopicTimerBLL;
using TopicTimerDAL;
using TopicTimerDTO;

namespace TopicTimerAPI.Controllers
{
    [Route("Topic")]
    [ApiController]
    public class TopicController : ControllerBase
    {
        [Route("create")]
        [HttpPost]
        public IActionResult Create([FromBody] TopicDTO topicDTO)
        {
            TopicHandler topicHandler = new TopicHandler();
            topicHandler.Create(topicDTO);
            return Ok("topic created succesfully");
        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update([FromBody] TopicDTO topicDTO)
        {
             TopicHandler topicHandler = new TopicHandler();
             topicHandler.Update(topicDTO);
             return Ok("Topic updated succesfully");
        }

        [Route("delete")]
        [HttpDelete]
        public IActionResult Delete(string ID)
        {
            TopicHandler topicHandler = new TopicHandler();
            topicHandler.Delete(ID);
            return Ok("topic Deleted succesfully");
        }

        [Route("get")]
        [HttpGet]
        public IActionResult Get(string ID)
        {
            TopicHandler topicHandler = new TopicHandler();
            TopicDTO topic = topicHandler.Get(ID);
            if (topic == null)
                return NotFound("This topic doenst exist");
            return Ok(topic);
        }

        [Route("getall")]
        [HttpGet]
        public IActionResult GetAll(Guid ID)
        {
            TopicHandler topicHandler = new TopicHandler();
            IEnumerable<TopicDTO> topics = topicHandler.GetAll(ID);
            if (topics.Count() == 0)
                return NotFound("This user doenst have topics");
            return Ok(topics);
        }
    }
}
