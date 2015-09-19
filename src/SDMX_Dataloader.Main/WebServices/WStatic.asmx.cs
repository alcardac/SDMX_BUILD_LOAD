using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Globalization;

using System.Threading;
using System.Text;

using log4net;


using SDMX_Dataloader.Main.Web;
using SDMX_Dataloader.Main.Class;


namespace SDMX_Dataloader.Main.WebServices
{


    public class JsonMessage {

        // messaggi standard di ritorno
        public static string ErrorOccured { get { return "{\"ERRORS\" : true }"; } }
        public static string SessionExpired { get { return "{\"SESSIONEXPIRED\" : true }"; } }
        public static string EmptyJSON { get { return new JavaScriptSerializer().Serialize(string.Empty); } }
        public static string GetError(string error) {
            Dictionary<string, object> _return = new Dictionary<string, object>();
            _return.Add("ERRORS", error);
            return new JavaScriptSerializer().Serialize(_return);
        }
        public static string GetMessage(string message)
        {
            Dictionary<string, object> _return = new Dictionary<string, object>();
            _return.Add("message", message);
            return new JavaScriptSerializer().Serialize(_return);
        }
        public static string GetData(object obj)
        {
            return new JavaScriptSerializer().Serialize(obj);
        }
    }


    /// <summary>
    /// Summary description for WStatic
    /// </summary>
    [WebService(Namespace = "http://template/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]

    [System.Web.Script.Services.ScriptService]

    public class WStatic : System.Web.Services.WebService
    {

        // Logger
        private static readonly ILog Logger = LogManager.GetLogger(typeof(WStatic));

        // Metodo per salvare in cockie la lingua scelata
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetLocale(string locale)
        {
            try
            {
                CultureInfo c = I18NSupport.Instance.GetLocale(locale);
                if (c != null)
                {
                    Thread.CurrentThread.CurrentUICulture = c;
                    //DataAccess.CurrentCultureInfo = c;
                    
                    if (!c.Equals(I18NSupport.Instance.DefaultLocale))
                    {
                        LocaleResolver.SendCookie(c, this.Context);
                    }
                    else
                    {
                        LocaleResolver.RemoveCookie(this.Context);
                    }

                    return JsonMessage.EmptyJSON;
                }

                var locales = new StringBuilder();
                foreach (CultureInfo cultureInfo in I18NSupport.Instance.AvailableLocales.Keys)
                {
                    locales.Append(cultureInfo.Name);
                    locales.Append(',');
                }

                locales.Length--;
                Logger.ErrorFormat(CultureInfo.InvariantCulture, Resources.Messages.app_title, locale, locales);
                return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

    }
}