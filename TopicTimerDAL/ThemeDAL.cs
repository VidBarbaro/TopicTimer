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
    public class ThemeDAL : IThemeDataHandler, IThemeDeleteHandler
    {
        TopicTimerContext context;

        public ThemeDAL() 
        {
            context = new TopicTimerContext();
        }

        public void Create(ThemeDTO theme)
        {
            context.Themes.Add(theme);
            context.SaveChanges();
        }

        public void Delete(string ID)
        {
            context.Themes.Remove(context.Themes.Where(t => t.ID == ID).FirstOrDefault());
            context.SaveChanges();
        }

        public void DeleteAll(Guid ID)
        {
            context.Themes.RemoveRange(context.Themes.Where(t => t.UserID == ID));
            context.SaveChanges();
        }

        public List<ThemeDTO> GetAll(Guid ID)
        {
            return context.Themes.Where(t => t.UserID == ID).ToList();
        }

        public void Update(ThemeDTO theme)
        {
            ThemeDTO? oldTheme = context.Themes.FirstOrDefault(t => t.ID == theme.ID);
            if (oldTheme != null)
            {
                oldTheme.Name = theme.Name;
                oldTheme.Primary = theme.Primary;
                oldTheme.Secondary = theme.Secondary;
                oldTheme.Tertiary = theme.Tertiary;
                oldTheme.Background = theme.Background;
                oldTheme.Text = theme.Text;
            }
            context.SaveChanges();
        }
    }
}
