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
    public class ThemeHandler
    {
        IThemeDataHandler dataHandler;
        public ThemeHandler() 
        {
            dataHandler = ThemeDataHandlerFactory.GetThemeDataHandler();
        }

        public void Create(ThemeDTO theme) 
        { 
            dataHandler.Create(theme);
        }

        public void Update(ThemeDTO theme) 
        {
            dataHandler.Update(theme);
        }

        public void Delete(string id) 
        {
            dataHandler.Delete(id);
        }

        public IEnumerable<ThemeDTO> GetAll(Guid id) 
        {
            return dataHandler.GetAll(id);
        }
    }
}
