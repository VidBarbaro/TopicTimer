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
    public class Authenticator
    {
        IAuthenticatorDataHandler authenticator;
        ITopicDeleteHandler topicDelete;
        IThemeDeleteHandler themeDelete;
        ITrackingDeleteHandler trackingDelete;
        IPlanningDeleteHandler planningDelete;
        IUserDataHandler userData;
        public Authenticator() 
        {
            authenticator = AuthenticatorDataHandlerFactory.GetAuthenticatorDataHandler();
            topicDelete = TopicDeleteHandlerFactory.GetTopicDeleteHandler();
            themeDelete = ThemeDeleteHandlerFactory.GetThemeDeleteHandler();
            trackingDelete = TrackingDeleteHandlerFactory.GetTrackingDeleteHandler();
            planningDelete = PlanningDeleteHandlerFactory.GetPlanningDeleteHandler();
            userData = UserDataHandlerFactory.GetUserDataHandler();
        }

        public Guid Check(string username, string password)
        {
            foreach (UserDTO User in authenticator.GetCheck()) 
            {
                if (User.UserName == username && User.Password == password) 
                {
                    return User.ID;
                }
            }
            return Guid.Empty;
        }

        public bool Update(string username, string password, string newPassword)
        {
            Guid check = Check(username, password);
            if (check != Guid.Empty) 
            {
                authenticator.PswUpdate(check, newPassword);
                return true;
            }
            return false;
        }

        public bool Delete(string username, string password) 
        {
            Guid id = Check(username, password);
            if (id != Guid.Empty)
            {
                UserDTO user = userData.Get(id);
                topicDelete.DeleteAll(user.ID);
                themeDelete.DeleteAll(user.ID);
                trackingDelete.DeleteAll(user.ID);  
                planningDelete.DeleteAll(user.ID);
                authenticator.Delete(user.ID);
                return true;
            }
            return false;
        }
    }
}
