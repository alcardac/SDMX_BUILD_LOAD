using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using ISTAT.ENTITY;

using Microsoft.SqlServer.Server;
using BulkUpload;
using System.IO;

namespace ISTAT.DBDAL
{
    public class DataAccess
    {

        public static readonly string Version_major = "1";
        public static readonly string Version_intermediate = "2";
        public static readonly string Version_lower = "0";

        private static readonly System.Configuration.ConnectionStringSettings SQLConnString_DB = System.Configuration.ConfigurationManager.ConnectionStrings[ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString()];

        private static System.Globalization.CultureInfo cultureInfo;
        public static System.Globalization.CultureInfo CurrentCultureInfo { get { return cultureInfo; } set { cultureInfo = value; } }
        private static string TwoLetterIso { get { return (CurrentCultureInfo != null) ? CurrentCultureInfo.TwoLetterISOLanguageName : "en"; } }

        public static bool ExecuteSQL(string sql)
        {
            Microsoft.SqlServer.Management.Smo.Server server = null;
            Microsoft.SqlServer.Management.Common.ServerConnection svrConnection = null;
            System.Data.SqlClient.SqlConnection sqlConnection = null;
            try
            {
                sqlConnection = new System.Data.SqlClient.SqlConnection(DataAccess.SQLConnString_DB.ConnectionString);

                svrConnection = new Microsoft.SqlServer.Management.Common.ServerConnection(sqlConnection);

                server = new Microsoft.SqlServer.Management.Smo.Server(svrConnection);

                server.ConnectionContext.ExecuteNonQuery(sql);
                server.ConnectionContext.ForceDisconnected();
                return true;
            }
            catch (Exception ex)
            {
                if (server != null)
                {
                    server.ConnectionContext.ForceDisconnected();
                }
                return false;
            }
        }

        #region Metodi per gestione utenze

        public static List<UserDef> Get_Users()
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);
            if (dtw.TestConnection())
            {

                // Access on db with the stored proc TryLogin
                dtw.DBConnection.Open();
                System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "dbo.proc_GET_USERS";

                System.Data.IDataReader _reader = cmd.ExecuteReader();
                List<UserDef> _users = new List<UserDef>();
                while (_reader.Read())
                {
                    UserDef _user = new UserDef();
                    _user.ID = _reader.GetInt32(_reader.GetOrdinal("ID_USER"));
                    _user.Username = _reader.GetString(_reader.GetOrdinal("USERNAME"));
                    _user.Password = _reader.GetString(_reader.GetOrdinal("PWD"));
                    _user.Role = ((UserDef.RoleDef)_reader.GetInt32(_reader.GetOrdinal("ID_ROLE")));
                    _user.Name = _reader.GetString(_reader.GetOrdinal("NAME"));
                    _user.Surname = _reader.GetString(_reader.GetOrdinal("SURNAME"));
                    _user.ProFlag = _reader.GetBoolean(_reader.GetOrdinal("PROFLAG"));
                    _user.Email = (_reader.GetValue(_reader.GetOrdinal("EMAIL")) != DBNull.Value) ? _reader.GetString(_reader.GetOrdinal("EMAIL")) : string.Empty;

                    _users.Add(_user);
                }
                dtw.DBConnection.Close();

                return (_users.Count == 0) ? null : _users;
            }
            return null;
        }
        public static UserDef Get_User(string username, string password)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);
            if (dtw.TestConnection())
            {

                // Access on db with the stored proc TryLogin
                dtw.DBConnection.Open();
                System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "dbo.proc_TRY_LOGIN";

                System.Data.IDbDataParameter _username = cmd.CreateParameter();
                _username.DbType = System.Data.DbType.String;
                _username.ParameterName = "username";
                _username.Value = username;
                cmd.Parameters.Add(_username);

                System.Data.IDbDataParameter _password = cmd.CreateParameter();
                _password.DbType = System.Data.DbType.String;
                _password.ParameterName = "password";
                _password.Value = password;
                cmd.Parameters.Add(_password);

                System.Data.IDataReader _reader = cmd.ExecuteReader();
                UserDef _user = new UserDef();
                if (_reader.Read())
                {
                    _user.ID = _reader.GetInt32(_reader.GetOrdinal("ID_USER"));
                    _user.Username = username;
                    _user.Password = password;
                    _user.Role = ((UserDef.RoleDef)_reader.GetInt32(_reader.GetOrdinal("ID_ROLE")));
                    _user.ProFlag = (_reader.GetBoolean(_reader.GetOrdinal("PROFLAG")));
                    _user.Name = _reader.GetString(_reader.GetOrdinal("NAME"));
                    _user.Surname = _reader.GetString(_reader.GetOrdinal("SURNAME"));
                    _user.Email = (_reader.GetValue(_reader.GetOrdinal("EMAIL")) != DBNull.Value) ? _reader.GetString(_reader.GetOrdinal("EMAIL")) : string.Empty;
                }
                else
                {
                    _user = null;
                }
                dtw.DBConnection.Close();

                return _user;
            }
            return null;
        }
        public static int Insert_User(UserDef user)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_USER";

                    System.Data.IDbDataParameter _username = cmd.CreateParameter();
                    _username.DbType = System.Data.DbType.String;
                    _username.ParameterName = "username";
                    _username.Value = user.Username;
                    cmd.Parameters.Add(_username);

                    System.Data.IDbDataParameter _password = cmd.CreateParameter();
                    _password.DbType = System.Data.DbType.String;
                    _password.ParameterName = "password";
                    _password.Value = user.Password;
                    cmd.Parameters.Add(_password);

                    System.Data.IDbDataParameter _id_role = cmd.CreateParameter();
                    _id_role.DbType = System.Data.DbType.String;
                    _id_role.ParameterName = "id_role";
                    _id_role.Value = (int)user.Role;
                    cmd.Parameters.Add(_id_role);

                    System.Data.IDbDataParameter _name = cmd.CreateParameter();
                    _name.DbType = System.Data.DbType.String;
                    _name.ParameterName = "name";
                    _name.Value = user.Name;
                    cmd.Parameters.Add(_name);

                    System.Data.IDbDataParameter _surname = cmd.CreateParameter();
                    _surname.DbType = System.Data.DbType.String;
                    _surname.ParameterName = "surname";
                    _surname.Value = user.Surname;
                    cmd.Parameters.Add(_surname);

                    System.Data.IDbDataParameter _proFlag = cmd.CreateParameter();
                    _proFlag.DbType = System.Data.DbType.String;
                    _proFlag.ParameterName = "proFlag";
                    _proFlag.Value = user.ProFlag;
                    cmd.Parameters.Add(_proFlag);

                    System.Data.IDbDataParameter _email = cmd.CreateParameter();
                    _email.DbType = System.Data.DbType.String;
                    _email.ParameterName = "email";
                    _email.Value = user.Email;
                    cmd.Parameters.Add(_email);

                    int idUser = (int)cmd.ExecuteScalar();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return idUser;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }
        public static bool Update_User(UserDef user)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_UPDATE_USER";

                    if (user.ID != -1)
                    {
                        System.Data.IDbDataParameter _id_user = cmd.CreateParameter();
                        _id_user.DbType = System.Data.DbType.Int32;
                        _id_user.ParameterName = "id_user";
                        _id_user.Value = user.ID;
                        cmd.Parameters.Add(_id_user);
                    }
                    if (user.Username != string.Empty)
                    {
                        System.Data.IDbDataParameter _username = cmd.CreateParameter();
                        _username.DbType = System.Data.DbType.String;
                        _username.ParameterName = "username";
                        _username.Value = user.Username;
                        cmd.Parameters.Add(_username);
                    }
                    if (user.Password != string.Empty)
                    {
                        System.Data.IDbDataParameter _password = cmd.CreateParameter();
                        _password.DbType = System.Data.DbType.String;
                        _password.ParameterName = "password";
                        _password.Value = user.Password;
                        cmd.Parameters.Add(_password);
                    }
                    if (user.Name != string.Empty)
                    {
                        System.Data.IDbDataParameter _name = cmd.CreateParameter();
                        _name.DbType = System.Data.DbType.String;
                        _name.ParameterName = "name";
                        _name.Value = user.Name;
                        cmd.Parameters.Add(_name);
                    }
                    if (user.Surname != string.Empty)
                    {
                        System.Data.IDbDataParameter _surname = cmd.CreateParameter();
                        _surname.DbType = System.Data.DbType.String;
                        _surname.ParameterName = "surname";
                        _surname.Value = user.Surname;
                        cmd.Parameters.Add(_surname);
                    }
                    if (user.Email != string.Empty)
                    {
                        System.Data.IDbDataParameter _email = cmd.CreateParameter();
                        _email.DbType = System.Data.DbType.String;
                        _email.ParameterName = "email";
                        _email.Value = user.Email;
                        cmd.Parameters.Add(_email);
                    }

                    // Enum no null value
                    System.Data.IDbDataParameter _id_role = cmd.CreateParameter();
                    _id_role.DbType = System.Data.DbType.Int32;
                    _id_role.ParameterName = "id_role";
                    _id_role.Value = (int)user.Role;
                    cmd.Parameters.Add(_id_role);

                    // Bool no null value
                    System.Data.IDbDataParameter _proFlag = cmd.CreateParameter();
                    _proFlag.DbType = System.Data.DbType.Boolean;
                    _proFlag.ParameterName = "proFlag";
                    _proFlag.Value = user.ProFlag;
                    cmd.Parameters.Add(_proFlag);

                    cmd.ExecuteNonQuery();
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            }
            return false;
        }
        public static bool Delete_User(int idUser)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_DELETE_USER";

                    System.Data.IDbDataParameter _iduser = cmd.CreateParameter();
                    _iduser.DbType = System.Data.DbType.Int32;
                    _iduser.ParameterName = "id_user";
                    _iduser.Value = idUser;
                    cmd.Parameters.Add(_iduser);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }

        public static bool ClearDomain(int idUser)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_CLEAR_DOMAIN";

                    System.Data.IDbDataParameter _iduser = cmd.CreateParameter();
                    _iduser.DbType = System.Data.DbType.Int32;
                    _iduser.ParameterName = "id_user";
                    _iduser.Value = idUser;
                    cmd.Parameters.Add(_iduser);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        public static bool Insert_Domain_Dataset(int idUser, int idSet)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_DOMAIN_SET";

                    System.Data.IDbDataParameter _iduser = cmd.CreateParameter();
                    _iduser.DbType = System.Data.DbType.Int32;
                    _iduser.ParameterName = "id_user";
                    _iduser.Value = idUser;
                    cmd.Parameters.Add(_iduser);

                    System.Data.IDbDataParameter _idDataset = cmd.CreateParameter();
                    _idDataset.DbType = System.Data.DbType.Int32;
                    _idDataset.ParameterName = "id_set";
                    _idDataset.Value = idSet;
                    cmd.Parameters.Add(_idDataset);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        public static bool Insert_Domain_Theme(int idUser, int idTheme)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_DOMAIN_THEME";

                    System.Data.IDbDataParameter _iduser = cmd.CreateParameter();
                    _iduser.DbType = System.Data.DbType.Int32;
                    _iduser.ParameterName = "id_user";
                    _iduser.Value = idUser;
                    cmd.Parameters.Add(_iduser);

                    System.Data.IDbDataParameter _idTheme = cmd.CreateParameter();
                    _idTheme.DbType = System.Data.DbType.Int32;
                    _idTheme.ParameterName = "id_theme";
                    _idTheme.Value = idTheme;
                    cmd.Parameters.Add(_idTheme);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        #endregion

        #region Metodi per gestione localizzazione

        /// <summary>
        /// Insert_StringLocation
        /// </summary>
        /// <param name="locations">List of localised strings</param>
        /// <param name="IDMember">ID of item</param>
        /// <param name="MemberTable">Table of item</param>
        /// <returns>Return true if all strings are insert | false if error</returns>
        public static bool Insert_LocalisedString(List<TextTypeWrapper> locations, int IDMember, string MemberTable)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_SET_LOCATION";

                    System.Data.IDbDataParameter param_ID = cmd.CreateParameter();
                    param_ID.DbType = System.Data.DbType.Int32;
                    param_ID.ParameterName = "IDMember";
                    cmd.Parameters.Add(param_ID);

                    System.Data.IDbDataParameter param_Table = cmd.CreateParameter();
                    param_Table.DbType = System.Data.DbType.String;
                    param_Table.ParameterName = "MemberTable";
                    cmd.Parameters.Add(param_Table);

                    System.Data.IDbDataParameter param_locale = cmd.CreateParameter();
                    param_locale.DbType = System.Data.DbType.String;
                    param_locale.ParameterName = "TwoLetterISO";
                    cmd.Parameters.Add(param_locale);

                    System.Data.IDbDataParameter param_value = cmd.CreateParameter();
                    param_value.DbType = System.Data.DbType.String;
                    param_value.ParameterName = "Value";
                    cmd.Parameters.Add(param_value);

                    foreach (TextTypeWrapper location in locations)
                    {
                        param_value.Value = location.Value.Replace("'", "''");
                        param_locale.Value = location.Locale;
                        param_Table.Value = MemberTable;
                        param_ID.Value = IDMember;

                        cmd.ExecuteNonQuery();
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();

                    return true;

                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            }
            return false;
        }
        /// <summary>
        /// Get_StringsLocation
        /// </summary>
        /// <param name="IDMember">ID of item</param>
        /// <param name="MemberTable">Table of item</param>
        /// <returns>return localised strings list of ID/MemberTable | NULL if error</returns>
        public static List<TextTypeWrapper> Get_LocalisedStrings(int IDMember, string MemberTable)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_LOCATION_ALL";

                    System.Data.IDbDataParameter param_ID = cmd.CreateParameter();
                    param_ID.DbType = System.Data.DbType.Int32;
                    param_ID.ParameterName = "IDMember";
                    param_ID.Value = IDMember;
                    cmd.Parameters.Add(param_ID);

                    System.Data.IDbDataParameter param_Table = cmd.CreateParameter();
                    param_Table.DbType = System.Data.DbType.String;
                    param_Table.ParameterName = "MemberTable";
                    param_Table.Value = MemberTable;
                    cmd.Parameters.Add(param_Table);

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    List<TextTypeWrapper> listResult = new List<TextTypeWrapper>();

                    while (reader.Read())
                    {
                        TextTypeWrapper text = new TextTypeWrapper(reader.GetString(reader.GetOrdinal("TwoLetterIso")), reader.GetString(reader.GetOrdinal("Value")));
                        listResult.Add(text);
                    }

                    dtw.DBConnection.Close();
                    return listResult;

                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        #endregion

        // Get All theme in DDB
        public static List<Category> Get_Themes()
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_THEME";

                    List<Category> themes = new List<Category>();

                    IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {

                        Category theme = new Category(
                            _reader.GetInt32(_reader.GetOrdinal("IDTheme")),
                            (_reader.IsDBNull(_reader.GetOrdinal("IDThemeParent")) ? -1 : _reader.GetInt32(_reader.GetOrdinal("IDThemeParent"))),
                            _reader.GetString(_reader.GetOrdinal("Urn"))
                            );


                        // no Localised string for category

                        //List<TextTypeWrapper> names= DataAccess.Get_LocalisedStrings((int)theme.IDTheme, "CatTheme");
                        //theme.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        themes.Add(theme);
                    }


                    ////////////////////////

                    dtw.DBConnection.Close();
                    return themes;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }
        // Get All theme in DDB by Domains User
        public static List<Category> Get_Themes(int idUser)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_THEME";

                    System.Data.IDbDataParameter param = cmd.CreateParameter();
                    param.DbType = System.Data.DbType.Int32;
                    param.ParameterName = "IdUser";
                    param.Value = idUser;
                    cmd.Parameters.Add(param);

                    List<Category> themes = new List<Category>();
                    IDataReader _reader = cmd.ExecuteReader();

                    while (_reader.Read())
                    {

                        Category theme = new Category(
                            _reader.GetInt32(_reader.GetOrdinal("IDTheme")),
                            (_reader.IsDBNull(_reader.GetOrdinal("IDThemeParent")) ? -1 : _reader.GetInt32(_reader.GetOrdinal("IDThemeParent"))),
                            _reader.GetString(_reader.GetOrdinal("Urn"))
                            );

                        // no Localised string for category

                        //List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings((int)theme.IDTheme, "CatTheme");
                        //theme.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        themes.Add(theme);
                    }


                    ////////////////////////

                    dtw.DBConnection.Close();
                    return themes;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }
        // Insert reference of CategoryObject URN in DDB
        public static int Insert_Theme(string urnCategory)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_THEME";

                    System.Data.IDbDataParameter _urn = cmd.CreateParameter();
                    _urn.DbType = System.Data.DbType.String;
                    _urn.ParameterName = "Urn";
                    _urn.Value = urnCategory;
                    cmd.Parameters.Add(_urn);

                    System.Data.IDbDataParameter _idTheme = cmd.CreateParameter();
                    _idTheme.DbType = System.Data.DbType.Int32;
                    _idTheme.ParameterName = "IDTheme";
                    _idTheme.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(_idTheme);

                    cmd.ExecuteNonQuery();

                    int idTheme = (int)_idTheme.Value;

                    ////////////////////////
                    dtw.DBConnection.Close();
                    return idTheme;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }
        // Get URN of CategoryObject from DDB
        public static string Get_Theme_Urn(int idTheme)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_THEME_URN";

                    System.Data.IDbDataParameter param_idTheme = cmd.CreateParameter();
                    param_idTheme.DbType = System.Data.DbType.Int32;
                    param_idTheme.ParameterName = "IdTheme";
                    param_idTheme.Value = idTheme;
                    cmd.Parameters.Add(param_idTheme);

                    Category theme = null;

                    IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {

                        theme = new Category(
                            _reader.GetInt32(_reader.GetOrdinal("IDTheme")),
                            (_reader.IsDBNull(_reader.GetOrdinal("IDThemeParent")) ? -1 : _reader.GetInt32(_reader.GetOrdinal("IDThemeParent"))),
                            _reader.GetString(_reader.GetOrdinal("Urn"))
                        );


                        // no Localised string for category

                        //List<TextTypeWrapper> names= DataAccess.Get_LocalisedStrings((int)theme.IDTheme, "CatTheme");
                        //theme.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                    }


                    ////////////////////////

                    dtw.DBConnection.Close();

                    return theme.Urn;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }


        // Get all structure with user domain | NULL if error
        public static List<DataStructure> Get_DataStructures(int id_user)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DATASTRUCT_BY_USER";
                    System.Data.IDbDataParameter param_id_user = cmd.CreateParameter();
                    param_id_user.DbType = System.Data.DbType.Int32;
                    param_id_user.ParameterName = "IDUser";
                    param_id_user.Value = id_user;
                    cmd.Parameters.Add(param_id_user);

                    System.Data.IDbDataParameter param_twoLetter = cmd.CreateParameter();
                    param_twoLetter.DbType = System.Data.DbType.String;
                    param_twoLetter.ParameterName = "TwoLetterISO";
                    param_twoLetter.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(param_twoLetter);

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    List<DataStructure> listResult = new List<DataStructure>();

                    while (reader.Read())
                    {

                        DataStructure ds =
                            new DataStructure(
                                reader.GetInt32(reader.GetOrdinal("IDSet")),
                                reader.GetString(reader.GetOrdinal("Code")),
                                reader.GetInt32(reader.GetOrdinal("IDDataFlow")));

                        ds.IDTheme = reader.GetInt32(reader.GetOrdinal("IDTheme"));


                        List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings(ds.IDSet, "CatSet");

                        ds.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        listResult.Add(ds);

                    }

                    for (int i = 0; i < listResult.Count; i++)
                    {
                        listResult[i].IDDsd = DataSDMX.Get_IDDsd(listResult[i].IDFlow);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return listResult;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        #region Metodi per gestione creazione Cubi

        public static List<DataStructure> Get_DataStructures()
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DATASTRUCTS";

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    List<DataStructure> listResult = new List<DataStructure>();

                    while (reader.Read())
                    {

                        DataStructure ds =
                            new DataStructure(
                                reader.GetInt32(reader.GetOrdinal("IDSet")),
                                reader.GetString(reader.GetOrdinal("Code")),
                                reader.GetInt32(reader.GetOrdinal("IDDataFlow")));
                        ds.IDTheme = reader.GetInt32(reader.GetOrdinal("IDTheme"));
                        List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings(ds.IDSet, "CatSet");

                        ds.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        listResult.Add(ds);

                    }

                    for (int i = 0; i < listResult.Count; i++)
                    {
                        listResult[i].IDDsd = DataSDMX.Get_IDDsd(listResult[i].IDFlow);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return listResult;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        public static DataStructure Get_DataStructureByDataflow(ISTAT.ENTITY.SDMXIdentifier dataflow)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DATASTRUCT_BY_DATAFLOW";

                    System.Data.IDbDataParameter param_agencyid = cmd.CreateParameter();
                    param_agencyid.DbType = System.Data.DbType.String;
                    param_agencyid.ParameterName = "agencyid";
                    param_agencyid.Value = dataflow.agencyid;
                    cmd.Parameters.Add(param_agencyid);

                    System.Data.IDbDataParameter param_id = cmd.CreateParameter();
                    param_id.DbType = System.Data.DbType.String;
                    param_id.ParameterName = "id";
                    param_id.Value = dataflow.id;
                    cmd.Parameters.Add(param_id);

                    System.Data.IDbDataParameter param_version = cmd.CreateParameter();
                    param_version.DbType = System.Data.DbType.String;
                    param_version.ParameterName = "version";
                    param_version.Value = dataflow.version;
                    cmd.Parameters.Add(param_version);

                    System.Data.IDbDataParameter param_twoLetter = cmd.CreateParameter();
                    param_twoLetter.DbType = System.Data.DbType.String;
                    param_twoLetter.ParameterName = "TwoLetterISO";
                    param_twoLetter.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(param_twoLetter);

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    DataStructure ds = null;

                    if (reader.Read())
                    {
                        ds =
                            new DataStructure(
                                reader.GetInt32(reader.GetOrdinal("IDSet")),
                                reader.GetString(reader.GetOrdinal("Code")),
                                reader.GetInt32(reader.GetOrdinal("IDDataFlow")));
                        ds.IDTheme = reader.GetInt32(reader.GetOrdinal("IDTheme"));

                        List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings(ds.IDSet, "CatSet");

                        ds.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);


                        //ds.Names.Add(new TextTypeWrapper(DataAccess.TwoLetterIso, reader.GetString(reader.GetOrdinal("Value"))));

                        ds.IDDsd = DataSDMX.Get_IDDsd(ds.IDFlow);

                    }
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return ds;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        /// <summary>
        /// Get_DataStructure
        /// </summary>
        /// <param name="id_set">ID of Structure in database</param>
        /// <returns>Return Structure form database | NULL if error</returns>
        public static DataStructure Get_DataStructure(int id_set)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DATASTRUCT";

                    System.Data.IDbDataParameter param_idSet = cmd.CreateParameter();
                    param_idSet.DbType = System.Data.DbType.Int32;
                    param_idSet.ParameterName = "IDSet";
                    param_idSet.Value = id_set;
                    cmd.Parameters.Add(param_idSet);

                    System.Data.IDbDataParameter param_twoLetter = cmd.CreateParameter();
                    param_twoLetter.DbType = System.Data.DbType.String;
                    param_twoLetter.ParameterName = "TwoLetterISO";
                    param_twoLetter.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(param_twoLetter);

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    DataStructure ds = null;

                    if (reader.Read())
                    {
                        ds =
                            new DataStructure(
                                reader.GetInt32(reader.GetOrdinal("IDSet")),
                                reader.GetString(reader.GetOrdinal("Code")),
                                reader.GetInt32(reader.GetOrdinal("IDDataFlow")),
                                reader.GetInt32(reader.GetOrdinal("IDTheme")));

                        ds.IDDsd = DataSDMX.Get_IDDsd(ds.IDFlow);

                        ds.Names = DataAccess.Get_LocalisedStrings(ds.IDSet, "CatSet");

                        string theme_urn = reader.GetString(reader.GetOrdinal("ThemeURN"));
                        List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject> cats = DataSDMX.GetCategoryScheme();
                        var listLocThemes = from c in cats where c.Urn.ToString() == theme_urn select c;
                        foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper theme in listLocThemes.First().Names)
                            ds.Themes.Add(new TextTypeWrapper(theme.Locale, theme.Value));


                        ds.DataFlowIdentifier = SDMXIdentifier.CreateFromString(reader.GetString(reader.GetOrdinal("Dataflow")));

                    }
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return ds;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }
        /// <summary>
        /// Insert_DataStructure
        /// </summary>
        /// <param name="id_user">ID of User</param>
        /// <param name="idTheme">ID of Theme</param>
        /// <param name="code">string CODE</param>
        /// <returns>Return ID of new Structure | -1 if error</returns>
        public static int Insert_DataStructure(int id_user, int idTheme, string code)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_CREATE_CUBE";

                    System.Data.IDbDataParameter _id_param = cmd.CreateParameter();
                    _id_param.DbType = System.Data.DbType.Int32;
                    _id_param.ParameterName = "IDUser";
                    _id_param.Value = id_user;
                    cmd.Parameters.Add(_id_param);

                    System.Data.IDbDataParameter _code = cmd.CreateParameter();
                    _code.DbType = System.Data.DbType.String;
                    _code.ParameterName = "DatasetCode";
                    _code.Value = code;
                    cmd.Parameters.Add(_code);

                    System.Data.IDbDataParameter _idtheme_param = cmd.CreateParameter();
                    _idtheme_param.DbType = System.Data.DbType.Int32;
                    _idtheme_param.ParameterName = "IDTheme";
                    _idtheme_param.Value = idTheme;
                    cmd.Parameters.Add(_idtheme_param);


                    int idSet = (int)cmd.ExecuteScalar();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return idSet;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }
        /// <summary>
        /// Get_Dimensions
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>return list of dimension form specific structure | NULL if error</returns>
        public static List<Dimension> Get_Dimensions(int idset)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    List<Dimension> dims = new List<Dimension>();
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DIMENSIONS";

                    System.Data.IDbDataParameter _idset = cmd.CreateParameter();
                    _idset.DbType = System.Data.DbType.Int32;
                    _idset.ParameterName = "IDSet";
                    _idset.Value = idset;
                    cmd.Parameters.Add(_idset);

                    System.Data.IDbDataParameter _twoLetterISO = cmd.CreateParameter();
                    _twoLetterISO.DbType = System.Data.DbType.String;
                    _twoLetterISO.ParameterName = "TwoLetterISO";
                    _twoLetterISO.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(_twoLetterISO);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {
                        Dimension dim = new Dimension();
                        dim.Id = _reader.GetString(_reader.GetOrdinal("Code"));

                        dim.TimeDimension = _reader.GetBoolean(_reader.GetOrdinal("IsTimeSeriesDim"));

                        List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings(_reader.GetInt32(_reader.GetOrdinal("IDDim")), "CatDim");
                        dim.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        dims.Add(dim);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return dims;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        /// <summary>
        /// Get_DimensionsPartial
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>return list of dimension concept db form specific structure | NULL if error</returns>
        public static List<ConceptDimensionDB> Get_DimensionsPartial(int idset)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    List<ConceptDimensionDB> conceptDbs = new List<ConceptDimensionDB>();
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_DIMENSIONS";

                    System.Data.IDbDataParameter _idset = cmd.CreateParameter();
                    _idset.DbType = System.Data.DbType.Int32;
                    _idset.ParameterName = "IDSet";
                    _idset.Value = idset;
                    cmd.Parameters.Add(_idset);

                    System.Data.IDbDataParameter _twoLetterISO = cmd.CreateParameter();
                    _twoLetterISO.DbType = System.Data.DbType.String;
                    _twoLetterISO.ParameterName = "TwoLetterISO";
                    _twoLetterISO.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(_twoLetterISO);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {
                        ConceptDimensionDB conceptDb = new ConceptDimensionDB();
                        conceptDb.Code = _reader.GetString(_reader.GetOrdinal("Code"));
                        conceptDb.IDName = _reader.GetString(_reader.GetOrdinal("IDName"));
                        conceptDb.MemberTable = _reader.GetString(_reader.GetOrdinal("MemberTable"));
                        conceptDb.IsTimeSeriesDim = _reader.GetBoolean(_reader.GetOrdinal("IsTimeSeriesDim"));

                        conceptDbs.Add(conceptDb);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return conceptDbs;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        /// <summary>
        /// Get_IDCode
        /// </summary>
        /// <param name="memberTable">Name of table</param>
        /// <param name="code">Code to search</param>
        /// <returns>Return ID of code in table | -1 if error</returns>
        public static int Get_IDCode(string memberTable, string code)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////
                    int iddim = -1;
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_CODE_ID";

                    System.Data.IDbDataParameter _memberTable = cmd.CreateParameter();
                    _memberTable.DbType = System.Data.DbType.String;
                    _memberTable.ParameterName = "MemberTable";
                    _memberTable.Value = memberTable;
                    cmd.Parameters.Add(_memberTable);

                    System.Data.IDbDataParameter _code = cmd.CreateParameter();
                    _code.DbType = System.Data.DbType.String;
                    _code.ParameterName = "Code";
                    _code.Value = code;
                    cmd.Parameters.Add(_code);

                    iddim = (int)cmd.ExecuteScalar();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return iddim;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }
        /// <summary>
        /// Get_Attributes
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>return list of attributes form specific structure</returns>
        public static List<ISTAT.ENTITY.Attribute> Get_Attributes(int idset)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    List<ISTAT.ENTITY.Attribute> atts = new List<ISTAT.ENTITY.Attribute>();

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_ATTRIBUTES";

                    System.Data.IDbDataParameter _idset = cmd.CreateParameter();
                    _idset.DbType = System.Data.DbType.Int32;
                    _idset.ParameterName = "IDSet";
                    _idset.Value = idset;
                    cmd.Parameters.Add(_idset);

                    System.Data.IDbDataParameter _twoLetterISO = cmd.CreateParameter();
                    _twoLetterISO.DbType = System.Data.DbType.String;
                    _twoLetterISO.ParameterName = "TwoLetterISO";
                    _twoLetterISO.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(_twoLetterISO);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {
                        ISTAT.ENTITY.Attribute att = new ISTAT.ENTITY.Attribute();
                        att.Id = _reader.GetString(_reader.GetOrdinal("Code"));
                        att.IsCodelist = _reader.GetBoolean(_reader.GetOrdinal("IsCodelist"));

                        List<TextTypeWrapper> names = DataAccess.Get_LocalisedStrings(_reader.GetInt32(_reader.GetOrdinal("IDAtt")), "CatAtt");
                        att.Names.Add(names[TextTypeWrapper.GetIndexLocale(names, DataAccess.TwoLetterIso)]);

                        atts.Add(att);
                    }
                    _reader.Close();

                    foreach (ISTAT.ENTITY.Attribute att in atts)
                    {
                        System.Data.IDbCommand cmd_attach = dtw.DBConnection.CreateCommand();
                        cmd_attach.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd_attach.CommandText = "dbo.proc_GET_ATT_ATTACH";

                        System.Data.IDbDataParameter _idSetAttach = cmd_attach.CreateParameter();
                        _idSetAttach.DbType = System.Data.DbType.Int32;
                        _idSetAttach.ParameterName = "IDSet";
                        _idSetAttach.Value = idset;
                        cmd_attach.Parameters.Add(_idSetAttach);

                        System.Data.IDbDataParameter _codeAttAttach = cmd_attach.CreateParameter();
                        _codeAttAttach.DbType = System.Data.DbType.String;
                        _codeAttAttach.ParameterName = "AttCode";
                        _codeAttAttach.Value = att.Id;
                        cmd_attach.Parameters.Add(_codeAttAttach);

                        System.Data.IDataReader _readerAttach = cmd_attach.ExecuteReader();
                        att.DimensionReferences = new List<string>();
                        while (_readerAttach.Read())
                        {
                            int idDim = _readerAttach.GetInt32(_readerAttach.GetOrdinal("IDDim"));
                            att.DimensionReferences.Add(idDim.ToString());
                        }
                        _readerAttach.Close();

                        if (att.DimensionReferences.Count == 0)
                        {
                            att.AttachmentLevel = Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DataSet.ToString();
                        }
                        else if (att.DimensionReferences.Count == 1)
                        {
                            att.AttachmentLevel = Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.Observation.ToString();
                        }
                        else if (att.DimensionReferences.Count > 1)
                        {
                            att.AttachmentLevel = Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString();
                        }

                    }


                    foreach (ISTAT.ENTITY.Attribute att in atts)
                    {
                        if (att.AttachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString())
                        {
                            List<string> _dimensionReferences = new List<string>();
                            foreach (string str_dim in att.DimensionReferences)
                            {
                                System.Data.IDbCommand cmd_attach_code = dtw.DBConnection.CreateCommand();
                                cmd_attach_code.CommandType = System.Data.CommandType.StoredProcedure;
                                cmd_attach_code.CommandText = "dbo.proc_GET_DIMENISION_CODE";

                                System.Data.IDbDataParameter _idAtt = cmd_attach_code.CreateParameter();
                                _idAtt.DbType = System.Data.DbType.Int32;
                                _idAtt.ParameterName = "IDDim";
                                _idAtt.Value = str_dim;
                                cmd_attach_code.Parameters.Add(_idAtt);

                                _dimensionReferences.Add(cmd_attach_code.ExecuteScalar().ToString());
                            }

                            att.DimensionReferences = _dimensionReferences;
                        }
                    }
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return atts;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }
        /// <summary>
        /// Get_AttributesPartial
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>return list of attributes concept database form specific structure | NULL if error</returns>
        public static List<ConceptAttributeDB> Get_AttributesPartial(int idset)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    List<ConceptAttributeDB> conceptDbs = new List<ConceptAttributeDB>();
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_ATTRIBUTES";

                    System.Data.IDbDataParameter _idset = cmd.CreateParameter();
                    _idset.DbType = System.Data.DbType.Int32;
                    _idset.ParameterName = "IDSet";
                    _idset.Value = idset;
                    cmd.Parameters.Add(_idset);

                    System.Data.IDbDataParameter _twoLetterISO = cmd.CreateParameter();
                    _twoLetterISO.DbType = System.Data.DbType.String;
                    _twoLetterISO.ParameterName = "TwoLetterISO";
                    _twoLetterISO.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(_twoLetterISO);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();
                    while (_reader.Read())
                    {
                        ConceptAttributeDB conceptDb = new ConceptAttributeDB();
                        conceptDb.IDAtt = _reader.GetInt32(_reader.GetOrdinal("IDAtt"));
                        conceptDb.Code = _reader.GetString(_reader.GetOrdinal("Code"));
                        conceptDb.IDName = _reader.GetString(_reader.GetOrdinal("IDName"));
                        conceptDb.MemberTable = _reader.GetString(_reader.GetOrdinal("MemberTable"));
                        conceptDb.IsCodelist = _reader.GetBoolean(_reader.GetOrdinal("IsCodelist"));

                        conceptDbs.Add(conceptDb);
                    }
                    _reader.Close();

                    foreach (ConceptAttributeDB conceptDb in conceptDbs)
                    {

                        System.Data.IDbCommand cmd_count = dtw.DBConnection.CreateCommand();
                        cmd_count.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd_count.CommandText = "dbo.proc_GET_DIMENSIONS_REFERENCE";

                        System.Data.IDbDataParameter _count = cmd_count.CreateParameter();
                        _count.DbType = System.Data.DbType.Int32;
                        _count.Value = conceptDb.IDAtt;
                        _count.ParameterName = "IDAtt";
                        cmd_count.Parameters.Add(_count);


                        object result = cmd_count.ExecuteScalar();
                        if (result != null)
                        {
                            int count = int.Parse(result.ToString());
                            if (count == 1) conceptDb.IsObservationValue = true;
                        }
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return conceptDbs;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        /// <summary>
        /// Insert_Dimension 
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <param name="dimensions">List of dimension</param>
        /// <returns>return true if success | false if error</returns>
        public static bool Insert_Dimension(int idset, List<Dimension> dimensions)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    foreach (Dimension dimension in dimensions)
                    {

                        string codelist_name =
                            (dimension.Id != "TIME_PERIOD") ?
                            dimension.Codelist.Remove(0, 3) + "_" + dimension.CodelistAgency + "_" + dimension.CodelistVersion.Remove(dimension.CodelistVersion.IndexOf('.'), 1)
                            : dimension.Id;

                        System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.CommandText = "dbo.proc_INSERT_DIMENSION";

                        System.Data.IDbDataParameter _id_name = cmd.CreateParameter();
                        _id_name.DbType = System.Data.DbType.String;
                        _id_name.ParameterName = "IDName";
                        _id_name.Value = "ID" + dimension.Id;
                        cmd.Parameters.Add(_id_name);

                        System.Data.IDbDataParameter _id_set = cmd.CreateParameter();
                        _id_set.DbType = System.Data.DbType.Int32;
                        _id_set.ParameterName = "IDSet";
                        _id_set.Value = idset;
                        cmd.Parameters.Add(_id_set);

                        System.Data.IDbDataParameter _dim_code = cmd.CreateParameter();
                        _dim_code.DbType = System.Data.DbType.String;
                        _dim_code.ParameterName = "DimCode";
                        _dim_code.Value = dimension.Id;
                        cmd.Parameters.Add(_dim_code);

                        System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                        _member_table.DbType = System.Data.DbType.String;
                        _member_table.ParameterName = "MemberTable";
                        _member_table.Value = codelist_name;
                        cmd.Parameters.Add(_member_table);

                        System.Data.IDbDataParameter _isTimeSeriesDim = cmd.CreateParameter();
                        _isTimeSeriesDim.DbType = System.Data.DbType.Boolean;
                        _isTimeSeriesDim.ParameterName = "IsTimeSeriesDim";
                        _isTimeSeriesDim.Value = dimension.TimeDimension;
                        cmd.Parameters.Add(_isTimeSeriesDim);

                        int IDDim = (int)cmd.ExecuteScalar();

                        if (dimension.Id != "TIME_PERIOD")
                        {

                            System.Data.IDbCommand cmd_common = dtw.DBConnection.CreateCommand();
                            cmd_common.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd_common.CommandText = "dbo.proc_CREATE_COMMON_DIMENSION";

                            _member_table = cmd_common.CreateParameter();
                            _member_table.DbType = System.Data.DbType.String;
                            _member_table.ParameterName = "MemberTable";
                            _member_table.Value = codelist_name;
                            cmd_common.Parameters.Add(_member_table);

                            cmd_common.ExecuteNonQuery();
                        }
                        List<TextTypeWrapper> locations = new List<TextTypeWrapper>();
                        foreach (TextTypeWrapper location in dimension.Names)
                            locations.Add(new TextTypeWrapper(location.Locale.ToString(), location.Value.ToString()));
                        DataAccess.Insert_LocalisedString(locations, IDDim, "CatDim");

                    }
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;

                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Insert_Attribute
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <param name="attributes">List of attributes</param>
        /// <returns>return true if success | false if error</returns>
        public static bool Insert_Attribute(int idset, List<ISTAT.ENTITY.Attribute> attributes)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    foreach (ISTAT.ENTITY.Attribute attribute in attributes)
                    {


                        #region proc_INSERT_ATTRIBUTE Result in IDAtt

                        string codelist_name = (attribute.IsCodelist) ?
                            attribute.Codelist.Remove(0, 3) + "_" + attribute.CodelistAgency + "_" + attribute.CodelistVersion.Remove(attribute.CodelistVersion.IndexOf('.'), 1) :
                            attribute.ConceptRef + "_" + attribute.ConceptSchemeAgency + "_" + attribute.ConceptSchemeVersion.Remove(attribute.ConceptSchemeVersion.IndexOf('.'), 1);

                        System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.CommandText = "dbo.proc_INSERT_ATTRIBUTE";

                        System.Data.IDbDataParameter _id_name = cmd.CreateParameter();
                        _id_name.DbType = System.Data.DbType.String;
                        _id_name.ParameterName = "IDName";
                        _id_name.Value = "ID" + attribute.Id;
                        cmd.Parameters.Add(_id_name);

                        System.Data.IDbDataParameter _id_set = cmd.CreateParameter();
                        _id_set.DbType = System.Data.DbType.Int32;
                        _id_set.ParameterName = "IDSet";
                        _id_set.Value = idset;
                        cmd.Parameters.Add(_id_set);

                        System.Data.IDbDataParameter _dim_code = cmd.CreateParameter();
                        _dim_code.DbType = System.Data.DbType.String;
                        _dim_code.ParameterName = "AttCode";
                        _dim_code.Value = attribute.Id;
                        cmd.Parameters.Add(_dim_code);

                        System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                        _member_table.DbType = System.Data.DbType.String;
                        _member_table.ParameterName = "MemberTable";
                        _member_table.Value = codelist_name;
                        cmd.Parameters.Add(_member_table);

                        System.Data.IDbDataParameter _isMandatory = cmd.CreateParameter();
                        _isMandatory.DbType = System.Data.DbType.Boolean;
                        _isMandatory.ParameterName = "IsMandatory";
                        _isMandatory.Value = attribute.Mandatory;
                        cmd.Parameters.Add(_isMandatory);

                        System.Data.IDbDataParameter _isCodelist = cmd.CreateParameter();
                        _isCodelist.DbType = System.Data.DbType.Boolean;
                        _isCodelist.ParameterName = "IsCodelist";
                        _isCodelist.Value = attribute.IsCodelist;
                        cmd.Parameters.Add(_isCodelist);

                        int IDAtt = (int)cmd.ExecuteScalar();

                        System.Data.IDbCommand cmd_common = dtw.DBConnection.CreateCommand();
                        cmd_common.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd_common.CommandText = "dbo.proc_CREATE_COMMON_ATTRIBUTE";

                        _member_table = cmd_common.CreateParameter();
                        _member_table.DbType = System.Data.DbType.String;
                        _member_table.ParameterName = "MemberTable";
                        _member_table.Value = codelist_name;
                        cmd_common.Parameters.Add(_member_table);

                        cmd_common.ExecuteNonQuery();

                        #endregion

                        // Set location
                        List<TextTypeWrapper> locations = new List<TextTypeWrapper>();
                        foreach (TextTypeWrapper location in attribute.Names)
                            locations.Add(new TextTypeWrapper(location.Locale.ToString(), location.Value.ToString()));
                        DataAccess.Insert_LocalisedString(locations, IDAtt, "CatAtt");


                        System.Data.IDbCommand cmd_attach = dtw.DBConnection.CreateCommand();
                        cmd_attach.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd_attach.CommandText = "dbo.proc_SET_ATT_ATTACH";

                        System.Data.IDbDataParameter _idAtt = cmd_attach.CreateParameter();
                        _idAtt.DbType = System.Data.DbType.Int32;
                        _idAtt.ParameterName = "IDAtt";
                        _idAtt.Value = IDAtt;
                        cmd_attach.Parameters.Add(_idAtt);

                        System.Data.IDbDataParameter _idDim = cmd_attach.CreateParameter();
                        _idDim.DbType = System.Data.DbType.Int32;
                        _idDim.ParameterName = "IDDim";
                        cmd_attach.Parameters.Add(_idDim);


                        // Attachment level 

                        if (attribute.AttachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString())
                        {
                            // Specific attachment at level Dimension

                            List<int> _idDims = new List<int>();

                            #region proc_GET_DIMENSIONS
                            System.Data.IDbCommand cmd_dimensions = dtw.DBConnection.CreateCommand();
                            cmd_dimensions.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd_dimensions.CommandText = "dbo.proc_GET_DIMENSIONS";

                            System.Data.IDbDataParameter _idSet = cmd_dimensions.CreateParameter();
                            _idSet.DbType = System.Data.DbType.Int32;
                            _idSet.ParameterName = "IDSet";
                            _idSet.Value = idset;
                            cmd_dimensions.Parameters.Add(_idSet);
                            System.Data.IDataReader _reader = cmd_dimensions.ExecuteReader();

                            System.Data.IDbDataParameter _twoLetterISO = cmd_dimensions.CreateParameter();
                            _twoLetterISO.DbType = System.Data.DbType.String;
                            _twoLetterISO.ParameterName = "TwoLetterISO";
                            _twoLetterISO.Value = DataAccess.TwoLetterIso;
                            cmd_dimensions.Parameters.Add(_twoLetterISO);

                            while (_reader.Read())
                            {
                                string dimName = _reader.GetString(_reader.GetOrdinal("Code"));
                                if (attribute.DimensionReferences.Contains(dimName))
                                {
                                    _idDims.Add(_reader.GetInt32(_reader.GetOrdinal("IDDim")));
                                }
                            }
                            _reader.Close();

                            #endregion

                            foreach (int idDim in _idDims)
                            {
                                _idDim.Value = idDim;
                                cmd_attach.ExecuteNonQuery();
                            }
                        }
                        else if (attribute.AttachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DataSet.ToString())
                        {

                        }
                        else if (attribute.AttachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.Observation.ToString())
                        {
                            System.Data.IDbCommand cmd_dimension = dtw.DBConnection.CreateCommand();
                            cmd_dimension.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd_dimension.CommandText = "dbo.proc_GET_IDDIM";

                            System.Data.IDbDataParameter _idSet = cmd_dimension.CreateParameter();
                            _idSet.DbType = System.Data.DbType.Int32;
                            _idSet.ParameterName = "IDSet";
                            _idSet.Value = idset;
                            cmd_dimension.Parameters.Add(_idSet);

                            System.Data.IDbDataParameter _Code = cmd_dimension.CreateParameter();
                            _Code.DbType = System.Data.DbType.String;
                            _Code.ParameterName = "Code";
                            _Code.Value = "TIME_PERIOD";
                            cmd_dimension.Parameters.Add(_Code);


                            System.Data.IDataReader _reader = cmd_dimension.ExecuteReader();
                            int idDim = -1;
                            if (_reader.Read())
                            {
                                idDim = _reader.GetInt32(_reader.GetOrdinal("IDDim"));
                            }
                            _reader.Close();

                            if (idDim > 0)
                            {
                                _idDim.Value = idDim;
                                cmd_attach.ExecuteNonQuery();
                            }
                            else
                            {
                                return false;
                            }
                        }
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Insert_DimensionItems
        /// </summary>
        /// <param name="dimensions">list of dimensions</param>
        /// <returns></returns>
        public static bool Insert_DimensionItems(List<Dimension> dimensions)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_CODE";

                    System.Data.IDbDataParameter _codeType = cmd.CreateParameter();
                    _codeType.DbType = System.Data.DbType.String;
                    _codeType.Value = "Dim";
                    _codeType.ParameterName = "CodeType";
                    cmd.Parameters.Add(_codeType);

                    System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                    _member_table.DbType = System.Data.DbType.String;
                    _member_table.ParameterName = "MemberTable";
                    cmd.Parameters.Add(_member_table);

                    System.Data.IDbDataParameter _code = cmd.CreateParameter();
                    _code.DbType = System.Data.DbType.String;
                    _code.ParameterName = "Code";
                    cmd.Parameters.Add(_code);

                    System.Data.IDbDataParameter _baseCode = cmd.CreateParameter();
                    _baseCode.DbType = System.Data.DbType.String;
                    _baseCode.ParameterName = "BaseCode";
                    cmd.Parameters.Add(_baseCode);

                    System.Data.IDbDataParameter _order = cmd.CreateParameter();
                    _order.DbType = System.Data.DbType.Int32;
                    _order.ParameterName = "Order";
                    cmd.Parameters.Add(_order);

                    foreach (Dimension dimm in dimensions)
                        if (dimm.IsCodelist)
                            try
                            {

                                string codelist_name = dimm.Codelist.Remove(0, 3) + "_" + dimm.CodelistAgency + "_" + dimm.CodelistVersion.Remove(dimm.CodelistVersion.IndexOf('.'), 1);

                                foreach (Code code in dimm.Codes)
                                {
                                    _member_table.Value = codelist_name;
                                    _code.Value = code.Id;
                                    _baseCode.Value = (code.ParentCode != null) ? code.ParentCode : code.Id;
                                    _order.Value = 0;

                                    object str_idCode = cmd.ExecuteScalar();
                                    int idCode = -1;
                                    if (int.TryParse(str_idCode.ToString(), out idCode))
                                    {
                                        string memberTable = (_codeType.Value.ToString() + _member_table.Value.ToString()).ToString();
                                        DataAccess.Insert_LocalisedString((List<TextTypeWrapper>)code.Names, idCode, memberTable);
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                // skip if error for alrely exist code in Dim Table
                                Console.WriteLine(ex.Message);
                            }


                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Insert_AttributeItems
        /// </summary>
        /// <param name="attributes">List of attributes</param>
        /// <returns>true if success | false if error</returns>
        public static bool Insert_AttributeItems(List<ISTAT.ENTITY.Attribute> attributes)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_CODE";

                    System.Data.IDbDataParameter _codeType = cmd.CreateParameter();
                    _codeType.DbType = System.Data.DbType.String;
                    _codeType.Value = "Att";
                    _codeType.ParameterName = "CodeType";
                    cmd.Parameters.Add(_codeType);

                    System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                    _member_table.DbType = System.Data.DbType.String;
                    _member_table.ParameterName = "MemberTable";
                    cmd.Parameters.Add(_member_table);

                    System.Data.IDbDataParameter _code = cmd.CreateParameter();
                    _code.DbType = System.Data.DbType.String;
                    _code.ParameterName = "Code";
                    cmd.Parameters.Add(_code);

                    System.Data.IDbDataParameter _baseCode = cmd.CreateParameter();
                    _baseCode.DbType = System.Data.DbType.String;
                    _baseCode.ParameterName = "BaseCode";
                    cmd.Parameters.Add(_baseCode);

                    System.Data.IDbDataParameter _order = cmd.CreateParameter();
                    _order.DbType = System.Data.DbType.Int32;
                    _order.ParameterName = "Order";
                    cmd.Parameters.Add(_order);

                    foreach (ISTAT.ENTITY.Attribute att in attributes)
                        if (att.IsCodelist)
                            try
                            {
                                string codelist_name = att.Codelist.Remove(0, 3) + "_" + att.CodelistAgency + "_" + att.CodelistVersion.Remove(att.CodelistVersion.IndexOf('.'), 1); ;

                                foreach (Code code in att.Codes)
                                {

                                    _member_table.Value = codelist_name;
                                    _code.Value = code.Id;
                                    _baseCode.Value = (code.ParentCode != null) ? code.ParentCode : code.Id;
                                    _order.Value = 0;

                                    object str_idCode = cmd.ExecuteScalar();
                                    int idCode = -1;
                                    if (int.TryParse(str_idCode.ToString(), out idCode))
                                    {
                                        string memberTable = (_codeType.Value.ToString() + _member_table.Value.ToString()).ToString();
                                        DataAccess.Insert_LocalisedString((List<TextTypeWrapper>)code.Names, idCode, memberTable);
                                    }
                                }
                            }
                            catch
                            {
                                // skip if error for alrealy exist code in Dim Table
                            }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Insert_Code
        /// </summary>
        /// <param name="codeType">Prefix of table Att or Dim</param>
        /// <param name="memberTable">Table name</param>
        /// <param name="code">Code to insert</param>
        /// <param name="name">Text of code in en localised</param>
        /// <returns>Return id of new Code | -1 if error</returns>
        public static int Insert_Code(string codeType, string memberTable, string code, string name)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////


                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_CODE";

                    System.Data.IDbDataParameter _codeType = cmd.CreateParameter();
                    _codeType.DbType = System.Data.DbType.String;
                    _codeType.Value = string.Empty;
                    _codeType.ParameterName = "CodeType";
                    cmd.Parameters.Add(_codeType);

                    System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                    _member_table.DbType = System.Data.DbType.String;
                    _member_table.ParameterName = "MemberTable";
                    _member_table.Value = memberTable;
                    cmd.Parameters.Add(_member_table);

                    System.Data.IDbDataParameter _code = cmd.CreateParameter();
                    _code.DbType = System.Data.DbType.String;
                    _code.ParameterName = "Code";
                    _code.Value = code;
                    cmd.Parameters.Add(_code);

                    System.Data.IDbDataParameter _baseCode = cmd.CreateParameter();
                    _baseCode.DbType = System.Data.DbType.String;
                    _baseCode.ParameterName = "BaseCode";
                    _baseCode.Value = code;
                    cmd.Parameters.Add(_baseCode);

                    System.Data.IDbDataParameter _order = cmd.CreateParameter();
                    _order.DbType = System.Data.DbType.Int32;
                    _order.ParameterName = "Order";
                    _order.Value = 0;
                    cmd.Parameters.Add(_order);

                    object str_idCode = cmd.ExecuteScalar();
                    int idCode = -1;
                    if (int.TryParse(str_idCode.ToString(), out idCode))
                    {
                        string _memberTable = (_codeType.Value.ToString() + _member_table.Value.ToString()).ToString();
                        List<TextTypeWrapper> names = new List<TextTypeWrapper>();
                        names.Add(new TextTypeWrapper("en", name));
                        DataAccess.Insert_LocalisedString(names, idCode, _memberTable);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return idCode;
                }
                catch
                {

                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }
        /// <summary>
        /// Insert_DataFlow
        /// </summary>
        /// <param name="idDataFlow">ID of dataflow</param>
        /// <param name="idset">ID of Structure</param>
        /// <returns>Return true if success | false if error</returns>
        public static bool Insert_DataFlow(int idDataFlow, int idset, SDMXIdentifier sdmxKey)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_DATAFLOW";

                    System.Data.IDbDataParameter _idset = cmd.CreateParameter();
                    _idset.DbType = System.Data.DbType.Int32;
                    _idset.ParameterName = "IDSet";
                    _idset.Value = idset;
                    cmd.Parameters.Add(_idset);

                    System.Data.IDbDataParameter _idFlow = cmd.CreateParameter();
                    _idFlow.DbType = System.Data.DbType.Int32;
                    _idFlow.ParameterName = "IDFlow";
                    _idFlow.Value = idDataFlow;
                    cmd.Parameters.Add(_idFlow);

                    System.Data.IDbDataParameter _agencyID = cmd.CreateParameter();
                    _agencyID.DbType = System.Data.DbType.String;
                    _agencyID.ParameterName = "AgencyID";
                    _agencyID.Value = sdmxKey.agencyid;
                    cmd.Parameters.Add(_agencyID);

                    System.Data.IDbDataParameter _id = cmd.CreateParameter();
                    _id.DbType = System.Data.DbType.String;
                    _id.ParameterName = "ID";
                    _id.Value = sdmxKey.id;
                    cmd.Parameters.Add(_id);

                    System.Data.IDbDataParameter _version = cmd.CreateParameter();
                    _version.DbType = System.Data.DbType.String;
                    _version.ParameterName = "Version";
                    _version.Value = sdmxKey.version;
                    cmd.Parameters.Add(_version);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch// (Exception ex)
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Create_FactTable
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>Return true if success | false if error</returns>
        public static bool Create_FactTable(int idset)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_CREATE_FACT_TABLE";

                    System.Data.IDbDataParameter _member_table = cmd.CreateParameter();
                    _member_table.DbType = System.Data.DbType.Int32;
                    _member_table.ParameterName = "IDSet";
                    _member_table.Value = idset;
                    cmd.Parameters.Add(_member_table);
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "dbo.proc_CREATE_FILT_TABLE";
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "dbo.proc_CREATE_CUBE_VIEW_AllData";
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = "dbo.proc_CREATE_CUBE_VIEW_ViewAllSeries";
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = "dbo.proc_CREATE_CUBE_VIEW_DataFactS";
                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Get_Codelist
        /// </summary>
        /// <param name="code">Code of codelist</param>
        /// <param name="isDimensionCode">true if is code of dimension or false if is attribute</param>
        /// <returns>Return list of codelist items | null if error</returns>
        public static List<Code> Get_Codelist(string code, bool isDimensionCode = true)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    string memberTable = string.Empty;

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    if (isDimensionCode)
                    {
                        cmd.CommandText = "dbo.proc_GET_CODES_DIMENSION";
                        memberTable = "Dim";
                    }
                    else
                    {
                        cmd.CommandText = "dbo.proc_GET_CODES_ATTRIBUTE";
                        memberTable = "Att";
                    }

                    System.Data.IDbDataParameter _param_code = cmd.CreateParameter();
                    _param_code.DbType = System.Data.DbType.String;
                    _param_code.ParameterName = "Code";
                    _param_code.Value = code;
                    cmd.Parameters.Add(_param_code);
                    System.Data.IDbDataParameter _param_twoLeter = cmd.CreateParameter();
                    _param_twoLeter.DbType = System.Data.DbType.String;
                    _param_twoLeter.ParameterName = "TwoLetterISO";
                    _param_twoLeter.Value = DataAccess.TwoLetterIso;
                    cmd.Parameters.Add(_param_twoLeter);
                    System.Data.IDataReader _reader = cmd.ExecuteReader();

                    List<Code> _codes = new List<Code>();

                    while (_reader.Read())
                    {
                        Code _code = new Code();
                        _code.Id = _reader.GetString(_reader.GetOrdinal("Code"));
                        _code.ParentCode = _reader.GetString(_reader.GetOrdinal("BaseCode"));

                        _code.Names = new List<TextTypeWrapper>();
                        TextTypeWrapper name = new TextTypeWrapper(DataAccess.TwoLetterIso, _reader.GetString(_reader.GetOrdinal("Value")));
                        _code.Names.Add(name);

                        _codes.Add(_code);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return _codes;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        /// <summary>
        /// Delete_Datastructure
        /// </summary>
        /// <param name="idset">Id of Structure</param>
        /// <returns>Return true if success | false if error</returns>
        public static bool Delete_Datastructure(int idset)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_DELETE_CUBE";
                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {

                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Create_Mapping
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <param name="iduser">ID of User</param>
        /// <param name="name">String name of mapping</param>
        /// <param name="items">List of coppie</param>
        /// <returns>Return id of new Mapping | -1 if error</returns>
        public static int Create_Mapping(
            int idset,
            int iduser,
            string name,
            string desc,
            Dictionary<string, Dictionary<string, object>> items,
            string csv_char,
            bool csv_header,
            bool trans_use,
            string trans_char,
            int trans_period)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                int idSchema = -1;

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_MAPPING";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDbDataParameter _param_iduser = cmd.CreateParameter();
                    _param_iduser.DbType = System.Data.DbType.Int32;
                    _param_iduser.ParameterName = "IDUser";
                    _param_iduser.Value = iduser;
                    cmd.Parameters.Add(_param_iduser);

                    System.Data.IDbDataParameter _param_name = cmd.CreateParameter();
                    _param_name.DbType = System.Data.DbType.String;
                    _param_name.ParameterName = "Name";
                    _param_name.Value = name;
                    cmd.Parameters.Add(_param_name);

                    System.Data.IDbDataParameter _param_desc = cmd.CreateParameter();
                    _param_desc.DbType = System.Data.DbType.String;
                    _param_desc.ParameterName = "Description";
                    _param_desc.Value = desc;
                    cmd.Parameters.Add(_param_desc);

                    System.Data.IDbDataParameter _param_csv_char = cmd.CreateParameter();
                    _param_csv_char.DbType = System.Data.DbType.String;
                    _param_csv_char.ParameterName = "file_csv_char";
                    _param_csv_char.Value = csv_char;
                    cmd.Parameters.Add(_param_csv_char);

                    System.Data.IDbDataParameter _param_csv_hasheader = cmd.CreateParameter();
                    _param_csv_hasheader.DbType = System.Data.DbType.Boolean;
                    _param_csv_hasheader.ParameterName = "file_csv_hasheader";
                    _param_csv_hasheader.Value = csv_header;
                    cmd.Parameters.Add(_param_csv_hasheader);

                    System.Data.IDbDataParameter _param_transcode_use = cmd.CreateParameter();
                    _param_transcode_use.DbType = System.Data.DbType.Boolean;
                    _param_transcode_use.ParameterName = "transcode_use";
                    _param_transcode_use.Value = trans_use;
                    cmd.Parameters.Add(_param_transcode_use);


                    System.Data.IDbDataParameter _param_transcode_char = cmd.CreateParameter();
                    _param_transcode_char.DbType = System.Data.DbType.String;
                    _param_transcode_char.ParameterName = "transcode_char";
                    _param_transcode_char.Value = trans_char;
                    cmd.Parameters.Add(_param_transcode_char);

                    System.Data.IDbDataParameter _param_transcode_value = cmd.CreateParameter();
                    _param_transcode_value.DbType = System.Data.DbType.String;
                    _param_transcode_value.ParameterName = "transcode_value";
                    _param_transcode_value.Value = trans_period;
                    cmd.Parameters.Add(_param_transcode_value);

                    object _return = cmd.ExecuteScalar();
                    idSchema = int.Parse(_return.ToString());
                    if (idSchema > 0)
                    {
                        System.Data.IDbCommand cmd_data = dtw.DBConnection.CreateCommand();
                        cmd_data.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd_data.CommandText = "dbo.proc_INSERT_DATA_MAPPING";

                        System.Data.IDbDataParameter _param_idSchema = cmd_data.CreateParameter();
                        _param_idSchema.DbType = System.Data.DbType.Int32;
                        _param_idSchema.ParameterName = "IDSchema";
                        _param_idSchema.Value = idSchema;
                        cmd_data.Parameters.Add(_param_idSchema);

                        System.Data.IDbDataParameter _param_idColumn = cmd_data.CreateParameter();
                        _param_idColumn.DbType = System.Data.DbType.Int32;
                        _param_idColumn.ParameterName = "IDColumn";
                        cmd_data.Parameters.Add(_param_idColumn);

                        System.Data.IDbDataParameter _param_name_column = cmd_data.CreateParameter();
                        _param_name_column.DbType = System.Data.DbType.String;
                        _param_name_column.ParameterName = "NameColumn";
                        cmd_data.Parameters.Add(_param_name_column);

                        System.Data.IDbDataParameter _param_name_map = cmd_data.CreateParameter();
                        _param_name_map.DbType = System.Data.DbType.String;
                        _param_name_map.ParameterName = "Name";
                        cmd_data.Parameters.Add(_param_name_map);

                        foreach (string key in items.Keys)
                        {

                            Dictionary<string, object> c = items[key];
                            _param_idColumn.Value = key;
                            _param_name_column.Value = c.Values.First();
                            _param_name_map.Value = c.Keys.First();

                            cmd_data.ExecuteNonQuery();

                        }
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return (int)idSchema;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    Delete_Mapping(idSchema);
                    return -1;
                }
            } return -1;
        }
        /// <summary>
        /// Delete_Mapping
        /// </summary>
        /// <param name="idschema">ID of mapping</param>
        /// <returns>Return true if success | false if error</returns>
        public static bool Delete_Mapping(int idschema)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_DELETE_MAPPING";

                    System.Data.IDbDataParameter _param_idschema = cmd.CreateParameter();
                    _param_idschema.DbType = System.Data.DbType.Int32;
                    _param_idschema.ParameterName = "IDSchema";
                    _param_idschema.Value = idschema;
                    cmd.Parameters.Add(_param_idschema);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {

                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }
        /// <summary>
        /// Get_Mapping
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <returns>Return all mapping avaible for dataset | null if error</returns>
        public static Dictionary<string, int> Get_Mapping(int idset)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    Dictionary<string, object> _items = new Dictionary<string, object>();

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_MAPPING";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();
                    int id = -1;
                    string name = string.Empty;

                    Dictionary<string, int> _dict = new Dictionary<string, int>();

                    while (_reader.Read())
                    {
                        name = _reader.GetString(_reader.GetOrdinal("NAME"));
                        id = (int)_reader.GetInt64(_reader.GetOrdinal("ID_SCHEMA"));
                        _dict.Add(name, id);
                    }
                    _reader.Close();
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return _dict;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        // return info of single mapping 
        public static Dictionary<string, object> Get_MappingSet(int idScheme)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    Dictionary<string, object> _items = new Dictionary<string, object>();

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_MAPPING_SCHEME";

                    System.Data.IDbDataParameter _param_idScheme = cmd.CreateParameter();
                    _param_idScheme.DbType = System.Data.DbType.Int32;
                    _param_idScheme.ParameterName = "IDMappingScheme";
                    _param_idScheme.Value = idScheme;
                    cmd.Parameters.Add(_param_idScheme);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();


                    Dictionary<string, object> _dict = new Dictionary<string, object>();
                    if (_reader.Read())
                    {
                        _dict.Add("ID_SET", (int)_reader.GetInt64(_reader.GetOrdinal("ID_SET")));
                        _dict.Add("ID_SCHEMA", (int)_reader.GetInt64(_reader.GetOrdinal("ID_SCHEMA")));
                        _dict.Add("NAME", _reader.GetString(_reader.GetOrdinal("NAME")));
                        _dict.Add("DESCRIPTION", _reader.GetString(_reader.GetOrdinal("DESCRIPTION")));
                        _dict.Add("TIMESTAMP", _reader.GetDateTime(_reader.GetOrdinal("TIMESTAMP")));
                        _dict.Add("FILE_CSV_CHAR", _reader.GetString(_reader.GetOrdinal("FILE_CSV_CHAR")));
                        _dict.Add("FILE_CSV_HASHEADER", _reader.GetBoolean(_reader.GetOrdinal("FILE_CSV_HASHEADER")));
                        _dict.Add("TRANSCODE_USE", _reader.GetBoolean(_reader.GetOrdinal("TRANSCODE_USE")));
                        _dict.Add("TRANSCODE_CHAR", (_reader.IsDBNull(_reader.GetOrdinal("TRANSCODE_CHAR"))) ? string.Empty : _reader.GetString(_reader.GetOrdinal("TRANSCODE_CHAR")));
                        _dict.Add("TRANSCODE_VALUE", (_reader.IsDBNull(_reader.GetOrdinal("TRANSCODE_VALUE"))) ? 0 : _reader.GetInt32(_reader.GetOrdinal("TRANSCODE_VALUE")));

                    }
                    _reader.Close();
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return _dict;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        // return list of mapping avvaible for user
        public static List<Dictionary<string, object>> Get_Mappings(int iduser)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    Dictionary<string, object> _items = new Dictionary<string, object>();

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_MAPPINGS";

                    System.Data.IDbDataParameter _param_iduser = cmd.CreateParameter();
                    _param_iduser.DbType = System.Data.DbType.Int32;
                    _param_iduser.ParameterName = "IDUser";
                    _param_iduser.Value = iduser;
                    cmd.Parameters.Add(_param_iduser);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();

                    List<Dictionary<string, object>> _maps = new List<Dictionary<string, object>>();

                    while (_reader.Read())
                    {
                        Dictionary<string, object> _dict = new Dictionary<string, object>();
                        _dict.Add("ID_SCHEMA", (int)_reader.GetInt64(_reader.GetOrdinal("ID_SCHEMA")));
                        _dict.Add("NAME", _reader.GetString(_reader.GetOrdinal("NAME")));
                        _maps.Add(_dict);
                    }
                    _reader.Close();
                    ////////////////////////

                    dtw.DBConnection.Close();
                    return _maps;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }
        /// <summary>
        /// Get_MappingScheme
        /// </summary>
        /// <param name="idscheme">ID of mapping</param>
        /// <returns>Return items list of couple mapping | NULL is error </returns>
        public static Dictionary<string, object> Get_MappingScheme(int idScheme)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    Dictionary<string, object> _dict = new Dictionary<string, object>();

                    System.Data.IDbCommand cmd_columns = dtw.DBConnection.CreateCommand();
                    cmd_columns.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_columns.CommandText = "dbo.proc_GET_MAPPING_COLUMNS";

                    System.Data.IDbDataParameter _param_idschema = cmd_columns.CreateParameter();
                    _param_idschema.DbType = System.Data.DbType.Int32;
                    _param_idschema.ParameterName = "IDSchema";
                    _param_idschema.Value = idScheme;
                    cmd_columns.Parameters.Add(_param_idschema);

                    System.Data.IDataReader _reader = cmd_columns.ExecuteReader();

                    while (_reader.Read())
                    {
                        Dictionary<int, string> couple = new Dictionary<int, string>();
                        couple.Add(_reader.GetInt32(_reader.GetOrdinal("ID_COLUMN")), _reader.GetString(_reader.GetOrdinal("NAME_COLUMN")));
                        _dict.Add(_reader.GetString(_reader.GetOrdinal("NAME")), couple);
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return _dict;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }

        /// <summary>
        /// Get_TrancodeTime
        /// </summary>
        /// <param name="idscheme">ID of mapping</param>
        /// <returns>transcode Time</returns>
        public static TranscodeTime Get_TranscodeTime(int idscheme)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd_columns = dtw.DBConnection.CreateCommand();
                    cmd_columns.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_columns.CommandText = "dbo.proc_GET_TRANSCODETIME";

                    System.Data.IDbDataParameter _param_idschema = cmd_columns.CreateParameter();
                    _param_idschema.DbType = System.Data.DbType.Int32;
                    _param_idschema.ParameterName = "IDSchema";
                    _param_idschema.Value = idscheme;
                    cmd_columns.Parameters.Add(_param_idschema);

                    System.Data.IDbDataParameter _param_char = cmd_columns.CreateParameter();
                    _param_char.DbType = System.Data.DbType.String;
                    _param_char.ParameterName = "TransChar";
                    _param_char.Size = 1;
                    _param_char.Direction = ParameterDirection.Output;
                    cmd_columns.Parameters.Add(_param_char);

                    System.Data.IDbDataParameter _param_value = cmd_columns.CreateParameter();
                    _param_value.DbType = System.Data.DbType.Int32;
                    _param_value.ParameterName = "TransValue";
                    _param_value.Direction = ParameterDirection.Output;
                    cmd_columns.Parameters.Add(_param_value);

                    cmd_columns.ExecuteNonQuery();
                    TranscodeTime transcodeTime = new TranscodeTime();
                    transcodeTime.stopChar = _param_char.Value.ToString();
                    transcodeTime.periodChar = (TranscodeTime.TypePeriod)int.Parse(_param_value.Value.ToString());

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return transcodeTime;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;
        }

        public static bool Update_TranscodeTime(int idscheme, string target_char, int value)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////


                    System.Data.IDbCommand cmd_columns = dtw.DBConnection.CreateCommand();
                    cmd_columns.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_columns.CommandText = "dbo.proc_SET_TRANSCODETIME";

                    System.Data.IDbDataParameter _param_idschema = cmd_columns.CreateParameter();
                    _param_idschema.DbType = System.Data.DbType.Int32;
                    _param_idschema.ParameterName = "IDSchema";
                    _param_idschema.Value = idscheme;
                    cmd_columns.Parameters.Add(_param_idschema);

                    System.Data.IDbDataParameter _param_char = cmd_columns.CreateParameter();
                    _param_char.DbType = System.Data.DbType.String;
                    _param_char.ParameterName = "TransChar";
                    _param_char.Value = target_char;
                    cmd_columns.Parameters.Add(_param_char);

                    System.Data.IDbDataParameter _param_value = cmd_columns.CreateParameter();
                    _param_value.DbType = System.Data.DbType.Int32;
                    _param_value.ParameterName = "TransValue";
                    _param_value.Value = value;
                    cmd_columns.Parameters.Add(_param_value);

                    cmd_columns.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }

        public static List<TimePeriod> Get_TimePeriod()
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    List<TimePeriod> period = new List<TimePeriod>();
                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_TIME_PERIOD";


                    System.Data.IDataReader _reader = cmd.ExecuteReader();

                    while (_reader.Read())
                        period.Add(new TimePeriod(_reader.GetInt32(_reader.GetOrdinal("ID")), _reader.GetString(_reader.GetOrdinal("CODE"))));



                    ////////////////////////

                    dtw.DBConnection.Close();
                    return period;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        /// <summary>
        /// Insert_Data
        /// </summary>
        /// <param name="idset">ID of Structure </param>
        /// <param name="view">Matrix like view of CUBE</param>
        /// <returns></returns>
        /// 
        public static QueryReport Insert_Data(int idset, Dictionary<string, List<string>> view)
        {
            QueryReport _report = new QueryReport();
            _report.StartReport();

            string min_time = string.Empty;
            string max_time = string.Empty;

            try
            {

                #region INIT VARIABLE

                QueryPart fi_dim_qp = new QueryPart();
                QueryPart fi_att_qp = new QueryPart();
                QueryPart fa_att_qp = new QueryPart();

                List<ConceptDimensionDB> lstDim = DataAccess.Get_DimensionsPartial(idset);
                List<ConceptAttributeDB> lstAtt = DataAccess.Get_AttributesPartial(idset);

                int SID = -1;
                int itemCount = ((List<string>)view[view.Keys.First<string>()]).Count;


                _report.RecordTargetCount = itemCount;

                #endregion

                #region LOAD TABLE TIME PERIOD

                // Chache of TIME_PERIOD db table
                List<TimePeriod> time_period = DataAccess.Get_TimePeriod();

                #endregion


                for (int i = 0; i < itemCount; i++)
                {
                    bool hasError = false;

                    QueryPart cur_fi_dim_qp = new QueryPart();
                    QueryPart cur_fi_att_qp = new QueryPart();
                    QueryPart cur_fa_att_qp = new QueryPart();

                    #region GET DIMENSIONS PART
                    foreach (ConceptDimensionDB conc in lstDim)
                    {
                        // se la dimensione non e' una timedimension 
                        if (!conc.IsTimeSeriesDim)
                        {
                            cur_fi_dim_qp[conc.Code] = new QueryCouple(conc.MemberTable, view[conc.Code][i]);
                        }
                    }
                    #endregion

                    #region GET ATTRIBUTES PART

                    foreach (ConceptAttributeDB conc in lstAtt)
                    {
                        if (view.ContainsKey(conc.Code))
                        {
                            if (conc.IsObservationValue)
                            {
                                cur_fa_att_qp[conc.Code] = new QueryCouple(conc.MemberTable, view[conc.Code][i]);
                            }
                            else
                            {
                                cur_fi_att_qp[conc.Code] = new QueryCouple(conc.MemberTable, view[conc.Code][i]);
                            }
                        }
                    }

                    #endregion

                    if (!hasError)
                    {

                        #region GET FILTS SID KEY

                        if (cur_fi_dim_qp.KEY_RECORD != fi_dim_qp.KEY_RECORD)
                        {
                            // Select SID from view
                            SID = DataAccess.Get_SIDToFilts(idset, cur_fi_dim_qp);
                            _report.QueryExecCount++;

                            // if no Serie found
                            if (SID < 0)
                            {

                                #region RESOLVE FILTS KEY

                                foreach (string dimStr in cur_fi_dim_qp.FIELDS.Keys)
                                {
                                    // risolvo il codice della dimensione ed ottengo l'id nel database
                                    cur_fi_dim_qp[dimStr].VALUE = DataAccess.Get_IDCode(cur_fi_dim_qp[dimStr].MEMBER, cur_fi_dim_qp[dimStr].CODE);
                                    _report.QueryExecCount++;
                                    if ((int)cur_fi_dim_qp[dimStr].VALUE < 0)
                                    {
                                        // codice non rivolvibile
                                        _report.Errors.Add(string.Format("Unable to resolve {0} in row [{1}]", dimStr, i));
                                        hasError = true;
                                        break;
                                    }

                                    fi_dim_qp = cur_fi_dim_qp;
                                }

                                #endregion

                                if (!hasError)
                                {

                                    #region Attribute FILTS Query Part

                                    if (cur_fi_att_qp.KEY_RECORD != fi_att_qp.KEY_RECORD)
                                    {
                                        foreach (string attStr in cur_fi_att_qp.FIELDS.Keys)
                                        {
                                            cur_fi_att_qp[attStr].VALUE = DataAccess.Get_IDCode(cur_fi_att_qp[attStr].MEMBER, cur_fi_att_qp[attStr].CODE);
                                            _report.QueryExecCount++;
                                            if ((int)cur_fi_att_qp[attStr].VALUE < 0)
                                            {
                                                var isCodeRappresentation = (from c in lstAtt where c.MemberTable == cur_fi_att_qp[attStr].MEMBER select c.IsCodelist).OfType<bool>().First();

                                                if (!isCodeRappresentation)
                                                    cur_fi_att_qp[attStr].VALUE = DataAccess.Insert_Code("Att", cur_fi_att_qp[attStr].MEMBER, cur_fi_att_qp[attStr].CODE, string.Empty);

                                                if ((int)cur_fi_att_qp[attStr].VALUE < 0) cur_fi_att_qp[attStr].VALUE = null;

                                                /*
                                                if ((int)cur_fi_att_qp[attStr].VALUE < 0)
                                                {
                                                    // codice non rivolvibile
                                                    hasError = true;
                                                    _report.Errors.Add(string.Format("Unable to resolve {0} in row [{1}]", attStr, i));
                                                    break;
                                                }
                                                */
                                            }

                                        }
                                        fi_att_qp = cur_fi_att_qp;
                                    }
                                    #endregion

                                    //Insert new series in FILTS
                                    SID = DataAccess.Insert_DataFilts(idset,
                                            fi_dim_qp.SELECT_PART + ((fi_att_qp.SELECT_PART != string.Empty) ? " , " + fi_att_qp.SELECT_PART : string.Empty),
                                            fi_dim_qp.INSERT_PART_VALUE + ((fi_att_qp.INSERT_PART_VALUE != string.Empty) ? "," + fi_att_qp.INSERT_PART_VALUE : string.Empty),
                                            fi_dim_qp.WHERE_PART_VALUE);
                                    _report.QueryExecCount++;
                                }
                                else
                                {
                                    // Serie non trovata

                                }
                            }
                            fi_dim_qp = cur_fi_dim_qp;
                        }
                        #endregion

                        if (!hasError)
                        {
                            #region Attribute FACTS Query Part
                            if (cur_fa_att_qp.KEY_RECORD != fa_att_qp.KEY_RECORD)
                            {
                                foreach (string attStr in cur_fa_att_qp.FIELDS.Keys)
                                {
                                    cur_fa_att_qp[attStr].VALUE = DataAccess.Get_IDCode(cur_fa_att_qp[attStr].MEMBER, cur_fa_att_qp[attStr].CODE);
                                    _report.QueryExecCount++;
                                    if ((int)cur_fa_att_qp[attStr].VALUE < 0)
                                    {

                                        var isCodeRappresentation = (from c in lstAtt where c.MemberTable == cur_fa_att_qp[attStr].MEMBER select c.IsCodelist).OfType<bool>().First();

                                        if (!isCodeRappresentation)
                                            cur_fa_att_qp[attStr].VALUE = DataAccess.Insert_Code("Att", cur_fa_att_qp[attStr].MEMBER, cur_fa_att_qp[attStr].CODE, string.Empty);

                                        if ((int)cur_fa_att_qp[attStr].VALUE < 0) cur_fa_att_qp[attStr].VALUE = null;

                                        // codice non rivolvibile
                                        /*
                                        if ((int)cur_fa_att_qp[attStr].VALUE < 0)
                                        {
                                            _report.Errors.Add(string.Format("Unable to resolve {0} in row [{1}]", attStr, i));
                                            hasError = true;
                                            break;
                                        }
                                        */
                                    }
                                }
                                fa_att_qp = cur_fa_att_qp;
                            }
                            #endregion
                        }

                        if (!hasError)
                        {
                            if (SID > -1)
                            {

                                #region INSERT INTO FactS

                                int idtime = -1;

                                string tPeriod = view["TIME_PERIOD"][i];

                                try
                                {
                                    idtime = (from period in time_period where period.CODE == tPeriod select period.ID).First();
                                }
                                catch
                                {
                                    idtime = -1;
                                }

                                if (idtime >= 0)
                                {
                                    // Converto value per inserimento in db Sql
                                    object value = (view["OBS_VALUE"][i] == string.Empty || view["OBS_VALUE"][i] == "NaN") ? null : view["OBS_VALUE"][i].Replace('.', ',');
                                    //DataAccess.Delete_DataFacts(idset, SID, idtime);
                                    int _res = DataAccess.Insert_DataFacts(idset, SID, idtime, value, fa_att_qp.SELECT_PART, fa_att_qp.INSERT_PART_VALUE);
                                    _report.QueryExecCount++;


                                    // Get Min - Max Time 

                                    min_time = TranscodeTime.CompareMin(min_time, tPeriod);
                                    max_time = TranscodeTime.CompareMax(max_time, tPeriod);


                                    switch (_res)
                                    {
                                        case 0: _report.RecordCount++; break;
                                        case 2: _report.RecordOverrideCount++; break;
                                        case 1: _report.RecordIgnoreCount++; break;
                                        case -1: _report.Errors.Add("Insert fail on Record [" + i + "]"); break;
                                    }
                                }
                                else
                                {
                                    _report.Errors.Add(string.Format("Unable to resolve TIME_PERIOD : {0} in row [{1}]", tPeriod, i));
                                    hasError = true;
                                }


                                #endregion

                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
            finally
            {
                _report.StopReport();

                _report.MaxTime = max_time;
                _report.MinTime = min_time;
            }

            return _report;
        }

        public static bool Insert_Load(int idset, int idflow, string min_time, string max_time, Int64 count, string filename)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {

                dtw.DBConnection.Open();
                try
                {

                    ////////////////////////


                    System.Data.IDbCommand cmd_load = dtw.DBConnection.CreateCommand();
                    cmd_load.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_load.CommandText = "dbo.proc_INSERT_LOAD";

                    System.Data.IDbDataParameter _p_idset = cmd_load.CreateParameter();
                    _p_idset.DbType = System.Data.DbType.Int32;
                    _p_idset.ParameterName = "IDSet";
                    _p_idset.Value = idset;
                    cmd_load.Parameters.Add(_p_idset);

                    System.Data.IDbDataParameter _p_idflow = cmd_load.CreateParameter();
                    _p_idflow.DbType = System.Data.DbType.Int32;
                    _p_idflow.ParameterName = "IDFlow";
                    _p_idflow.Value = idflow;
                    cmd_load.Parameters.Add(_p_idflow);

                    System.Data.IDbDataParameter _p_min_time = cmd_load.CreateParameter();
                    _p_min_time.DbType = System.Data.DbType.String;
                    _p_min_time.ParameterName = "MIN_TIME";
                    _p_min_time.Value = min_time;
                    cmd_load.Parameters.Add(_p_min_time);

                    System.Data.IDbDataParameter _p_max_time = cmd_load.CreateParameter();
                    _p_max_time.DbType = System.Data.DbType.String;
                    _p_max_time.ParameterName = "MAX_TIME";
                    _p_max_time.Value = max_time;
                    cmd_load.Parameters.Add(_p_max_time);

                    System.Data.IDbDataParameter _p_count = cmd_load.CreateParameter();
                    _p_count.DbType = System.Data.DbType.Int64;
                    _p_count.ParameterName = "RECORD_COUNT";
                    _p_count.Value = count;
                    cmd_load.Parameters.Add(_p_count);

                    System.Data.IDbDataParameter _p_file = cmd_load.CreateParameter();
                    _p_file.DbType = System.Data.DbType.String;
                    _p_file.ParameterName = "FILENAME";
                    _p_file.Value = filename;
                    cmd_load.Parameters.Add(_p_file);

                    cmd_load.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }





        private static int Insert_DataFilts(int idset, string sql_h, string sql_d, string sql_w)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    int id = -1;

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_DATA_FILTS";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDbDataParameter _param_sql_h = cmd.CreateParameter();
                    _param_sql_h.DbType = System.Data.DbType.String;
                    _param_sql_h.ParameterName = "Sql_part_h";
                    _param_sql_h.Value = sql_h;
                    cmd.Parameters.Add(_param_sql_h);

                    System.Data.IDbDataParameter _param_sql_d = cmd.CreateParameter();
                    _param_sql_d.DbType = System.Data.DbType.String;
                    _param_sql_d.ParameterName = "Sql_part_d";
                    _param_sql_d.Value = sql_d;
                    cmd.Parameters.Add(_param_sql_d);

                    System.Data.IDbDataParameter _param_sql_w = cmd.CreateParameter();
                    _param_sql_w.DbType = System.Data.DbType.String;
                    _param_sql_w.ParameterName = "Sql_part_w";
                    _param_sql_w.Value = sql_w;
                    cmd.Parameters.Add(_param_sql_w);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                        id = int.Parse(result.ToString());

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return id;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            }

            return -1;
        }
        /// <summary>
        /// Insert_DataFacts
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <param name="sid">SID from Filt table</param>
        /// <param name="idtime">ID Time period</param>
        /// <param name="value">Value in float can be NULL</param>
        /// <param name="sql_h">string SQL part esp: tablename1,tablename2,tablename3</param>
        /// <param name="sql_d">string SQL part esp: value1,value2,value3</param>
        /// <returns>Return new ID of Fact | -1 if error </returns>
        private static int Insert_DataFacts(int idset, int sid, int idtime, object value, string sql_h, string sql_d)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    ////////////////////////

                    int id = -1;

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_INSERT_DATA_FACTS";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDbDataParameter _param_sid = cmd.CreateParameter();
                    _param_sid.DbType = System.Data.DbType.Int32;
                    _param_sid.ParameterName = "SID";
                    _param_sid.Value = sid;
                    cmd.Parameters.Add(_param_sid);

                    System.Data.IDbDataParameter _param_time = cmd.CreateParameter();
                    _param_time.DbType = System.Data.DbType.Int32;
                    _param_time.ParameterName = "IDTime";
                    _param_time.Value = idtime;
                    cmd.Parameters.Add(_param_time);
                    if (value != null)
                    {
                        System.Data.IDbDataParameter _param_value = cmd.CreateParameter();
                        _param_value.DbType = System.Data.DbType.Double;
                        _param_value.ParameterName = "Value";
                        _param_value.Value = value;
                        cmd.Parameters.Add(_param_value);
                    }
                    System.Data.IDbDataParameter _param_sql_h = cmd.CreateParameter();
                    _param_sql_h.DbType = System.Data.DbType.String;
                    _param_sql_h.ParameterName = "Sql_part_h";
                    _param_sql_h.Value = sql_h;
                    cmd.Parameters.Add(_param_sql_h);

                    System.Data.IDbDataParameter _param_sql_d = cmd.CreateParameter();
                    _param_sql_d.DbType = System.Data.DbType.String;
                    _param_sql_d.ParameterName = "Sql_part_d";
                    _param_sql_d.Value = sql_d;
                    cmd.Parameters.Add(_param_sql_d);


                    id = (int)cmd.ExecuteScalar();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return id;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            }

            return -1;
        }
        /// <summary>
        /// Delete_DataFacts
        /// </summary>
        /// <param name="idset">ID of Structure</param>
        /// <param name="sid">SID of Facts</param>
        /// <param name="idtime">ID Time period of Fact</param>
        /// <returns>Return true if success | false if error</returns>
        private static bool Delete_DataFacts(int idset, int sid, int idtime)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_DELETE_DATA_FACTS";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDbDataParameter _param_Sid = cmd.CreateParameter();
                    _param_Sid.DbType = System.Data.DbType.Int32;
                    _param_Sid.ParameterName = "SID";
                    _param_Sid.Value = sid;
                    cmd.Parameters.Add(_param_Sid);

                    System.Data.IDbDataParameter _param_time = cmd.CreateParameter();
                    _param_time.DbType = System.Data.DbType.Int32;
                    _param_time.ParameterName = "IDTime";
                    _param_time.Value = idtime;
                    cmd.Parameters.Add(_param_time);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return true;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return false;
                }
            } return false;
        }

        private static int Get_SIDToFilts(int idset, QueryPart query)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {
                    int SID = -1;
                    //////////////////////// 

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.proc_GET_SID_VIEW_FILTS";

                    System.Data.IDbDataParameter _param_idset = cmd.CreateParameter();
                    _param_idset.DbType = System.Data.DbType.Int32;
                    _param_idset.ParameterName = "IDSet";
                    _param_idset.Value = idset;
                    cmd.Parameters.Add(_param_idset);

                    System.Data.IDbDataParameter _param_where = cmd.CreateParameter();
                    _param_where.DbType = System.Data.DbType.String;
                    _param_where.ParameterName = "Sql_Where";
                    _param_where.Value = query.WHERE_PART_CODE;
                    cmd.Parameters.Add(_param_where);

                    System.Data.IDbDataParameter _param_sid = cmd.CreateParameter();
                    _param_sid.DbType = System.Data.DbType.Int32;
                    _param_sid.ParameterName = "SID";
                    _param_sid.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(_param_sid);

                    cmd.ExecuteNonQuery();

                    SID = (_param_sid.Value != null) ? (int)_param_sid.Value : -1;

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return SID;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return -1;
                }
            } return -1;
        }


        public static bool IsValid
        {
            get
            {
                try
                {
                    DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);
                    return dtw.TestConnection("SELECT TOP 1 [ID_USER] FROM [dbo].[USER]");
                }
                catch// (Exception ex)
                {
                    return false;
                }
            }
        }

        #endregion

        public static Dictionary<string, List<string>> Get_CubeDetails(string id)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "proc_GET_CUBE_DETAILS";

                    System.Data.IDbDataParameter _param_code = cmd.CreateParameter();
                    _param_code.DbType = System.Data.DbType.String;
                    _param_code.ParameterName = "@CUBEID";
                    _param_code.Value = id;
                    cmd.Parameters.Add(_param_code);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();

                    var columns = new List<string>();

                    for (int i = 0; i < _reader.FieldCount; i++)
                    {
                        columns.Add(_reader.GetName(i));
                    }

                    Dictionary<string, List<string>> _dict = new Dictionary<string, List<string>>();
                    while (_reader.Read())
                    {
                        foreach (string col in columns)
                        {
                            if (_dict.ContainsKey(col))
                                _dict[col].Add(_reader[col] == DBNull.Value ? "" : _reader[col].ToString());
                            else
                                _dict.Add(col, new List<string>() { (_reader[col] == DBNull.Value ? "" : _reader[col].ToString()) });
                        }
                    }
                    _reader.Close();

                    dtw.DBConnection.Close();
                    return _dict;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;

        }

        public static string Get_CubeName(string id)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                dtw.DBConnection.Open();

                try
                {

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "proc_GET_CUBE_NAME";

                    System.Data.IDbDataParameter _param_code = cmd.CreateParameter();
                    _param_code.DbType = System.Data.DbType.String;
                    _param_code.ParameterName = "@IDSET";
                    _param_code.Value = id;
                    cmd.Parameters.Add(_param_code);

                    System.Data.IDataReader _reader = cmd.ExecuteReader();

                    string CubeName = String.Empty;

                    if (_reader.Read())
                    {
                        CubeName = _reader["ID"].ToString();
                    }

                    _reader.Close();

                    dtw.DBConnection.Close();
                    return CubeName;
                }
                catch
                {
                    dtw.DBConnection.Close();
                    return null;
                }
            } return null;


        }


        public static QueryReport Insert_AttributeData(string attributeFilePath, int idSet, string userPathDir)
        {
            QueryReport _report = new QueryReport();
            _report.StartReport();


            string userScartedFileDir = userPathDir + @"\scarted";
            string userScartedFileName = attributeFilePath.Substring(attributeFilePath.LastIndexOf(@"\") + 1).Replace(".csv", "_scarted.csv");
            string min_time = string.Empty;
            string max_time = string.Empty;

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataAccess.SQLConnString_DB.ConnectionString);

            if (!dtw.TestConnection())
                return null;

            dtw.DBConnection.Open();

            try
            {
                // Carico il file csv nel DB
                CSVUploader uploader = new CSVUploader(SQLConnString_DB.ConnectionString);
                uploader.CreateDestinationTable = true;
                uploader.ConnectionTimeOut = 3600;
                uploader.Upload(attributeFilePath, "Temp_Attribute");

                // Lancio la SP per l'update degli attributi
                System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "sp_AttributeMain";

                System.Data.IDbDataParameter _param_code = cmd.CreateParameter();
                _param_code.DbType = System.Data.DbType.String;
                _param_code.ParameterName = "@IDSET";
                _param_code.Value = idSet;
                cmd.Parameters.Add(_param_code);

                cmd.ExecuteNonQuery();

                // Faccio una select sulla tabella degli scarti
                //  se il risultato non è null con i dati creo un file csv e restituisco il link 
                cmd = dtw.DBConnection.CreateCommand();
                cmd.CommandText = "SELECT * FROM Temp_Attribute_Scarted";
                System.Data.IDataReader dReader = cmd.ExecuteReader();

                string sHeader = "", sRow = "";

                bool bHeader = true;

                if (!Directory.Exists(userPathDir))
                    Directory.CreateDirectory(userPathDir);

                if (!Directory.Exists(userScartedFileDir))
                    Directory.CreateDirectory(userScartedFileDir);

                File.Create(userScartedFileDir + @"\" + userScartedFileName).Close();

                while (dReader.Read())
                {
                    sRow = "";

                    using (System.IO.StreamWriter file = new System.IO.StreamWriter(userScartedFileDir + @"\" + userScartedFileName, true))
                    {

                        if (bHeader)
                        {
                            for (int i = 0; i < dReader.FieldCount; i++)
                            {
                                sHeader += dReader.GetName(i) + "|";
                            }
                            bHeader = false;
                            sHeader = sHeader.Substring(0, sHeader.Length - 1);
                            file.WriteLine(sHeader);
                            _report.ScartedFilePath = @"/scarted/" + userScartedFileName;
                        }
                        
                        for(int i=0;i<dReader.FieldCount;i++)
                        {
                            sRow += dReader[i].ToString() + "|";
                        }

                        sRow = sRow.Substring(0, sRow.Length - 1);
                        file.WriteLine(sRow);
                    }
                }
            }
            catch (Exception ex)
            {
                _report.Errors.Add(ex.Message);
            }
            finally
            {
                _report.StopReport();

                _report.MaxTime = max_time;
                _report.MinTime = min_time;
            }

            return _report;

        }
    }
}

