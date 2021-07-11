using AutoMapper;
using CC.BusinessLayer.Interfaces.Persons;
using CC.BusinessLayer.Repository.Persons;
using CC.BusinessLayer.Services.Persons;
using CC.DataLayer.Constrains;
using CC.DataLayer.Context;
using CC.DataLayer.Mapping.Addresses;
using CC.DataLayer.Mapping.Persons;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
namespace CustomerControlApi.Configuration.StartupExtensions
{
    public static class StartupExtension
    {
        public static void ConfigureCC_Context(this IServiceCollection service, IConfiguration configuration) =>
          service.AddDbContext<CC_Context>(opt =>
          {
              opt.UseLazyLoadingProxies();

              opt.UseSqlServer(configuration.GetConnectionString(Constrant.CCC_CONNECTION_STRING), b => b.MigrationsAssembly("CustomerControlApi"));

          }


          );

        public static void ConfigureAutomapper(this IServiceCollection service)
        {

            var config = new AutoMapper.MapperConfiguration(config =>
            {
                config.AddProfile(new AddressMap());
                config.AddProfile(new PersonMap());
            });
            var mapper = config.CreateMapper();
            service.AddSingleton(mapper);
        }
        
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

        public static void InjectRepositories(this IServiceCollection service)
        {
            service.AddTransient<IPersonRepository, PersonRepository>();
        }

        public static void InjectServices(this IServiceCollection service)
        {
            service.AddTransient<IPersonServices, PersonServices>();
        }

        

    }
}
