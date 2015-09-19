using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class ManagerUserControl : BaseControl
    {

        private List<ISTAT.ENTITY.UserDef> _Users;

        public List<ISTAT.ENTITY.UserDef> Users { get { return _Users; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            _Users = null;

            LoadUsers();

            NewUserControl.User =new ISTAT.ENTITY.UserDef();
            NewUserControl.Modality = Main.Controls.UserControl.UserControlMode.Insert;
            NewUserControl.Refresh();

        }

        private void LoadUsers() {

            _Users=ISTAT.DBDAL.DataAccess.Get_Users();

        }
    }
}