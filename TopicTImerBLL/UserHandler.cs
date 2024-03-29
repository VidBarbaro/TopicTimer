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
    public class UserHandler
    {
        IUserDataHandler dataHandler;

        public UserHandler() 
        {
            dataHandler = UserDataHandlerFactory.GetUserDataHandler();
        }

        public void Create(UserDTO user) 
        {
            dataHandler.Create(user);
        }

        public void Update(UserDTO user) 
        {
            dataHandler.Update(user);
        }

        public UserDTO Get(Guid id) 
        {
            return dataHandler.Get(id);
        }
    }
}
