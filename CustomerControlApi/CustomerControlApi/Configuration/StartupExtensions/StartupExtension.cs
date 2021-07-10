using System;
using System.Linq;
using AutoMapper;
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

        public static void ConfigureAutomapper(this IServiceCollection service)
        => service.AddAutoMapper(typeof(Startup));
        
        public static void ConfigureSwagger(this IServiceCollection service)
        {
            service.AddSwaggerGen(c => {
                c.SwaggerDoc("v1",
                 new Microsoft.OpenApi.Models.OpenApiInfo
                 {
                     Title = "CustomerControl",
                     Version = "V1",
                     Description = "Manager client for Company"
                 });
            });
        }

    }
}
