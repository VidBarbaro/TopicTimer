using TopicTimerDTO;

namespace TopicTimerIFL
{
    public interface ITrackingDataHandler
    {
        void Add(TrackDTO track);
        void Update(TrackDTO track);
        List<TrackDTO> GetDate(DateTime date, Guid UID, string? ID);
        List<TrackDTO> GetWeek(DateTime date, Guid UID, string? ID);
        TrackDTO Get(string ID);
    }
}
