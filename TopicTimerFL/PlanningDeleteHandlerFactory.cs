using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDAL;
using TopicTimerIFL;

namespace TopicTimerFL
{
    public static class PlanningDeleteHandlerFactory
    {
        public static IPlanningDeleteHandler GetPlanningDeleteHandler()
        {
            return new PlanningDAL();
        }
    }
}
