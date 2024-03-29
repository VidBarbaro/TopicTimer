using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using TopicTimerBLL;
using TopicTimerDTO;

namespace TopicTimerAPI.Controllers
{
    [Route("Tracking")]
    [ApiController]
    public class TrackingController : ControllerBase
    {
        [Route("add")]
        [HttpPost]
        public IActionResult Add([FromBody] TrackDTO trackDTO)
        { 
                TrackingHandler trackingHandler = new TrackingHandler();
                trackingHandler.Add(trackDTO);
                return Ok("tracking item added succesfully");
        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update([FromBody] TrackDTO trackDTO)
        {
                TrackingHandler trackingHandler = new TrackingHandler();
                trackingHandler.Update(trackDTO);
                return Ok("tracking item updated succesfully");
        }

        [Route("get")]
        [HttpGet]
        public IActionResult Get(string ID)
        {
            TrackingHandler trackingHandler = new TrackingHandler();
            TrackDTO track = trackingHandler.Get(ID);
            if (track == null)
                return NotFound("track item with this ID doenst exist");
            return Ok(track);
        }

        [Route("getdate")]
        [HttpGet]
        public IActionResult GetDate(DateTime date, Guid UID)
        {
            TrackingHandler trackingHandler = new TrackingHandler();
            IEnumerable<TrackDTO> trackings = trackingHandler.GetDate(date, UID);
            if (trackings.Count() == 0)
                return NotFound("tracking items with this date doenst exist");
            return Ok(trackings);
        }

        [Route("getweek")]
        [HttpGet]
        public IActionResult GetWeek(DateTime date, Guid UID)
        {
            TrackingHandler trackingHandler = new TrackingHandler();
            IEnumerable<TrackDTO> trackings = trackingHandler.GetWeek(date, UID);
            if (trackings.Count() == 0)
                return NotFound("tracking items with this date doenst exist");
            return Ok(trackings);
        }
    }
}
