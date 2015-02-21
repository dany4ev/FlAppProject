using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FLApp.Startup))]
namespace FLApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
