using System;
using CC.DataLayer.Models.Persons;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CC.DataLayer.Configuration.ContextConfiguration.CostumerControl.Persons
{
    public class PersonFluentConfig: IEntityTypeConfiguration<Person>
    {
        public void Configure(EntityTypeBuilder<Person> builder)
        {
            builder.Property(x => x.FirstName).HasMaxLength(50);
            builder.Property(x => x.SecondName).HasMaxLength(50);

            builder.Property(x => x.FirstLastName).HasMaxLength(50);
            builder.Property(x => x.SecondLastName).HasMaxLength(50);
            builder.Property(x => x.Gender).HasMaxLength(1);
            builder.Property(x => x.PhoneNumber).HasMaxLength(20);
            builder.Property(x => x.BirthDate).ValueGeneratedOnAdd().HasDefaultValueSql("GETDATE()");
            builder.Property(x => x.DocumentNumber).HasMaxLength(30);
            builder.HasMany(x => x.Addresses).WithOne(x => x.Person);
        }
    }
}
