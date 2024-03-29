using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface ITopicDataHandler
    {
        void Create(TopicDTO topic);
        void Update(TopicDTO topic);
        void Delete(string ID);
        TopicDTO Get(string ID);
        List<TopicDTO> GetAll(Guid ID);
    }
}