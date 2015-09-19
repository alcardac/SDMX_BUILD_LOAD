using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SDMX_Dataloader.Main.Class;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class BaseControl : System.Web.UI.UserControl
    {

        public string WSStatic { get { return ((BasePage)Page).WSStatic; } }
        public string WSBuilder { get { return ((BasePage)Page).WSBuilder; } }
        public string WSProfile { get { return ((BasePage)Page).WSProfile; } }


        public ICollection<System.Globalization.CultureInfo> AvailableLocale { get { return ((BasePage)Page).AvailableLocale; } }
        public System.Globalization.CultureInfo CurrentLocale { get { return ((BasePage)Page).CurrentLocale; } }   

    }
}