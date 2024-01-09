using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDAL.Data;
using TopicTimerDTO;
using TopicTimerIFL;

namespace TopicTimerDAL
{
    public class PlanningDAL : IPlanningDataHandler, IPlanningDeleteHandler
    {
        TopicTimerContext context;
        public PlanningDAL() 
        { 
            context = new TopicTimerContext();
        }

        public void Add(PlanDTO plan)
        {
            context.Plans.Add(plan);
            context.SaveChanges();
        }

        public void Delete(string ID)
        {
            context.Plans.Remove(context.Plans.Where(t => t.ID == ID).FirstOrDefault());
            context.SaveChanges();
        }

        public void DeleteAll(Guid ID)
        {
            context.Plans.RemoveRange(context.Plans.Where(t => t.UserID == ID).ToList());
            context.SaveChanges();
        }

        public PlanDTO Get(string ID)
        {
            return context.Plans.Where(t => t.ID == ID).FirstOrDefault();
        }

        public List<PlanDTO> GetDate(DateTime date, Guid UID, string? ID)
        {
            if (ID == null)
            {
                return context.Plans.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(1)).ToList();
            }
            return context.Plans.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(1) && t.ID == ID).ToList();
        }

        public List<PlanDTO> GetWeek(DateTime date, Guid UID, string? ID)
        {
            if (ID == null)
            {
                return context.Plans.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(7)).ToList();
            }
            return context.Plans.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(7) && t.ID == ID).ToList();
        }

        public void Update(PlanDTO plan)
        {
            PlanDTO? oldPlan = context.Plans.FirstOrDefault(t => t.ID == plan.ID);
            if (oldPlan != null)
            {
                oldPlan.TopicID = plan.TopicID;
                oldPlan.StartDate = plan.StartDate;
                oldPlan.EndDate = plan.EndDate; 
            }
            context.SaveChanges();
        }
    }
}
