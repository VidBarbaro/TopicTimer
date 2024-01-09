using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface IUserDataHandler
    {
        void Create(UserDTO user);
        void Update(UserDTO user);
        UserDTO Get(Guid ID);
    }
}
