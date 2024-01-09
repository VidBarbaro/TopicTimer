using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface IPlanningDataHandler
    {
        void Add(PlanDTO plan);
        void Update(PlanDTO plan);
        void Delete(string ID);
        List<PlanDTO> GetDate(DateTime date, Guid UID, string? ID);
        List<PlanDTO> GetWeek(DateTime date, Guid UID, string? ID);
        PlanDTO Get(string ID);
    }
}
