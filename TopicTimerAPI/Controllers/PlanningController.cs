using Microsoft.AspNetCore.Mvc;
using System.Numerics;
using System.Text.Json;
using TopicTimerBLL;
using TopicTimerDTO;


namespace TopicTimerAPI.Controllers
{
    [Route("Planning")]
    [ApiController]
    public class PlanningController : ControllerBase
    {
        [Route("add")]
        [HttpPost]
        public IActionResult Add([FromBody] PlanDTO planDTO)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            planningHandler.Add(planDTO);
            return Ok("planning item added succesfully");
        }

        [Route("update")]
        [HttpPatch]
        public IActionResult Update([FromBody] PlanDTO planDTO)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            planningHandler.Update(planDTO);
            return Ok("planning item updated succesfully");
        }

        [Route("delete")]
        [HttpDelete]
        public IActionResult Delete(string ID)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            planningHandler.Delete(ID);
            return Ok("planning item Deleted succesfully");
        }

        [Route("get")]
        [HttpGet]
        public IActionResult Get(string ID)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            PlanDTO plan = planningHandler.Get(ID);
            if(plan == null)
                return NotFound("plan item with this ID doenst exist");
            return Ok(plan);
        }

        [Route("getdate")]
        [HttpGet]
        public IActionResult GetDate(DateTime date, Guid UID)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            IEnumerable<PlanDTO> plan = planningHandler.GetDate(date, UID);
            if (plan.Count() == 0)
                return NotFound("plan items with this date doenst exist");
            return Ok(plan);
        }

        [Route("getweek")]
        [HttpGet]
        public IActionResult GetWeek(DateTime date, Guid UID)
        {
            PlanningHandler planningHandler = new PlanningHandler();
            IEnumerable<PlanDTO> plan = planningHandler.GetWeek(date, UID);
            if (plan.Count() == 0)
                return NotFound("plan items with this date doenst exist");
            return Ok(plan);
        }
    }
}
