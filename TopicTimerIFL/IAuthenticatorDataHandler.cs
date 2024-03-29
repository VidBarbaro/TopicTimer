using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface IAuthenticatorDataHandler
    {
        List<UserDTO> GetCheck();
        void PswUpdate(Guid ID, string PswNew);
        void Delete(Guid ID);
    }
}
