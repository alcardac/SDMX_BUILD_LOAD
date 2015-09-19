using ISTAT.ENTITY;
using ISTAT.IO;
using System.Collections.Generic;
namespace SDMX_Dataloader.Engine
{

    public class Client
    {

        UserDef _user;
        string _path;
        string _fileToDownload;

        LoaderProcedure _procLoader;
        BuilderProcedure _procBuilder;
        
        public UserDef LoggedUser
        {
            get
            {
                return _user;
            }
        }

        public string UserDirectory { get { return _path; } set { _path=value; } }
        public string FileToDownload { get { return _fileToDownload; } set { _fileToDownload = value; } }

        public LoaderProcedure LoaderProcedure { get { return _procLoader; } set { _procLoader = value; } }
        public BuilderProcedure BuilderProcedure { get { return _procBuilder; } set { _procBuilder = value; } }

        public Client(UserDef user) {
            _user = user;
            _path="~/Temp/" + ((_user != null) ? _user.Username : "guest");
            _fileToDownload = string.Empty;
        }


    }
}
