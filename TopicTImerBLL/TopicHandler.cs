using TopicTimerDTO;
using TopicTimerFL;
using TopicTimerIFL;

namespace TopicTimerBLL
{
    public class TopicHandler
    {
        ITopicDataHandler dataHandler;

        public TopicHandler() 
        { 
            dataHandler = TopicDataHandlerFactory.GetTopicDataHandler();
        }

        public void Create(TopicDTO topic) 
        {
            dataHandler.Create(topic);  
        }

        public void Update(TopicDTO topic) 
        { 
            dataHandler.Update(topic);
        }

        public void Delete(String ID) 
        {
            dataHandler.Delete(ID);
        }

        public TopicDTO Get(String ID) 
        {
            return dataHandler.Get(ID);
        }

        public IEnumerable<TopicDTO> GetAll(Guid ID) 
        { 
            return dataHandler.GetAll(ID);
        }
    }
}