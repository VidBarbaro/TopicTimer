using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TopicTimerDAL.Data;
using TopicTimerDTO;
using TopicTimerIFL;

namespace TopicTimerDAL
{
    public class UserDAL : IUserDataHandler, IAuthenticatorDataHandler
    {
        TopicTimerContext context;

        public UserDAL() 
        {
            context = new TopicTimerContext();
        }

        public List<UserDTO> GetCheck()
        {
            return context.Users.ToList();
        }

        public void Create(UserDTO user)
        {
            context.Users.Add(user);
            context.SaveChanges();
        }

        public void Delete(Guid ID)
        {
            context.Users.Remove(context.Users.Where(t => t.ID == ID).FirstOrDefault());
            context.SaveChanges();
        }

        public UserDTO Get(Guid ID)
        {
            return context.Users.Where(t => t.ID == ID).FirstOrDefault();
        }

        public void PswUpdate(Guid ID, string PswNew)
        {
            UserDTO user = context.Users.Where(t => t.ID == ID).FirstOrDefault();
            user.Password = PswNew;
            context.SaveChanges();  
        }

        public void Update(UserDTO user)
        {
            UserDTO userold = context.Users.Where(t => t.ID == user.ID).FirstOrDefault();
            userold.FirstName = user.FirstName;
            userold.LastName = user.LastName;
            userold.Picture = user.Picture;
            userold.ThemeID = user.ThemeID;
            userold.School = user.School;
            context.SaveChanges();
        }
    }
}
