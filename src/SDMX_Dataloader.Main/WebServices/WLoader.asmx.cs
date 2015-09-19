using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using log4net;
using System.Web.Script.Services;
using ISTAT.ENTITY;
using SDMX_Dataloader.Engine;

namespace SDMX_Dataloader.Main.WebServices
{
    /// <summary>
    /// Summary description for WLoader
    /// </summary>
    [WebService(Namespace = "http://template/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class WLoader : System.Web.Services.WebService
    {

        // Logger
        private static readonly ILog Logger = LogManager.GetLogger(typeof(WLoader));
        // Metodo per inizializzare oggetti
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

                List<Dictionary<string, object>> maps = ISTAT.DBDAL.DataAccess.Get_Mappings(client.LoggedUser.ID);

                return JsonMessage.GetData(maps);
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetMappingScheme(int IDMappingSchema)
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

                if (client.LoaderProcedure == null) client.LoaderProcedure = LoaderProcedure.Create();

                client.LoaderProcedure.Set_Mappingset(IDMappingSchema);


                if (client.LoaderProcedure.Mapping != null)
                {
                    return JsonMessage.GetData(client.LoaderProcedure.Mapping);
                }
                else
                {
                    return JsonMessage.ErrorOccured;
                }

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetMappingItems()
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

                if (client.LoaderProcedure.HasValidMappingSet)
                    return JsonMessage.GetData(client.LoaderProcedure.Mapping.Items);
                else return JsonMessage.ErrorOccured;
            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string SetCube(int idCube)
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

                if (client.LoaderProcedure == null) client.LoaderProcedure = LoaderProcedure.Create();

                client.LoaderProcedure.Set_DataStructure(idCube);

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
        public string UploadFileData()
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

                ISTAT.IO.Utility.FileGeneric filedata = null; ;

                if (!HttpContext.Current.Request.Files.AllKeys.Any())
                    return JsonMessage.GetError(Resources.Notification.err_file_not_found);

                var httpPostedFile = HttpContext.Current.Request.Files["UploadedFileData"];
                //create object for CSVReader and pass the stream
                using (System.IO.Stream _stream = httpPostedFile.InputStream)
                {

                    #region Check file successfull sended

                    if (_stream == null)
                        return JsonMessage.GetError(Resources.Notification.err_file_csv);

                    // Get the uploaded image from the Files collection

                    string _userPath = HttpContext.Current.Server.MapPath(client.UserDirectory + System.IO.Path.DirectorySeparatorChar);
                    string filename = System.IO.Path.GetFileName(httpPostedFile.FileName);
                    string fileSavePath = System.IO.Path.Combine(_userPath, filename.Substring(0, filename.Length - 4));
                    int contentLength = httpPostedFile.ContentLength;
                    string contentType = httpPostedFile.ContentType;
                    string[] FileExt = httpPostedFile.FileName.Split('.');
                    string FileEx = FileExt[FileExt.Length - 1].ToLower();
                    string fullfilename = fileSavePath + "/" + filename;
                    if (FileEx != "csv" && FileEx != "xml")
                    {
                        return JsonMessage.GetError(Resources.Notification.err_file_bad_type);
                    }
                    // Check file exist
                    if (httpPostedFile.ContentLength < 1)
                    {
                        return JsonMessage.GetError(Resources.Notification.err_file_empty);
                    }
                    #endregion


                    if (System.IO.Directory.Exists(fileSavePath))
                        System.IO.Directory.Delete(fileSavePath, true);

                    System.IO.Directory.CreateDirectory(fileSavePath);

                    // Save intero file
                    httpPostedFile.SaveAs(fullfilename);

                    // save splitted files in byte
                    /*
                    int maxFilesize = (1024 * 1024) * 100;// 100Mb
                    _stream.Seek((firstRowHeader)?reader.LastBufferRead:0, System.IO.SeekOrigin.Begin);
                    ISTAT.IO.Utility.SplitFile(_stream, maxFilesize, fileSavePath);
                    */

                    // save splitted files in row
                    /*
                    List<string[]> _dataTable = new List<string[]>();
                     int indexFile = 0;
                    int countRow = 0;
                    int maxRowCount = int.Parse(System.Configuration.ConfigurationManager.AppSettings["CsvSplitterMaxRecord"]);
                    string[] str_row = reader.GetCSVLine();

                    while (str_row != null)
                    {
                        _dataTable.Add(str_row);

                        if (_dataTable.Count > maxRowCount - 1)
                        {
                            #region Write file with  maxRowCount block
                            using (System.IO.Stream streamPart = CSVWriter.CreateStream(_dataTable, ';'))
                            {
                                using (System.IO.Stream output = System.IO.File.Create(fileSavePath + "\\" + indexFile + ".csv"))
                                {
                                    streamPart.Seek(0, SeekOrigin.Begin);
                                    streamPart.CopyTo(output);
                                }
                            }
                            #endregion

                            indexFile++;
                            _dataTable = new List<string[]>();
                        }

                        countRow++;

                        str_row = reader.GetCSVLine();

                    }

                    #region Write file with rest
                    using (System.IO.Stream streamPart = CSVWriter.CreateStream(_dataTable, ';'))
                    {
                        using (System.IO.Stream output = System.IO.File.Create(fileSavePath + "\\" + indexFile + ".csv"))
                        {
                            streamPart.Seek(0, SeekOrigin.Begin);
                            streamPart.CopyTo(output);
                        }
                    }
                    #endregion
                     */

                    if (FileEx == "csv")
                    {

                        // annullo xml data
                        client.LoaderProcedure.Files_XML = null;

                        client.LoaderProcedure.File_CSV = new ISTAT.IO.FileCSV();
                        client.LoaderProcedure.File_CSV.filePath = fileSavePath;
                        client.LoaderProcedure.File_CSV.filename = filename;
                        client.LoaderProcedure.File_CSV.filesize = contentLength;
                        client.LoaderProcedure.File_CSV.content = contentType;
                        client.LoaderProcedure.File_CSV.stream = null;
                        client.LoaderProcedure.File_CSV.bytes = null;

                        ISTAT.IO.CSVReader reader = new ISTAT.IO.CSVReader((System.IO.Stream)_stream);
                        client.LoaderProcedure.File_CSV.firstRowHeader = client.LoaderProcedure.Mapping.CSV_HASHEADER;
                        reader.Separator = client.LoaderProcedure.File_CSV.separator = client.LoaderProcedure.Mapping.CSV_CHAR;
                        string[] headers = (client.LoaderProcedure.File_CSV.firstRowHeader) ? reader.GetHeaders() : reader.GetCSVLine();
                        client.LoaderProcedure.File_CSV.headers = headers;

                        filedata = (ISTAT.IO.Utility.FileGeneric)client.LoaderProcedure.File_CSV;

                    }
                    else if (FileEx == "xml")
                    {
                        // annullo csv data
                        client.LoaderProcedure.File_CSV = null;

                        client.LoaderProcedure.Files_XML = new ISTAT.IO.Utility.FileGeneric();
                        client.LoaderProcedure.Files_XML.filePath = fileSavePath;
                        client.LoaderProcedure.Files_XML.filename = filename;
                        client.LoaderProcedure.Files_XML.filesize = contentLength;
                        client.LoaderProcedure.Files_XML.content = contentType;
                        client.LoaderProcedure.Files_XML.stream = null;
                        client.LoaderProcedure.Files_XML.bytes = null;

                        filedata = (ISTAT.IO.Utility.FileGeneric)client.LoaderProcedure.Files_XML;
                    }
                }
                //_stream.Close();
                httpPostedFile.InputStream.Close();


                // force json responce header
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/json";
                HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
                HttpContext.Current.Response.Write(new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(filedata));
                HttpContext.Current.Response.End();
                //HttpContext.Current.ApplicationInstance.CompleteRequest();
                return JsonMessage.GetData(filedata);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string GetPreview()
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

                Dictionary<string, List<string>> _view = client.LoaderProcedure.Get_DATA_VIEW(10);

                if (_view == null) return JsonMessage.ErrorOccured;

                return JsonMessage.GetData(_view);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public string ImportData(string emailToReport, bool attributeFile)
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
                QueryReport report;

                if (!UserDef.UserCan(client.LoggedUser, UserDef.ActionDef.DefaultProc))
                    return JsonMessage.GetError(Resources.Notification.err_action_denied);

                if (attributeFile)
                {
                    string _userPath = HttpContext.Current.Server.MapPath(client.UserDirectory + System.IO.Path.DirectorySeparatorChar);

                    report = client.LoaderProcedure.Insert_AttributeDATA(_userPath);

                    #region responce data

                    if (report == null) return JsonMessage.ErrorOccured;

                    Dictionary<string, object> _report = new Dictionary<string, object>();

                    _report.Add("username", client.LoggedUser.Name + " " + client.LoggedUser.Surname);
                    _report.Add("filesource", report.FileSource);
                    if (!String.IsNullOrEmpty(report.ScartedFilePath))
                        _report.Add("scartedFilePath", HttpUtility.UrlPathEncode(HttpContext.Current.Request.ServerVariables["HTTP_HOST"] + "/" + client.UserDirectory.Replace("~/", "") + report.ScartedFilePath));
                    _report.Add("timeExecute", report.TimeExecute.Hours + ":" + report.TimeExecute.Minutes + ":" + report.TimeExecute.Seconds);
                    _report.Add("emailToReport", emailToReport);

                    return JsonMessage.GetData(_report);

                    #endregion

                }
                else
                {
                    report = client.LoaderProcedure.Insert_DATA();
                    #region Send email
                    if (SDMX_Dataloader.Main.Class.Util.IsValidEmail(emailToReport))
                    {

                        string mailTo = emailToReport;
                        string mailObj = "SDMX DataLoader - Report";
                        string mailBody = "Report of import data for :" + client.LoaderProcedure.DataSet.Code + "\n";
                        mailBody += "Execute in time: " + report.TimeExecute.ToString() + "\n";
                        mailBody += "Record: " + report.RecordTargetCount + "/" + report.RecordTargetCount + "\n";
                        if (report.Errors != null && report.Errors.Count > 0)
                        {
                            mailBody += "Record Error: " + report.Errors.Count + "\n";
                            foreach (string error in report.Errors)
                            {
                                mailBody += error + "\n";
                            }
                        }

                        Settings.MailSettingsHandler config =
                           (Settings.MailSettingsHandler)System.Configuration.ConfigurationManager.GetSection(
                               "MailSettingsGroup/MailSettingsSection");

                        SDMX_Dataloader.Main.Class.Util.SendMail(config.SmtpHost,
                            config.SmtpPort,
                            config.SmtpSsl,
                            config.MailFrom,
                            config.MailFromPassword,
                            config.MailFromName,
                            mailTo,
                            mailObj,
                            mailBody);

                    }
                    #endregion

                    #region responce data

                    if (report == null) return JsonMessage.ErrorOccured;

                    Dictionary<string, object> _report = new Dictionary<string, object>();

                    _report.Add("username", client.LoggedUser.Name + " " + client.LoggedUser.Surname);
                    _report.Add("rowfail", report.Errors);
                    _report.Add("filesource", report.FileSource);
                    _report.Add("emailToReport", emailToReport);
                    _report.Add("timeExecute", report.TimeExecute.Hours + ":" + report.TimeExecute.Minutes + ":" + report.TimeExecute.Seconds);
                    _report.Add("recordCount", report.RecordCount);
                    _report.Add("recordTargetCount", report.RecordTargetCount);
                    _report.Add("recordIgnoreCount", report.RecordIgnoreCount);
                    _report.Add("recordOverrideCount", report.RecordOverrideCount);

                    return JsonMessage.GetData(_report);

                    #endregion

                }




            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                return JsonMessage.ErrorOccured;
            }
        }


    }
}
