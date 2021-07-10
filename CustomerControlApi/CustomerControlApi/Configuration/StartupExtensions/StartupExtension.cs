using System;
using CC.DataLayer.Constrains;
using CC.DataLayer.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace CustomerControlApi.Configuration.StartupExtensions
{
    public static class StartupExtension
    {
        public static void ConfigureCC_Context(this IServiceCollection service, IConfiguration configuration) =>
          service.AddDbContext<CC_Context>(opt =>
              opt.UseSqlServer(configuration.GetConnectionString(Constrant.CCC_CONNECTION_STRING), b => b.MigrationsAssembly("CustomerControlApi"))

          );
    }
}
