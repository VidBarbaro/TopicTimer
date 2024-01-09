using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDAL.Data;
using TopicTimerDTO;
using TopicTimerIFL;

namespace TopicTimerDAL
{
    public class TrackingDAL : ITrackingDataHandler, ITrackingDeleteHandler
    {
        TopicTimerContext context;
        public TrackingDAL() 
        {
            context = new TopicTimerContext();
        }

        public void Add(TrackDTO track)
        {
            context.Tracks.Add(track);
            context.SaveChanges();
        }

        public void DeleteAll(Guid ID)
        {
            context.Tracks.RemoveRange(context.Tracks.Where(t => t.UserID == ID).ToList());
            context.SaveChanges();
        }

        public TrackDTO Get(string ID)
        {
            return context.Tracks.Where(t => t.ID == ID).FirstOrDefault();
        }

        public List<TrackDTO> GetDate(DateTime date, Guid UID, string? ID)
        {
            if (ID == null)
            {
                return context.Tracks.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(1)).ToList();
            }
            return context.Tracks.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(1) && t.ID == ID).ToList();
        }

        public List<TrackDTO> GetWeek(DateTime date, Guid UID, string? ID)
        {
            if (ID == null)
            {
                return context.Tracks.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(7)).ToList();
            }
            return context.Tracks.Where(t => t.UserID == UID && t.StartDate >= date && t.StartDate < date.AddDays(7) && t.ID == ID).ToList();
        }

        public void Update(TrackDTO track)
        {
            TrackDTO? oldTrack = context.Tracks.FirstOrDefault(t => t.ID == track.ID);
            if (oldTrack != null)
            {
                oldTrack.TopicID = track.TopicID;
                oldTrack.StartDate = track.StartDate;
                oldTrack.EndDate = track.EndDate;
            }
            context.SaveChanges();
        }
    }
}
