namespace TopicTimerDTO
{
    public class TrackDTO
    {
        public string ID { get; set; }
        public string TopicID { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public Guid UserID { get; set; }
    }
}
