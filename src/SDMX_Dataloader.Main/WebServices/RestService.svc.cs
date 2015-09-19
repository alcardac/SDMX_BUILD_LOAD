using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace SDMX_Dataloader.Main.WebServices
{
    public class RestService : IRestService
    {


        public string GetResult(string agencyid, string id, string version)
        {
            ISTAT.ENTITY.SDMXIdentifier identifier = new ISTAT.ENTITY.SDMXIdentifier();
            identifier.agencyid = agencyid;
            identifier.id = id;
            identifier.version = (version[0] + "." + version[1]).ToString();

            ISTAT.ENTITY.DataStructure ds= ISTAT.DBDAL.DataAccess.Get_DataStructureByDataflow(identifier);

            if (ds != null && ds.IDSet>0) return "true";
            else return "false";
        }
    }
}
