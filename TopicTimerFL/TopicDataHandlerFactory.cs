using TopicTimerDAL;
using TopicTimerIFL;

namespace TopicTimerFL
{
    public static class TopicDataHandlerFactory
    {
        public static ITopicDataHandler GetTopicDataHandler() 
        {
            return new TopicDAL();
        }
    }
}