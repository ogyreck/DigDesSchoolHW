using Microsoft.EntityFrameworkCore;
using WebApIF.Models;

namespace WebApIF.Data
{
    public class DataContext: DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }

        public DbSet<UnqWords> UnqWords { get; set; }
    }
}
