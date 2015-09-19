using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDMX_Dataloader.Main.Controls
{
    public partial class MultipleFileUploadControl : BaseControl
    {
        private string text;
        private string srvDomain;
        private string srvPAge;
        private string nameParam;
        private string idDivFile;
        private bool reloadOnUpload;
        private bool reportOnUpload;
        public string Text
        {
            get
            {
                return text;
            }
            set
            {
                text = value;
            }
        }
        public string ServerDomain
        {
            get
            {
                return srvDomain;
            }
            set
            {
                srvDomain = value;
            }
        }
        public string ServerPage
        {
            get
            {
                return srvPAge;
            }
            set
            {
                srvPAge = value;
            }
        }
        public string NameParam
        {
            get
            {
                return nameParam;
            }
            set
            {
                nameParam = value;
            }
        }
        public string IDDivFile
        {
            get
            {
                return idDivFile;
            }
            set
            {
                idDivFile = value;
            }
        }
        public bool ReloadOnUpload { get { return reloadOnUpload; } set { reloadOnUpload = value; } }
        public bool ReportOnUpload { get { return reportOnUpload; } set { reportOnUpload = value; } }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            this.DataBind();
            this.DataBindChildren();
        }

    }
}