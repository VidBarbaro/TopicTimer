using TopicTimerDAL.Data;
using TopicTimerDTO;
using TopicTimerIFL;

namespace TopicTimerDAL
{
    public class TopicDAL : ITopicDataHandler, ITopicDeleteHandler
    {
        TopicTimerContext context;
        
        public TopicDAL() 
        { 
            context = new TopicTimerContext();
        }

        public void Create(TopicDTO topic)
        {
            context.Topics.Add(topic);
            context.SaveChanges();
        }

        public void Delete(string ID)
        {
            context.Topics.Remove(context.Topics.Where(t => t.ID == ID).FirstOrDefault());
            context.SaveChanges();
        }

        public void DeleteAll(Guid ID)
        {
            context.Topics.RemoveRange(context.Topics.Where(t => t.UserID == ID));
            context.SaveChanges();
        }

        public TopicDTO Get(string ID)
        {
           return context.Topics.Where(t => t.ID == ID).FirstOrDefault();
        }

        public List<TopicDTO> GetAll(Guid ID)
        {
            return context.Topics.Where(t => t.UserID == ID).ToList();
        }

        public void Update(TopicDTO topic)
        {
            TopicDTO? oldTopic = context.Topics.FirstOrDefault(t => t.ID == topic.ID);
            if (oldTopic != null) 
            { 
                oldTopic.Name = topic.Name;
                oldTopic.Color = topic.Color;
            }
            context.SaveChanges();
        }
    }
}