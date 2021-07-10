using System;
using CC.DataLayer.Configuration.ContextConfiguration.CostumerControl.Addresses;
using CC.DataLayer.Configuration.ContextConfiguration.CostumerControl.Persons;
using Microsoft.EntityFrameworkCore;

namespace CC.DataLayer.Context
{
    public class CC_Context: DbContext
    {
        public CC_Context(DbContextOptions<CC_Context> options): base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfiguration(new PersonFluentConfig());
            modelBuilder.ApplyConfiguration(new AddressFluenConfig());

        }
    }
}
