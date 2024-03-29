using Microsoft.EntityFrameworkCore;
using TopicTimerDTO;

namespace TopicTimerDAL.Data
{
    public class TopicTimerContext : DbContext
    {
        public DbSet<TopicDTO> Topics { get; set; } = null!;
        public DbSet<UserDTO> Users { get; set; } = null!;
        public DbSet<ThemeDTO> Themes { get; set; } = null!;
        public DbSet<TrackDTO> Tracks { get; set; } = null!;
        public DbSet<PlanDTO> Plans { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlServer(@"Server=mssqlstud.fhict.local;Database=dbi454010_newdb;User Id=dbi454010_newdb;Password=TopicTimerDataBase;TrustServerCertificate=True;");
        }
    }
}
