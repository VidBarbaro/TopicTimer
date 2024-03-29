using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDAL;
using TopicTimerIFL;

namespace TopicTimerFL
{
    public static class PlanningDataHandlerFactory
    {
        public static IPlanningDataHandler GetPlanningDataHandler()
        {
            return new PlanningDAL();
        }
    }
}
