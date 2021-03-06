using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CustomerControlApi.Configuration.StartupExtensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace CustomerControlApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.ConfigureCC_Context(Configuration);
            services.ConfigureSwagger();
            services.InjectRepositories();
            services.InjectServices();
            services.ConfigureAutomapper();
            services.AddControllers();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger(c =>
            {
                c.RouteTemplate = "api-docs/{documentName}/definition.json";
            });
            app.UseSwaggerUI(c =>
            {
                c.DocumentTitle = "CustomerControl Api";
                c.RoutePrefix = "help";
                c.SwaggerEndpoint("../api-docs/v1/definition.json", "Customer Control");
                c.InjectStylesheet("../swagger-ui/custom.css");
            });


            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();
            app.UseStaticFiles();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
