using System;
using CC.DataLayer.Models.Addresses;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CC.DataLayer.Configuration.ContextConfiguration.CostumerControl.Addresses
{
    public class AddressFluenConfig : IEntityTypeConfiguration<Address>
    {
        public void Configure(EntityTypeBuilder<Address> builder)
        {
            builder.Property(x => x.Description).HasMaxLength(200);
            builder.HasOne(x => x.Person);
        }
    }
}
