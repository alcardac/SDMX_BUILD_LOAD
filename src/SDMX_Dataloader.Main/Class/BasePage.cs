using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;
using System.Threading;


using ISTAT.DBDAL;

namespace SDMX_Dataloader.Main.Class
{
    public class BasePage : System.Web.UI.Page
    {

        List<string> _errorStr;
        List<string> _messageStr;

        public List<string> Messages { get { return _messageStr; } }
        public List<string> Errors { get { return _errorStr; } }

        public string WSStatic { get { return ResolveUrl("~/WebServices/WStatic.asmx"); } }
        public string WSBuilder { get { return ResolveUrl("~/WebServices/WBuilder.asmx"); } }
        public string WSProfile { get { return ResolveUrl("~/WebServices/WProfile.asmx"); } }
        public string WSLoader { get { return ResolveUrl("~/WebServices/WLoader.asmx"); } }
        
        public ICollection<CultureInfo> AvailableLocale { get { return SDMX_Dataloader.Main.Web.I18NSupport.Instance.AvailableLocales.Keys; } }
        public CultureInfo CurrentLocale { get { return System.Threading.Thread.CurrentThread.CurrentUICulture; } }   

        public bool HasError {
            get { return (_errorStr == null || _errorStr.Count==0) ? false : true; }
        }
        public bool HasMessage
        {
            get { return (_messageStr == null || _messageStr.Count == 0) ? false : true; }
        }

        protected override void OnPreLoad(EventArgs e)
        {

            base.OnPreLoad(e);

            HttpBrowserCapabilities httpBrowser = Request.Browser;
            var ecmaScriptVersion = httpBrowser.EcmaScriptVersion;
            if (ecmaScriptVersion==null){
                // browser not support javascript
                /*
                string pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageInstallRedirect"].ToString();
                if (this.Request.AppRelativeCurrentExecutionFilePath.ToLower() != pageRedirect.ToLower())
                    Response.Redirect(pageRedirect, true);
                */
            }

            // check if connection is valid
            if (!DataSDMX.IsValid || !DataAccess.IsValid)
            {
                string pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageInstallRedirect"].ToString();
                if (this.Request.AppRelativeCurrentExecutionFilePath.ToLower() !=  pageRedirect.ToLower())
                    Response.Redirect(pageRedirect, true);
            }
            else 
            // Check if user succesfull login
            if (Global.LoggedUser == null)
            {
                // redirect to retrive profile page
                string pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageRetriveProfileRedirect"].ToString();
                
                if (this.Request.AppRelativeCurrentExecutionFilePath.ToLower() != pageRedirect.ToLower())
                {
                    pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageLoginRedirect"].ToString();
                    if (this.Request.AppRelativeCurrentExecutionFilePath.ToLower() != pageRedirect.ToLower())
                        Response.Redirect(pageRedirect, true);
                }
            }
        }
        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);

            _errorStr = new List<string>();
            _messageStr = new List<string>();
        }

        protected override void InitializeCulture()
        {
            base.InitializeCulture();

            CultureInfo culture = SDMX_Dataloader.Main.Web.LocaleResolver.GetCookie(this.Context);

            Thread.CurrentThread.CurrentUICulture = culture;
            Thread.CurrentThread.CurrentCulture = culture;

            DataAccess.CurrentCultureInfo = culture;
            DataSDMX.CurrentCultureInfo = culture;

            SDMX_Dataloader.Engine.BuilderProcedure.CurrentCultureInfo = culture;
            SDMX_Dataloader.Engine.LoaderProcedure.CurrentCultureInfo = culture;

        }
    }
}