using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class UserControl : BaseControl
    {
        ISTAT.ENTITY.UserDef _user;

        public enum UserControlMode { 
            View=0,
            Edit=1,
            Insert=2
        }

        public UserControlMode Modality=UserControlMode.View;

        public ISTAT.ENTITY.UserDef User { get { return _user; } set { _user = value; } }

        public ISTAT.ENTITY.UserDef GetComputeUser() {

            return new ISTAT.ENTITY.UserDef() { 
                ID=int.Parse(txtId.Text.ToString()),
                Username=txtUser.Text,
                Password = txtPsw.Text,
                Name = txtName.Text,
                Surname = txtSurname.Text,
                Email = txtEmail.Text,
                Role = (ISTAT.ENTITY.UserDef.RoleDef)cmbRole.SelectedIndex,
                ProFlag=chkPro.Checked      
            };

        }

        private void InitControl() {
            txtId.Text = string.Empty;
            txtUser.Text = string.Empty;
            txtName.Text = string.Empty;
            txtSurname.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPsw.Text = string.Empty;
            txtPsw2.Text = string.Empty;
            chkPro.Checked = false;
            cmbRole.DataSource = Enum.GetNames(typeof(ISTAT.ENTITY.UserDef.RoleDef));
            cmbRole.DataBind();
        }

        public void Refresh()
        {

            InitControl();

            if (_user != null)
            {
                txtId.Text = _user.ID.ToString();
                txtUser.Text = _user.Username;
                cmbRole.SelectedIndex = ((int)((ISTAT.ENTITY.UserDef.RoleDef)_user.Role));
                txtName.Text = _user.Name;
                txtSurname.Text = _user.Surname;
                txtEmail.Text = _user.Email;
                txtPsw.Text = _user.Password;
                txtPsw2.Text = _user.Password;
                chkPro.Checked = _user.ProFlag;
            }

            switch (Modality)
            {
                case UserControlMode.Edit:
                    {
                        txtId.ReadOnly = true;
                        txtUser.ReadOnly = true;
                        cmbRole.Enabled = false;
                        chkPro.Enabled = false;
                    } break;
                case UserControlMode.Insert:
                    {
                        txtId.ReadOnly = true;
                        txtUser.ReadOnly = false;
                        cmbRole.Enabled = true;
                        chkPro.Enabled = true;
                    } break;
            }
        }
    }
}