using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using log4net;
using ISTAT.ENTITY;
using SDMX_Dataloader.Engine;

namespace SDMX_Dataloader.Main.WebServices
{
    /// <summary>
    /// Summary description for WProfile
    /// </summary>
    [WebService(Namespace = "http://template/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]

    [System.Web.Script.Services.ScriptService]

    public class WProfile : System.Web.Services.WebService
    {
        // Logger
        private static readonly ILog Logger = LogManager.GetLogger(typeof(WProfile));

        // metodo per logout
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string Logout()
        {
            try
            {
                if (HttpContext.Current.Session != null)
                    HttpContext.Current.Session.Remove(UserDef.UserSessionKey);

                return JsonMessage.SessionExpired;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per ottenere utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetProfile(int id)
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

                return JsonMessage.EmptyJSON;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per aggiungere utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string InsertProfile(int id, string username, string password, int role, bool pro, string name, string surname, string email)
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

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDProfile))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (username.Trim() != string.Empty && password.Trim() != string.Empty)
                {

                    if (!SDMX_Dataloader.Main.Class.Util.IsValidEmail(email.Trim()))
                        return JsonMessage.GetError(Resources.Notification.err_email_empty);

                    UserDef newUser = new UserDef
                    {
                        ID = id,
                        Username = username.Trim(),
                        Password = SDMX_Dataloader.Engine.Utility.EncriptMD5(password.Trim()),
                        Role = (UserDef.RoleDef)role,
                        ProFlag = pro,
                        Name = name.Trim(),
                        Surname = surname.Trim(),
                        Email = email.Trim()
                    };

                    int idUser;

                    if ((idUser = ISTAT.DBDAL.DataAccess.Insert_User(newUser)) > 0)
                    {
                        Dictionary<string, object> _result = new Dictionary<string, object>();
                        _result.Add("ID", idUser);
                        _result.Add("Name", newUser.Name);
                        _result.Add("Surname", newUser.Surname);
                        _result.Add("Username", newUser.Username);
                        _result.Add("ProFlag", newUser.ProFlag);
                        _result.Add("Role", newUser.Role.ToString());
                        _result.Add("Email", newUser.Email);
                        return JsonMessage.GetData(_result);
                    }
                }

                return JsonMessage.ErrorOccured;

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per eliminare utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string DeleteProfile(int id)
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

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDProfile))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (ISTAT.DBDAL.DataAccess.Delete_User(id))
                {

                    Dictionary<string, object> _result = new Dictionary<string, object>();
                    _result.Add("ID", id);

                    return JsonMessage.EmptyJSON;

                }
                else
                    return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per modificare utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string UpdateProfile(string name, string surname, string email)
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

                UserDef newUserDef = client.LoggedUser.Clone();
                newUserDef.Name = name.Trim();
                newUserDef.Surname = surname.Trim();

                if (!SDMX_Dataloader.Main.Class.Util.IsValidEmail(email.Trim()))
                    return JsonMessage.GetError(Resources.Notification.err_email_empty);

                newUserDef.Email = email.Trim();

                if (ISTAT.DBDAL.DataAccess.Update_User(newUserDef))
                {
                    client.LoggedUser.CloneTo(newUserDef);
                    return JsonMessage.EmptyJSON;
                }
                else return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per cambiare password utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string ChangePasswordProfile(string code)
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

                UserDef user = Global.LoggedUser;

                user.Password = Utility.EncriptMD5(code);

                ISTAT.DBDAL.DataAccess.Update_User(user);

                return JsonMessage.EmptyJSON;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        // metodo per ritrovare password utente
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string RetriveProfile(string email)
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
        public string CheckDB(string dbName)
        {


            try
            {
                if (dbName == ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString()) { return JsonMessage.GetData(ISTAT.DBDAL.DataAccess.IsValid); }
                if (dbName == ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString()) { return JsonMessage.GetData(ISTAT.DBDAL.DataSDMX.IsValid); }

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
        public string ResetDB(string dbName)
        {

            try
            {
                List<object> _errs = new List<object>();
                if (dbName == ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString())
                {
                    SDMX_Dataloader.Main.Settings.FilesSectionHandler config_dd = (SDMX_Dataloader.Main.Settings.FilesSectionHandler)System.Configuration.ConfigurationManager.GetSection("FilesSectionSettingsGroup/DD_Sql_Files");
                    foreach (SDMX_Dataloader.Main.Settings.FileConfigElement element in config_dd.Files)
                    {
                        string script = System.IO.File.ReadAllText(Server.MapPath(element.FilePath));
                        if (!ISTAT.DBDAL.DataAccess.ExecuteSQL(script))
                        {
                            Dictionary<string, object> _res = new Dictionary<string, object>();
                            _res.Add("LogTitle", ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString());
                            _res.Add("LogMessage", Resources.Notification.err_install + " in " + element.FilePath);
                            _errs.Add(_res);
                        }
                    }
                }
                if (dbName == ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString())
                {
                    SDMX_Dataloader.Main.Settings.FilesSectionHandler config_ms = (SDMX_Dataloader.Main.Settings.FilesSectionHandler)System.Configuration.ConfigurationManager.GetSection("FilesSectionSettingsGroup/MS_Sql_Files");
                    foreach (SDMX_Dataloader.Main.Settings.FileConfigElement element in config_ms.Files)
                    {
                        string script = System.IO.File.ReadAllText(Server.MapPath(element.FilePath));
                        if (!ISTAT.DBDAL.DataSDMX.ExecuteSQL(script))
                        {
                            Dictionary<string, object> _res = new Dictionary<string, object>();
                            _res.Add("LogTitle", ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString());
                            _res.Add("LogMessage", Resources.Notification.err_install + " in " + element.FilePath);
                            _errs.Add(_res);
                        }
                    }
                }

                if (_errs.Count > 0)
                {
                    Dictionary<string, object> _res = new Dictionary<string, object>();
                    _res.Add("ERRORS", _errs);
                    return JsonMessage.GetData(_res);
                }

                return JsonMessage.EmptyJSON;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string GetDomains(int idUser, bool stub)
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


                List<object> _result = new List<object>();

                // Get all themes
                List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject> _themes = ISTAT.DBDAL.DataSDMX.GetCategoryScheme();
                List<Category> _themesUser = (client.LoggedUser.Role == UserDef.RoleDef.Administrator) ? ISTAT.DBDAL.DataAccess.Get_Themes() : ISTAT.DBDAL.DataAccess.Get_Themes(idUser);

                List<string> cacheCategoryScheme = new List<string>();

                foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject cat in _themes)
                {

                    if (cat.Parent.Parent == null)
                    {
                        if (!cacheCategoryScheme.Contains(cat.Parent.MaintainableParent.Urn.ToString()))
                        {
                            Dictionary<string, object> _rowScheme = new Dictionary<string, object>();
                            _rowScheme.Add("id", cat.Parent.MaintainableParent.Urn.ToString());
                            _rowScheme.Add("parent", "#");

                            _rowScheme.Add("text", string.Format(" [ {0} ] - {1} ",
                                cat.Parent.MaintainableParent.Id,
                                ISTAT.ENTITY.TextTypeWrapper.GetStringLocale(
                                cat.Parent.MaintainableParent.Names,
                                ISTAT.DBDAL.DataAccess.CurrentCultureInfo)));
                            _rowScheme.Add("type", "categoryScheme");
                            _rowScheme.Add("icon", "img/cat_sch.png");
                            _result.Add(_rowScheme);
                            cacheCategoryScheme.Add(cat.Parent.MaintainableParent.Urn.ToString());
                        }

                    }

                    Dictionary<string, object> _row = new Dictionary<string, object>();

                    _row.Add("id", cat.Urn.ToString());
                    _row.Add("parent", (cat.Parent != null) ? cat.IdentifiableParent.Urn.ToString() : "#");
                    _row.Add("text", string.Format(" [ {0} ] - {1} ",
                        cat.Id,
                        ISTAT.ENTITY.TextTypeWrapper.GetStringLocale(
                        cat.Names,
                        ISTAT.DBDAL.DataAccess.CurrentCultureInfo)));
                    _row.Add("type", "category");
                    _row.Add("icon", "img/cat.png");

                    if (_themesUser != null)
                    {
                        IEnumerable<Category> query = from Category catUser in _themesUser
                                                      where catUser.IDTheme.ToString().Trim() == cat.Urn.ToString()
                                                      select catUser;
                        Dictionary<string, object> _status = new Dictionary<string, object>();
                        int nRes = query.Count<Category>();
                        _status.Add("selected", (query != null && nRes > 0));
                        _row.Add("state", _status);
                    }

                    _result.Add(_row);

                }

                if (stub == false)
                {
                    List<DataStructure> _structures = ISTAT.DBDAL.DataAccess.Get_DataStructures();
                    List<DataStructure> _structuresUser = ISTAT.DBDAL.DataAccess.Get_DataStructures(idUser);



                    foreach (DataStructure structure in (client.LoggedUser.Role == UserDef.RoleDef.Administrator) ? _structures : _structuresUser)
                    {
                        Dictionary<string, object> _row = new Dictionary<string, object>();
                        _row.Add("id", "ds_" + structure.IDSet);

                        string urn = ISTAT.DBDAL.DataAccess.Get_Theme_Urn(structure.IDTheme);
                        bool inProduction = ISTAT.DBDAL.DataSDMX.Get_DataflowProduction(structure.IDFlow);

                        _row.Add("parent", (urn != null) ? urn : "#");
                        _row.Add("text", string.Format(" [ {0} ] - {1} ",
                            structure.Code,
                            ISTAT.ENTITY.TextTypeWrapper.GetStringLocale(
                            structure.Names,
                            ISTAT.DBDAL.DataAccess.CurrentCultureInfo)));
                        _row.Add("type", "dataset");
                        Dictionary<string, object> data = new Dictionary<string, object>();
                        data.Add("inProduction", inProduction);
                        _row.Add("data", data);
                        _row.Add("icon", (inProduction) ? "img/cube_red.png" : "img/cube.png");

                        // With LINQ match a list themes for user end current theme
                        IEnumerable<DataStructure> query = from DataStructure structureUser in _structuresUser
                                                           where structureUser.IDSet == structure.IDSet
                                                           select structureUser;

                        Dictionary<string, object> _status = new Dictionary<string, object>();
                        int nRes = query.Count();
                        _status.Add("selected", (query != null && nRes > 0));
                        _row.Add("state", _status);

                        _result.Add(_row);
                    }
                }

                if (_result.Count == 1)
                    _result.Clear();

                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();

                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/json";
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
                HttpContext.Current.Response.Write(js.Serialize(_result));
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();

                return JsonMessage.GetData(_result);
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetDomains(int idUser, List<string> urnThemes, List<int> idDomainsStructure)
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

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.CRUDDomain))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);


                List<DataStructure> dsUser = ISTAT.DBDAL.DataAccess.Get_DataStructures(client.LoggedUser.ID);
                List<Category> catUser = ISTAT.DBDAL.DataAccess.Get_Themes(client.LoggedUser.ID);

                if (ISTAT.DBDAL.DataAccess.ClearDomain(idUser))
                {
                    foreach (string urnTheme in urnThemes)
                    {
                        // get or insert new
                        int idDomain = ISTAT.DBDAL.DataAccess.Insert_Theme(urnTheme);
                        ISTAT.DBDAL.DataAccess.Insert_Domain_Theme(idUser, idDomain);
                    }
                    foreach (int idDomain in idDomainsStructure)
                        ISTAT.DBDAL.DataAccess.Insert_Domain_Dataset(idUser, idDomain);
                }
                return JsonMessage.EmptyJSON;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

    }
}
