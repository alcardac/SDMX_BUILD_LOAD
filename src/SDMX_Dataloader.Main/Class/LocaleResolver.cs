namespace SDMX_Dataloader.Main.Web
{
    using System;
    using System.Globalization;
    using System.Web;

    /// <summary>
    /// This class handles the user specified locale cookies
    /// </summary>
    internal static class LocaleResolver
    {
        #region Public Methods

        /// <summary>
        /// Get the locale from the cookie from the specified Context if available. Else return the default.
        /// </summary>
        /// <param name="context">
        /// The HTTP Context to get the cookie from
        /// </param>
        /// <returns>
        /// If the lang cookie is available, the cookie. Else the default from <see cref="I18NSupport.DefaultLocale"/>
        /// </returns>
        public static CultureInfo GetCookie(HttpContext context)
        {
            I18NSupport instance = I18NSupport.Instance;
            CultureInfo locale = instance.DefaultLocale;
            HttpCookie cookie = context.Request.Cookies["lang"];
            if (cookie != null)
            {
                string value = cookie.Value;
                locale = I18NSupport.Instance.GetLocale(value) ?? instance.DefaultLocale;
            }

            return locale;
        }

        /// <summary>
        /// Remove cookie from browser
        /// </summary>
        /// <param name="context">
        /// The HTTP Context to add the cookie to
        /// </param>
        public static void RemoveCookie(HttpContext context)
        {
            HttpCookie cookie = new HttpCookie("lang", I18NSupport.Instance.DefaultLocale.Name);
            cookie.Expires = DateTime.Now.AddDays(-1);
            context.Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// Send a cookie with the specified locale using the specified context
        /// </summary>
        /// <param name="locale">
        /// The locale string. Must be a valid locale name see <see cref="System.Globalization.CultureInfo"/>
        /// </param>
        /// <param name="context">
        /// The HTTP Context to add the cookie to
        /// </param>
        public static void SendCookie(CultureInfo locale, HttpContext context)
        {
            HttpCookie cookie = new HttpCookie("lang", locale.Name);
            cookie.Expires = DateTime.Now.AddDays(14);
            context.Response.Cookies.Add(cookie);
        }

        #endregion
    }
}