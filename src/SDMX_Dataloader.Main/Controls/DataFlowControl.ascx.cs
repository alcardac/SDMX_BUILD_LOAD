using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Org.Sdmxsource.Sdmx.Api.Model.Mutable.DataStructure;
using ISTAT.DBDAL;
using ISTAT.ENTITY;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class DataFlowControl : BaseControl
    {

        public bool Enable { get; set; }

        private List<ListItem> _DS_Avaible;
        //private List<ListItem> _DSD_Avaible;
        private List<ListItem> _Theme_Avaible;
        
        public List<ListItem> DS_Avaible { get { return _DS_Avaible; } }
        //public List<ListItem> DSD_Avaible { get { return _DSD_Avaible; } }
        public List<ListItem> Theme_Avaible { get { return _Theme_Avaible; } }
        
        public List<System.Globalization.CultureInfo> AvaibleCulture { get { return SDMX_Dataloader.Main.Web.I18NSupport.Instance.AvailableLocales.Keys.ToList<System.Globalization.CultureInfo>(); } }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            Enable = false;

            _DS_Avaible = null;
            //_DSD_Avaible = null;
            _Theme_Avaible = null;

            //LoadDSDAvaible();
            LoadDFDAvaible();
            LoadThemeAvaible();

        }
         /*
        private void LoadDSDAvaible() {

            _DSD_Avaible = new List<ListItem>();

            try
            {

                ISet<IDataStructureMutableObject> dsds =DataSDMX.GetDSDList();

                foreach (IDataStructureMutableObject dsd in dsds)
                {

                   SDMXIdentifier sdmxIdentity = new SDMXIdentifier()
                    {
                        agencyid = dsd.AgencyId,
                        id = dsd.Id,
                        version = dsd.Version
                    };

                    List<TextTypeWrapper> locations = new List<TextTypeWrapper>();
                    foreach (Org.Sdmxsource.Sdmx.Api.Model.Mutable.Base.ITextTypeWrapperMutableObject text in dsd.Names)
                        locations.Add(new TextTypeWrapper(text.Locale, text.Value));

                    int langIndex =TextTypeWrapper.GetIndexLocale(locations, System.Threading.Thread.CurrentThread.CurrentUICulture);

                    _DSD_Avaible.Add(new ListItem(dsd.Names[langIndex].Value, sdmxIdentity.ToString()));
                }

            }
            catch//(Exception ex)
            {

            }
            finally {

                dsd_avaible.DataSource = _DSD_Avaible;
                dsd_avaible.DataTextField = "Text";
                dsd_avaible.DataValueField = "Value";
                dsd_avaible.DataBind();
            }
        }
          */
        private void LoadDFDAvaible()
        {
            _DS_Avaible = new List<ListItem>();
            _DS_Avaible.Add(new ListItem(Resources.Messages.lbl_select_ds, "-1"));

            try
            {
                List<DataStructure> dfs = (Global.LoggedUser.Role == UserDef.RoleDef.Amministratore) ?
                    DataAccess.Get_DataStructures() :
                    DataAccess.Get_DataStructures(Global.LoggedUser.ID);

                foreach (DataStructure df in dfs)
                {
                    string name_local =TextTypeWrapper.GetStringLocale(df.Names, System.Threading.Thread.CurrentThread.CurrentUICulture);

                    _DS_Avaible.Add(new ListItem(name_local, df.IDSet.ToString()));
                }
            }
            catch// (Exception ex)
            {


            }
            finally {

                ds_avaible.DataSource = _DS_Avaible;
                ds_avaible.DataTextField = "Text";
                ds_avaible.DataValueField = "Value";
                ds_avaible.DataBind();
            }

        }
        private void LoadThemeAvaible() {
            _Theme_Avaible = new List<ListItem>();

            try
            {
                List<Category> themes =DataAccess.Get_Themes();

                foreach (Category theme in themes)
                {
                    string name_local =TextTypeWrapper.GetStringLocale(theme.Names, System.Threading.Thread.CurrentThread.CurrentUICulture);

                    _Theme_Avaible.Add(new ListItem(name_local, theme.IDTheme.ToString()));
                }
            }
            catch// (Exception ex)
            {


            }
            finally
            {

                theme_avaible.DataSource = _Theme_Avaible;
                theme_avaible.DataTextField = "Text";
                theme_avaible.DataValueField = "Value";
                theme_avaible.DataBind();
            }
        }

        protected void btm_export_dsd_Click(object sender, EventArgs e)
        {
            try
            {
                string s_filename = ((SDMX_Dataloader.Engine.Client)HttpContext.Current.Session[UserDef.UserSessionKey]).FileToDownload;
                
                byte[] data = ISTAT.IO.Utility.FileToByteArray(s_filename);

                System.IO.FileInfo fInfo = new System.IO.FileInfo(s_filename);
                fInfo.Delete();
                ((SDMX_Dataloader.Engine.Client)HttpContext.Current.Session[UserDef.UserSessionKey]).FileToDownload = string.Empty;

                Response.Clear();
                Response.ContentType = "application/zip";
                Response.AppendHeader("Content-Disposition", "Attachment; Filename=\"" + fInfo.Name + "\"");
                Response.OutputStream.Write(data, 0, data.Length);
                Response.OutputStream.Flush();
            }
            catch { 
                
            }
        }
        

    }
}