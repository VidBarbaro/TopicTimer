using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDTO;
using TopicTimerFL;
using TopicTimerIFL;

namespace TopicTimerBLL
{
    public class PlanningHandler
    {
        IPlanningDataHandler dataHandler;

        public PlanningHandler() 
        {
            dataHandler = PlanningDataHandlerFactory.GetPlanningDataHandler();
        }

        public void Add(PlanDTO plan) 
        {
            dataHandler.Add(plan);
        }

        public void Update(PlanDTO plan) 
        {
            dataHandler.Update(plan);
        }
        public void Delete(string ID)
        {
            dataHandler.Delete(ID);
        }

        public PlanDTO Get(string ID)
        {
            return dataHandler.Get(ID);
        }

        public IEnumerable<PlanDTO> GetDate(DateTime date, Guid UID, string id = null)
        {
            return dataHandler.GetDate(date, UID, id);
        }

        public IEnumerable<PlanDTO> GetWeek(DateTime date, Guid UID, string id = null)
        {
            return dataHandler.GetWeek(date, UID, id);
        }
    }
}
