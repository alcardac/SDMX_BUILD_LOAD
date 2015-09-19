using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDMX_Dataloader.Main
{
    public partial class Builder : SDMX_Dataloader.Main.Class.BasePage
    {

        public List<System.Globalization.CultureInfo> AvaibleCulture { get { return SDMX_Dataloader.Main.Web.I18NSupport.Instance.AvailableLocales.Keys.ToList<System.Globalization.CultureInfo>(); } }

        protected void btm_export_dsd_Click(object sender, EventArgs e)
        {
            try
            {
                string s_filename = ((SDMX_Dataloader.Engine.Client)HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey]).FileToDownload;

                byte[] data = ISTAT.IO.Utility.FileToByteArray(s_filename);

                System.IO.FileInfo fInfo = new System.IO.FileInfo(s_filename);
                fInfo.Delete();
                ((SDMX_Dataloader.Engine.Client)HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey]).FileToDownload = string.Empty;

                Response.Clear();
                Response.ContentType = "application/zip";
                Response.AppendHeader("Content-Disposition", "Attachment; Filename=\"" + fInfo.Name + "\"");
                Response.OutputStream.Write(data, 0, data.Length);
                Response.OutputStream.Flush();
            }
            catch
            {

            }
        }
    }
}