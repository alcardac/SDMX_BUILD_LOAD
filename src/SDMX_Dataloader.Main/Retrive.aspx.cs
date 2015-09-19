using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace SDMX_Dataloader.Main
{
    public partial class Retrive : SDMX_Dataloader.Main.Class.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            btmRetrive.DataBind();

            if (IsPostBack)
            {
                // Get Data
                string email=txtemail.Text.Trim();

                // Validate email
                if (!SDMX_Dataloader.Main.Class.Util.IsValidEmail(email))
                    Errors.Add(Resources.Notification.err_email_empty);

                if (HasError) return;
 
                // retrive user
                List<ISTAT.ENTITY.UserDef> users = ISTAT.DBDAL.DataAccess.Get_Users();
                IEnumerable<ISTAT.ENTITY.UserDef> _users = (from ISTAT.ENTITY.UserDef u in users
                                                            where u.Email == email
                                                            select u);
                if (!(_users.Count() > 0))
                        Errors.Add(Resources.Notification.err_user_email_not_found);

                if (HasError) return;

                ISTAT.ENTITY.UserDef user = _users.First();

                #region Change password

                Random rnd = new Random();
                string _newPassword = string.Empty;
                int charCount = 8;
                for (int i = 0; i < charCount; i++)
                    _newPassword += Convert.ToChar(rnd.Next(25) + 65);// range 65 to 90

                user.Password = SDMX_Dataloader.Engine.Utility.EncriptMD5(_newPassword.ToString());

                ISTAT.DBDAL.DataAccess.Update_User(user);

                #endregion

                #region Send email
                    
                string mailTo = email;
                string mailObj = "SDMX DataLoader - Retrive Profile";
                string mailBody = "New password is :" + _newPassword.ToString();

                Settings.MailSettingsHandler config =
                    (Settings.MailSettingsHandler)System.Configuration.ConfigurationManager.GetSection(
                        "MailSettingsGroup/MailSettingsSection");

                if (!SDMX_Dataloader.Main.Class.Util.SendMail(config.SmtpHost,
                    config.SmtpPort,
                    config.SmtpSsl,
                    config.MailFrom,
                    config.MailFromPassword,
                    config.MailFromName,
                    mailTo,
                    mailObj,
                    mailBody))
                {
                    Messages.Add(Resources.Notification.succ_retrive + " " + mailBody);
                    Errors.Add(Resources.Notification.err_send_email);
                }
                else {
                    Messages.Add(Resources.Notification.succ_retrive);
                }
                #endregion



            }
        }
    }
}