using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using log4net;

namespace ISTAT.DBDAL
{

    public enum DB_NAME { 
        DatawarehouseServer=0,
        MappingStoreServer=1
    }

    class DataWrapper
    {

        private static readonly ILog Logger = LogManager.GetLogger(typeof(DataWrapper));

        public enum ECONNECTIONTYPE { 
            SQL=0
        };

        private System.Data.IDbConnection IConn;
        public System.Data.IDbConnection DBConnection { get { return IConn; } }

        private ECONNECTIONTYPE _typeConn = ECONNECTIONTYPE.SQL;
        private string _connectionString;

        public DataWrapper(ECONNECTIONTYPE typeConn, string connectionString) {
            _typeConn = typeConn;
            _connectionString = connectionString;
        }

        private System.Data.IDbConnection GetConnection()
        {
            switch (_typeConn) {
                case ECONNECTIONTYPE.SQL: return new System.Data.SqlClient.SqlConnection(_connectionString);
            }
            return null;
        }

        public bool TestConnection(string query) {
            try
            {
                IConn = this.GetConnection();

                IConn.Open();


                bool result = false;

                System.Data.IDbCommand cmd = IConn.CreateCommand();

                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = query;

                System.Data.IDataReader _reader = cmd.ExecuteReader();

                result = (_reader.FieldCount > 0);

                _reader.Close();
                IConn.Close();

                return result;

            }
            catch (Exception ex) {
                Logger.Error(ex.Message);
            }
            return false;

        }
        public bool TestConnection() {
            try
            {
                IConn = this.GetConnection();

                IConn.Open();

                IConn.Close();

                return true;
            }
            catch (Exception ex) {
                Logger.Error(ex.Message);
            }
            return false;

        }

    }
}
