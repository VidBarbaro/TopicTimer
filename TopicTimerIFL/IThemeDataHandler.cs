using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface IThemeDataHandler
    {
        void Create(ThemeDTO theme);
        void Update(ThemeDTO theme);
        List<ThemeDTO> GetAll(Guid ID);
        void Delete(string ID);
    }
}
