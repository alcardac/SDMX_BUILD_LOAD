using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using SDMX_Dataloader.Main.WebServices;

using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace SDMX_Dataloader.Main
{
    public class Global : System.Web.HttpApplication
    {
        private static readonly log4net.ILog Logger = log4net.LogManager.GetLogger(typeof(Global));

        public static ISTAT.ENTITY.UserDef LoggedUser
        {
            get
            {
                return (HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey] != null) ? ((SDMX_Dataloader.Engine.Client)(HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey])).LoggedUser : null;
            }
        }
        protected void Application_Start(object sender, EventArgs e)
        {
            try
            {
                // TODO code for allocation resource
                log4net.Config.XmlConfigurator.ConfigureAndWatch(new System.IO.FileInfo(this.Server.MapPath("~/log4net.config")));

                RouteTable.Routes.EnableFriendlyUrls();
            }
            catch (Exception ex)
            {
                if (Logger.IsErrorEnabled) Logger.ErrorFormat("Exception {0}", ex.Message);
            }
            finally
            {
                if (Logger.IsInfoEnabled) Logger.Info("Application start");
            }
        }
        protected void Application_End(object sender, EventArgs e)
        {
            try
            {
                // TODO code for clear all allocated resource

                if (HttpContext.Current.Session != null)
                    HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey] = null;
            }
            catch (Exception ex)
            {
                if (Logger.IsErrorEnabled) Logger.ErrorFormat("Exception {0}", ex.Message);
            }
            finally
            {
                if (Logger.IsInfoEnabled) Logger.Info("Application stop");
            }
        }


    }
}