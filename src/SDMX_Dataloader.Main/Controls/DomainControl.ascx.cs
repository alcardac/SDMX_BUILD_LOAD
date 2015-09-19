using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ISTAT.DBDAL;
using ISTAT.ENTITY;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class ThemeControl : BaseControl
    {

        UserDef user;

        public UserDef UserSelected { get { return user; } set { user = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

    }
}