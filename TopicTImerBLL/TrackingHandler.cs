using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDTO;
using TopicTimerFL;
using TopicTimerIFL;

namespace TopicTimerBLL
{
    public class TrackingHandler
    {
        ITrackingDataHandler dataHandler;
        
        public TrackingHandler() 
        {
            dataHandler = TrackingDataHandlerFactory.GetTrackingDataHandler();
        }

        public void Add(TrackDTO track) 
        {
            dataHandler.Add(track);
        }

        public void Update(TrackDTO track) 
        {
            dataHandler.Update(track);
        }

        public TrackDTO Get(string ID) 
        {
           return dataHandler.Get(ID);
        }

        public IEnumerable<TrackDTO> GetDate(DateTime date, Guid UID, string id = null) 
        { 
            return dataHandler.GetDate(date, UID, id);
        }

        public IEnumerable<TrackDTO> GetWeek(DateTime date, Guid UID, string id = null)
        {
            return dataHandler.GetWeek(date, UID, id);
        }
    }
}
