using System.Linq;

namespace ISTAT.ENTITY
{
    public class TextTypeWrapper
    {

        public static string DefaultTwoLetterISO = "en";

        private string _locale;
        private string _valueren;
        
        public TextTypeWrapper(string locale, string value)
       {
           _locale = locale;
           _valueren = value;
       }
        
        public string Locale
        {
            get
            {
                return this._locale;
            }

            set
            {
                this._locale = value;
            }
        }
        public string Value
        {
            get
            {
                return this._valueren;
            }

            set
            {
                if (value != null)
                {
                    this._valueren = value.Trim();
                }
            }
        }

        public static string GetStringLocale(System.Collections.Generic.List<TextTypeWrapper> langs, System.Globalization.CultureInfo culture)
        {
            return GetStringLocale(langs,culture.TwoLetterISOLanguageName);
        }
        public static string GetStringLocale(System.Collections.Generic.List<TextTypeWrapper> langs, string TwoLetterISOLanguageName)
        {

            if (langs == null || langs.Count == 0) return string.Empty;

            string valueDeafult = string.Empty;

            foreach (TextTypeWrapper textTypeWrapper in langs)
            {
                if (textTypeWrapper.Locale == TextTypeWrapper.DefaultTwoLetterISO)
                    valueDeafult = textTypeWrapper.Value;

                if (textTypeWrapper.Locale == TwoLetterISOLanguageName)
                    return textTypeWrapper.Value;

            }
            return valueDeafult;

        }

        public static int GetIndexLocale(System.Collections.Generic.List<TextTypeWrapper> langs, System.Globalization.CultureInfo culture) {
            return GetIndexLocale(langs,culture.TwoLetterISOLanguageName);
        }
        public static int GetIndexLocale(System.Collections.Generic.List<TextTypeWrapper> langs, string TwoLetterISOLanguageName)
        {
            if (langs == null || langs.Count == 0) return 0;

            int valueDeafult = 0;
            int i=0;
            foreach (TextTypeWrapper textTypeWrapper in langs)
            {
                if (textTypeWrapper.Locale == TextTypeWrapper.DefaultTwoLetterISO)
                    valueDeafult = i;

                if (textTypeWrapper.Locale == TwoLetterISOLanguageName)
                    return i;
                else i++;
            }
            return valueDeafult;
        }

        public static string GetStringLocale(System.Collections.Generic.IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper> langs, System.Globalization.CultureInfo culture)
        {
            return GetStringLocale(langs, culture.TwoLetterISOLanguageName);
        }
        public static string GetStringLocale(System.Collections.Generic.IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper> langs, string TwoLetterISOLanguageName)
        {

            if (langs == null || langs.Count == 0) return string.Empty;

            string valueDeafult = string.Empty;

            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper textTypeWrapper in langs)
            {
                if (textTypeWrapper.Locale == TextTypeWrapper.DefaultTwoLetterISO)
                    valueDeafult = textTypeWrapper.Value;

                if (textTypeWrapper.Locale == TwoLetterISOLanguageName)
                    return textTypeWrapper.Value;

            }
            return valueDeafult;

        }

        public static int GetIndexLocale(System.Collections.Generic.IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper> langs, System.Globalization.CultureInfo culture)
        {
            return GetIndexLocale(langs, culture.TwoLetterISOLanguageName);
        }
        public static int GetIndexLocale(System.Collections.Generic.IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper> langs, string TwoLetterISOLanguageName)
        {
            if (langs == null || langs.Count == 0) return 0;

            int valueDeafult = 0;
            int i = 0;
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper textTypeWrapper in langs)
            {
                if (textTypeWrapper.Locale == TextTypeWrapper.DefaultTwoLetterISO)
                    valueDeafult = i;

                if (textTypeWrapper.Locale == TwoLetterISOLanguageName)
                    return i;
                else i++;
            }
            return valueDeafult;
        }

    }
}