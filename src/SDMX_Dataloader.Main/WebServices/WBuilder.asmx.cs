using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;

using log4net;

using ISTAT.ENTITY;
using ISTAT.IO;
using ISTAT.DBDAL;
using ISTAT.EXPORT;

using SDMX_Dataloader.Engine;

namespace SDMX_Dataloader.Main.WebServices
{

    /// <summary>
    /// Summary description for WBuilder
    /// </summary>
    [WebService(Namespace = "http://template/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WBuilder : System.Web.Services.WebService
    {

        // Logger
        private static readonly ILog Logger = LogManager.GetLogger(typeof(WBuilder));

        #region CREATE CUBE

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetDSDs()
        {

            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");

            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }
            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDDataset))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                List<Dictionary<string, string>> _DSD_Avaible = new List<Dictionary<string, string>>();

                _DSD_Avaible=client.BuilderProcedure.Get_DSDs();

                return JsonMessage.GetData(_DSD_Avaible);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // Metodo per ottenere tutte le info per una DSD
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetDSD(string agency, string id, string version)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                SDMXIdentifier sdmxIdentity = new SDMXIdentifier()
                {
                    agencyid = agency,
                    id = id,
                    version = version
                };


                DataStructure dsd=client.BuilderProcedure.Get_DSD(sdmxIdentity);

                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("DIMENSION", dsd.Dimensions);
                param.Add("ATTRIBUTE", dsd.Attributes);

                if (dsd.IsFinal)
                    param.Add("ISFINAL", dsd.IsFinal);

                return JsonMessage.GetData(param);
            }

            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.GetError(ex.Message);
            }

        }

        // Metodo per eliminare DSD
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string DeleteDSD(string agency, string id, string version)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }
            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDSchema))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                SDMXIdentifier sdmxIdentity = new SDMXIdentifier()
                {
                    agencyid = agency,
                    id = id,
                    version = version
                };


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                client.BuilderProcedure.Delete_DSD(sdmxIdentity);

                return JsonMessage.EmptyJSON;

            }

            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.GetError(ex.Message);
            }

        }


        
        /// <summary>
        ///     Metodo per ottenere i dati di un Cubo
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetCubeDetails(string code)
        {

            int maxRecord = int.Parse(System.Configuration.ConfigurationManager.AppSettings["CubeDetailMaxRecord"]);

            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                Dictionary<string, List<string>> ret = client.BuilderProcedure.Get_CUBE_DETAILS(code);
                Dictionary<string, List<string>> filteredRet = new Dictionary<string,List<string>>();

                long TotalRecord = ret.Last().Value.Count;

                if (TotalRecord > maxRecord)
                    foreach (var item in ret)
                        filteredRet.Add(item.Key, item.Value.Take(maxRecord).ToList());
                else
                    filteredRet = ret;

                string CubeName = GetCubeName(code);

                filteredRet.Add("_CUBE_RECORD_COUNT_", new List<string>() { TotalRecord.ToString() });
                filteredRet.Add("_CUBE_NAME_", new List<string>() { CubeName });

                return JsonMessage.GetData(filteredRet);
            }

            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }

        }


        /// <summary>
        ///     Metodo per ottenere il nome di un Cubo
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetCubeName(string id)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                string CubeName = client.BuilderProcedure.Get_CUBE_NAME(id);

                return JsonMessage.GetData(CubeName);
            }

            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }

        }

        


        // Metodo per ottenere tutte le info per una DSD
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetCodelist(string code, bool isDimensionCode = true)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                Codelist codelist = client.BuilderProcedure.Get_CODELIST(code, isDimensionCode);

                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("CODELIST", codelist.Identify.ToString());
                param.Add("CODES", codelist.Items.Take<Code>(1000));

                return JsonMessage.GetData(param);
            }

            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }

        }

        // Metodo per settare la DSD selezionata
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetDataset(int idset)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                DataStructure dataset = client.BuilderProcedure.Set_DATASET(idset);

                if (dataset == null) return JsonMessage.GetError(Resources.Notification.err_ds_invalid);
                bool status = DataSDMX.Get_DataflowProduction(client.BuilderProcedure.DataSet.IDFlow);

                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("CODE", dataset.Code);
                param.Add("NAMES", dataset.Names);
                param.Add("THEME", TextTypeWrapper.GetStringLocale(dataset.Themes,DataAccess.CurrentCultureInfo));
                param.Add("DIMENSION", dataset.Dimensions);
                param.Add("ATTRIBUTE", dataset.Attributes);
                param.Add("PRODUCTION", status);

                return JsonMessage.GetData(param);
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }
        
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetDataFlowProduction(int idset, bool active)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                DataStructure dataset = client.BuilderProcedure.Set_DATASET(idset);

                if (dataset == null) return JsonMessage.GetError(Resources.Notification.err_ds_invalid);
                bool status = DataSDMX.Get_DataflowProduction(client.BuilderProcedure.DataSet.IDFlow);

                DataSDMX.Set_DataflowProduction(client.BuilderProcedure.DataSet.IDFlow,!status);


                Dictionary<string, object> param = new Dictionary<string, object>();
                param.Add("PRODUCTION", !status);

                return JsonMessage.GetData(param);
                
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }
        
        // Metodo per creare la dataset
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string CreateDataSet(string code,string urnCategory, List<string[]> names, List<string[]> descs, List<string> dimensions, List<string> attributes)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }
            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDDataset))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (dimensions != null && code != string.Empty && names != null)
                {


                    if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                    string uri = System.Configuration.ConfigurationManager.AppSettings["URIofDataflow"].ToString();

                    client.BuilderProcedure.Create_DATASET(client.LoggedUser.ID, code, urnCategory, names,descs, dimensions, attributes,uri);

                    Dictionary<string, object> param = new Dictionary<string, object>();
                    param.Add("IDSET", client.BuilderProcedure.DataSet.IDSet);
                    param.Add("NAME", TextTypeWrapper.GetStringLocale(client.BuilderProcedure.DataSet.Names, System.Globalization.CultureInfo.CurrentUICulture));
                    param.Add("DIMENSION", client.BuilderProcedure.DataSet.Dimensions);
                    param.Add("ATTRIBUTE", client.BuilderProcedure.DataSet.Attributes);

                    return JsonMessage.GetData(param);

                }
                else throw new Exception();
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.GetError(Resources.Notification.err_ds_create);
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string DeleteDataset(int idset)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDDataset))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                if (client.BuilderProcedure.Delete_DATASET(idset))
                    return JsonMessage.GetMessage(Resources.Notification.succ_ds_delete);
                else 
                    return JsonMessage.GetError(Resources.Notification.err_ds_invalid);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        #endregion

        #region MAPPING

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetMappings()
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                List<SDMX_Dataloader.Engine.Mapping> _maps = client.BuilderProcedure.Get_MAPPINGS(client.BuilderProcedure.DataSet.IDSet, client.LoggedUser.ID);
                if (_maps != null)
                    return JsonMessage.GetData(_maps);
                return JsonMessage.EmptyJSON;

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetCubeComponent(int idCube)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                List<ISTAT.ENTITY.Dimension> dimms = ISTAT.DBDAL.DataAccess.Get_Dimensions(idCube);
                List<ISTAT.ENTITY.Attribute> attrs = ISTAT.DBDAL.DataAccess.Get_Attributes(idCube);

                if (dimms != null && attrs != null)
                {
                    Dictionary<string, object> param = new Dictionary<string, object>();

                    param.Add("DIMENSION", dimms);
                    param.Add("ATTRIBUTE", attrs);

                    return JsonMessage.GetData(param);
                }
                else { return JsonMessage.ErrorOccured; }
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetMappingSchema(int idschema)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();

                SDMX_Dataloader.Engine.Mapping _map = client.BuilderProcedure.Set_MAPPING(idschema);

                if (_map != null) return JsonMessage.GetData(_map);

                return JsonMessage.EmptyJSON;

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string CreateMapping(
            int idset,    
            string name,
            string description, 
            List<SDMX_Dataloader.Engine.MappingItem> items,
            string csv_file_char,
            bool csv_file_hasHeader,
            bool trans_use,
            string trans_char,
            int trans_period)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                SDMX_Dataloader.Engine.Mapping _map =
                    client.BuilderProcedure.Create_MAPPING(
                    idset,
                    client.LoggedUser.ID,
                    name,
                    description,
                    items,
                    csv_file_char,
                    csv_file_hasHeader,
                    trans_use,
                    trans_char,
                    trans_period
                    );
                
                
                if (_map != null) return JsonMessage.GetData(_map);
                return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string DeleteMapping(int idschema)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                if (client.BuilderProcedure == null) client.BuilderProcedure = BuilderProcedure.Create();


                if (client.BuilderProcedure.Delete_MAPPING(idschema))
                    return JsonMessage.EmptyJSON;
                else
                    return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        #endregion

        #region DOWNLOAD

        // Metodo per esportare DSD
        [WebMethod(EnableSession = true)]
        public string CreateExport(string agency, string id, string version, List<string> dimensions, List<string> attributes, string type_download)
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                // Get Settings Properties
                ISTAT.EXPORT.Settings.ContactSettingsHandler configContact =
                   (ISTAT.EXPORT.Settings.ContactSettingsHandler)System.Configuration.ConfigurationManager.GetSection(
                       "ExportDotStatSettingsGroup/ContactSection");

                ISTAT.EXPORT.Settings.SecuritySettingsHandler configSecurity =
                   (ISTAT.EXPORT.Settings.SecuritySettingsHandler)System.Configuration.ConfigurationManager.GetSection(
                       "ExportDotStatSettingsGroup/SecuritySection");

                // Get the current user
                
                SDMXIdentifier sdmxIdentity = new SDMXIdentifier()
                {
                    agencyid = agency,
                    id = id,
                    version = version
                };

                
                string filenameDSD = sdmxIdentity.ToString();

                Org.Sdmxsource.Sdmx.Util.Objects.Container.SdmxObjectsImpl sdmxObjects = new Org.Sdmxsource.Sdmx.Util.Objects.Container.SdmxObjectsImpl();
                
                Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDataStructureObject dsd = DataSDMX.GetDSD(sdmxIdentity);

                sdmxObjects.AddDataStructure(dsd);
                
                foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDimension dim in dsd.DimensionList.Dimensions){
                    if (!dim.TimeDimension && dimensions.Contains(dim.Id) && dim.HasCodedRepresentation())
                    {
                        Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist = DataSDMX.GetCodelist(new SDMXIdentifier()
                        {
                            agencyid = dim.Representation.Representation.MaintainableReference.AgencyId,
                            id = dim.Representation.Representation.MaintainableReference.MaintainableId,
                            version = dim.Representation.Representation.MaintainableReference.Version
                        });
                        sdmxObjects.AddCodelist(codelist);
                    }
                }
                
                foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IAttributeObject att in dsd.Attributes){
                    if (attributes.Contains(att.Id) && att.HasCodedRepresentation())
                    {
                        Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist=DataSDMX.GetCodelist(new SDMXIdentifier(){
                            agencyid = att.Representation.Representation.MaintainableReference.AgencyId,
                            id = att.Representation.Representation.MaintainableReference.MaintainableId,
                            version = att.Representation.Representation.MaintainableReference.Version
                        });
                        sdmxObjects.AddCodelist(codelist);
                    }
                }
                
                List<ISTAT.IO.Utility.FileGeneric> files = new List<ISTAT.IO.Utility.FileGeneric>();

                List<ContactRef> contacs = new List<ContactRef>();
                contacs.Add(new ContactRef()
                {
                    name = configContact.Name,
                    direction = configContact.Direction,
                    email = configContact.Email
                });

                List<SecurityDef> securities = new List<SecurityDef>();
                securities.Add(new SecurityDef()
                {
                    domain = configSecurity.Domain,
                    userGroup = configSecurity.UserGroup,
                });

                DSDExporter _dsdExp = new DSDExporter(sdmxObjects);

                #region Export DSD
                if (type_download == "dsd")
                {

                    if (_dsdExp.CreateData(
                        contacs,
                        securities,
                        true, false))
                    {
                        System.Xml.XmlDocument xDoc = _dsdExp.XMLDoc;

                        MemoryStream xmlStream = new MemoryStream();
                        xDoc.Save(xmlStream);

                        xmlStream.Flush();
                        xmlStream.Position = 0;

                        ISTAT.IO.Utility.FileGeneric file = new ISTAT.IO.Utility.FileGeneric();
                        file.filename = filenameDSD + ".xml";
                        file.stream = xmlStream;

                        files.Add(file);
                    }
                } 
                #endregion
                #region Export Codelist
                if (type_download == "codelist")
                {

                    
                    if (_dsdExp.CreateData(
                        contacs,
                        securities,
                        true, false))
                    {
                        foreach (CodelistExporter _codeExp in _dsdExp.ExporterCodelists)
                        {
                            System.Xml.XmlDocument xDoc_code = _codeExp.XMLDoc;
                            MemoryStream xmlStream_code = new MemoryStream();
                            xDoc_code.Save(xmlStream_code);
                            xmlStream_code.Flush();
                            xmlStream_code.Position = 0;
                            ISTAT.IO.Utility.FileGeneric file_code = new ISTAT.IO.Utility.FileGeneric();
                            file_code.filename = _codeExp.Code.ToString() + ".xml";
                            file_code.stream = xmlStream_code;
                            files.Add(file_code);

                            Stream streamCSV = CSVWriter.CreateStream(_codeExp.DataView);
                            ISTAT.IO.Utility.FileGeneric file_csv = new ISTAT.IO.Utility.FileGeneric();
                            file_csv.filename = _codeExp.DataFilename;
                            file_csv.stream = streamCSV;
                            files.Add(file_csv);
                        }
                    }
                }
                #endregion
                #region Export ALL
                if (type_download == "all")
                {

                    if (_dsdExp.CreateData(
                        contacs,
                        securities,
                        true, false))
                    {
                        System.Xml.XmlDocument xDoc = _dsdExp.XMLDoc;

                        MemoryStream xmlStream = new MemoryStream();
                        xDoc.Save(xmlStream);

                        xmlStream.Flush();
                        xmlStream.Position = 0;

                        ISTAT.IO.Utility.FileGeneric file = new ISTAT.IO.Utility.FileGeneric();
                        file.filename = filenameDSD + ".xml";
                        file.stream = xmlStream;

                        files.Add(file);
                        foreach (CodelistExporter _codeExp in _dsdExp.ExporterCodelists)
                        {
                            System.Xml.XmlDocument xDoc_code = _codeExp.XMLDoc;
                            MemoryStream xmlStream_code = new MemoryStream();
                            xDoc_code.Save(xmlStream_code);
                            xmlStream_code.Flush();
                            xmlStream_code.Position = 0;
                            ISTAT.IO.Utility.FileGeneric file_code = new ISTAT.IO.Utility.FileGeneric();
                            file_code.filename = _codeExp.Code.ToString() + ".xml";
                            file_code.stream = xmlStream_code;
                            files.Add(file_code);

                            Stream streamCSV = CSVWriter.CreateStream(_codeExp.DataView);
                            ISTAT.IO.Utility.FileGeneric file_csv = new ISTAT.IO.Utility.FileGeneric();
                            file_csv.filename = _codeExp.DataFilename;
                            file_csv.stream = streamCSV;
                            files.Add(file_csv);
                        }
                    }
                }
                #endregion
                
                string fileZip = System.Web.HttpContext.Current.Server.MapPath(@"~\Temp\\" + filenameDSD + ".zip");
                System.IO.File.Delete(fileZip);
                Ionic.Utils.Zip.ZipFile zip = new Ionic.Utils.Zip.ZipFile(fileZip);
                foreach (ISTAT.IO.Utility.FileGeneric file in files)
                    zip.AddFileStream(file.filename, string.Empty, file.stream);
                zip.Save();

                client.FileToDownload = fileZip;

                return JsonMessage.EmptyJSON;

            }
            catch (Exception ex)
            {

                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;

            }
        }

        #endregion

        #region UPLOAD CSV

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string UploadFileCSV()
        {
            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                                                     
                #region Check file successfull sended

                if (!HttpContext.Current.Request.Files.AllKeys.Any())
                    return JsonMessage.GetError(Resources.Notification.err_file_not_found);
                
                var httpPostedFile = HttpContext.Current.Request.Files["UploadedCSV"];
                //create object for CSVReader and pass the stream
                System.IO.Stream _stream = httpPostedFile.InputStream;
                
                if (_stream == null)
                    return JsonMessage.GetError(Resources.Notification.err_file_csv);

                // Get the uploaded image from the Files collection
                string[] _params_row = HttpContext.Current.Request.Params.GetValues("chkFirstRowJump");
                string[] _params = HttpContext.Current.Request.Params.GetValues("CharSeparator");
                bool firstRowHeader = (_params_row[0].Trim() == "true") ? true : false;
                char csvSeparator = _params[0].Trim()[0];
                // check file type (only .csv)
                string[] FileExt = httpPostedFile.FileName.Split('.');
                string FileEx = FileExt[FileExt.Length - 1];
                if (FileEx.ToLower() != "csv")
                {
                    return JsonMessage.GetError(Resources.Notification.err_file_bad_type);
                }
                // Check file exist
                if (httpPostedFile.ContentLength < 1)
                {
                    return JsonMessage.GetError(Resources.Notification.err_file_empty);
                } 
                #endregion

                CSVReader reader = new CSVReader((System.IO.Stream)_stream);
                reader.Separator = csvSeparator;
                string[] headers = (firstRowHeader) ? reader.GetHeaders() : reader.GetCSVLine();
                string _userPath = HttpContext.Current.Server.MapPath(client.UserDirectory + System.IO.Path.DirectorySeparatorChar);
                string filename = System.IO.Path.GetFileName(httpPostedFile.FileName);
                string fileSavePath = System.IO.Path.Combine(_userPath,filename.Substring(0,filename.Length-4));
                int contentLength = httpPostedFile.ContentLength;
                string contentType = httpPostedFile.ContentType;

                string[] row = reader.GetHeaders();

                int indexTimeFormat = -1;
                for (int i = 0; i < headers.Length;i++ )
                {
                    if (headers[i].ToUpper() == "TIME_PERIOD") {
                        indexTimeFormat = i;
                        break; 
                    }
                }
                string timeformat = (indexTimeFormat>-1)?row[indexTimeFormat]:"1900-10";

                _stream.Close();
                httpPostedFile.InputStream.Close();

                Dictionary<string, object> _param = new Dictionary<string, object>();
                _param.Add("filename", filename);
                _param.Add("filesize", contentLength);
                _param.Add("content", contentType);
                _param.Add("headers", headers);
                _param.Add("timeformat", timeformat);
                    

                // force json responce header
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/json";
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
                HttpContext.Current.Response.Write(new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(_param));
                HttpContext.Current.Response.End();
                //HttpContext.Current.ApplicationInstance.CompleteRequest();
                return JsonMessage.GetData(_param);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        #endregion

        #region UPLOAD SDMX 

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string UploadFileSDMXSchema()
        {

            string _result = JsonMessage.GetError(Resources.Notification.err_file_empty);

            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDSchema))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (HttpContext.Current.Request.Files.AllKeys.Any())
                {
                    // Get the uploaded image from the Files collection
                    var httpPostedFile = HttpContext.Current.Request.Files["sdmxSchemaFiles"];

                    if (httpPostedFile != null)
                    {
                        // Check file exist
                        if (httpPostedFile.FileName == string.Empty)
                        {
                            _result= JsonMessage.GetError(Resources.Notification.err_file_not_found);
                        }

                        // check file type (only .csv)
                        string[] FileExt = httpPostedFile.FileName.Split('.');
                        string FileEx = FileExt[FileExt.Length - 1];
                        if (FileEx.ToLower() != "xml")
                        {
                            _result = JsonMessage.GetError(Resources.Notification.err_file_bad_type);
                        }

                        // Check file exist
                        if (httpPostedFile.ContentLength < 1)
                        {
                            _result = JsonMessage.GetError(Resources.Notification.err_file_empty);
                        }

                        // For save file
                        //var fileSavePath = System.IO.Path.Combine(HttpContext.Current.Server.MapPath("~/App_Data"), httpPostedFile.FileName);
                        //httpPostedFile.SaveAs(fileSavePath);

                        IList<Estat.Sri.MappingStore.Store.Model.ArtefactImportStatus> resultItem= DataSDMX.SubmitStructure(httpPostedFile.InputStream);

                        if (resultItem == null)
                        {
                            _result = JsonMessage.GetError(Resources.Notification.err_import_data);
                        }
                        else
                        {
                            List<ImportReport> _textResults = new List<ImportReport>();
                            foreach (Estat.Sri.MappingStore.Store.Model.ArtefactImportStatus ArtStat in resultItem)
                            {
                                ImportReport report = new ImportReport()
                                {
                                    StructureReference = ArtStat.ImportMessage.StructureReference.MaintainableId.ToString() + "-" + ArtStat.ImportMessage.StructureReference.AgencyId.ToString() + "-" + ArtStat.ImportMessage.StructureReference.Version.ToString(),
                                    Status = (ArtStat.ImportMessage.Status == Estat.Sri.MappingStore.Store.ImportMessageStatus.Success) ? "success" : "error",
                                    Message = ArtStat.ImportMessage.Message
                                };
                                _textResults.Add(report);
                            }

                            _result = JsonMessage.GetData(_textResults);
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);

                _result = JsonMessage.GetError(ex.Message);

                //_result = JsonMessage.ErrorOccured;
            }
            finally
            {
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/json";
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
                HttpContext.Current.Response.Write(_result);
                HttpContext.Current.Response.End();
            }

            return JsonMessage.ErrorOccured;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string CheckSDMXObject(string id, string agency, string version, string type_structure)
        {

            // Retrive Logged user
            SDMX_Dataloader.Engine.Client client = null;
            try
            {
                client = HttpContext.Current.Session[UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client; if (client == null) throw new Exception("Session Expiried");
            }
            catch (Exception ex)
            {
                return JsonMessage.SessionExpired;
            }

            try
            {
                using (System.IO.MemoryStream memoryStream = DataSDMX.GetStreamSDMXObject(new SDMXIdentifier() { id = id, agencyid = agency, version = version }, (Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType)Enum.Parse(typeof(Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType), type_structure)))
                {
                    //byte[] bytesInStream = memoryStream.ToArray();
                    //memoryStream.Close();

                    //string filename = "File";
                    //filename = Server.MapPath(filename);

                    string fileZip = System.Web.HttpContext.Current.Server.MapPath(@"~\Temp\\File.zip");
                    System.IO.File.Delete(fileZip);
                    Ionic.Utils.Zip.ZipFile zip = new Ionic.Utils.Zip.ZipFile(fileZip);
                    zip.AddFileStream("structure.xml", string.Empty, memoryStream);
                    zip.Save();

                    //SendAttachment(bytesInStream, filename);
                    //SaveStreamToFile(filename, memoryStream);
                }


                return JsonMessage.EmptyJSON;
            }
            catch (Exception ex) {
                return JsonMessage.ErrorOccured;
            }
        }
        
        #endregion

    }

}
