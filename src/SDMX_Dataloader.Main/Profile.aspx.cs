using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDMX_Dataloader.Main
{
    public partial class Profile : SDMX_Dataloader.Main.Class.BasePage
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            UserControl.Modality = Main.Controls.UserControl.UserControlMode.Edit;
            UserControl.User = Global.LoggedUser;
            UserControl.Refresh();
        }
    }
}