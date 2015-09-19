using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using ISTAT.ENTITY;
using ISTAT.DBDAL;

namespace SDMX_Dataloader.Main
{
    public partial class Login : SDMX_Dataloader.Main.Class.BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
/*
            var min = TranscodeTime.CompareMin("1900", "1990"); // 1900
            min = TranscodeTime.CompareMin("1900M1", "1990");   // 1900M1
            min = TranscodeTime.CompareMin("1900Q1", "1990");     // 1900Q1
            min = TranscodeTime.CompareMin("1990", "1990M1");     // 1900
            min = TranscodeTime.CompareMin("1990", "1990Q1");     // 1990
            min = TranscodeTime.CompareMin("1990Q1", "1990M2");   // 1990M2
            min = TranscodeTime.CompareMin("1990Q1", "1990M4");   // 1990Q1
            min = TranscodeTime.CompareMin("1990Q2", "1990M8");    // 1990Q2
            min = TranscodeTime.CompareMin("1990Q1", "1990Q2");    // 1990Q1
            min = TranscodeTime.CompareMin("1990M5", "1990M8");    // 1990M5

  */
            if (IsPostBack)
            {
                // Get Data
                string userName=txtuser.Text.Trim();
                string password = txtpsw.Text.Trim();

                // Validate Data
                if (string.IsNullOrEmpty(userName))
                    Errors.Add(Resources.Notification.err_username_empty);
                if (string.IsNullOrEmpty(password))
                    Errors.Add(Resources.Notification.err_password_empty);

                if (!HasError)
                {
                    //Process login

                    string pswMD5 = SDMX_Dataloader.Engine.Utility.EncriptMD5(password);
                    
                    UserDef _user=DataAccess.Get_User(userName, pswMD5.ToString());
                    if (_user == null) Errors.Add(Resources.Notification.err_login);
                    else
                    {
                        SDMX_Dataloader.Engine.Client Client = new SDMX_Dataloader.Engine.Client(_user);
                        HttpContext.Current.Session[UserDef.UserSessionKey] = Client;
                    }
                    if (!HasError)
                    {
                        string pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageIndexRedirect"].ToString();
                        if(UserDef.UserCan(_user,UserDef.ActionDef.CRUDDataset))
                            pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageBuilderRedirect"].ToString();
                        else pageRedirect = System.Configuration.ConfigurationManager.AppSettings["pageLoaderRedirect"].ToString();
                        Response.Redirect(pageRedirect, true);
                    }
                }
            }
        }

    }
}