using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Globalization;
using System.Configuration;

using Org.Sdmxsource.Sdmx.Api;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Manager.Retrieval.Mutable;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Reference;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable.Codelist;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Manager.Retrieval;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable.ConceptScheme;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable.Base;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist;
using Org.Sdmxsource.Sdmx.Api.Model;
using Org.Sdmxsource.Sdmx.Api.Model.Objects;
using Org.Sdmxsource.Sdmx.Api.Util;

using Org.Sdmxsource.Sdmx.Structureparser.Manager.Parsing;
using Org.Sdmxsource.Sdmx.SdmxObjects;
using Org.Sdmxsource.Sdmx.Util.Objects.Reference;

using Org.Sdmxsource.Util.Io;

using Estat.Sri.MappingStoreRetrieval.Factory;
using Estat.Sri.MappingStore.Store.Model;
using Estat.Sri.MappingStore.Store.Manager;

using Org.Sdmxsource.Sdmx.Api.Model.Data;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Base;

using Org.Sdmxsource.Sdmx.StructureRetrieval.Manager;

using Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme;

using ISTAT.ENTITY;

namespace ISTAT.DBDAL
{

    public class DataSDMX
    {
        public static readonly string Version_major = "3";
        public static readonly string Version_intermediate = "1";
        public static readonly string Version_lower = "0";

        private static readonly ConnectionStringSettings SQLConnString_DB = ConfigurationManager.ConnectionStrings[ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString()];

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
                sqlConnection = new System.Data.SqlClient.SqlConnection(DataSDMX.SQLConnString_DB.ConnectionString);

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

        private static ISdmxMutableObjectRetrievalManager GetManager()
        {

            MutableRetrievalManagerFactory factory = new Estat.Sri.MappingStoreRetrieval.Factory.MutableRetrievalManagerFactory();

            ISdmxMutableObjectRetrievalManager manager = factory.GetRetrievalManager(System.Configuration.ConfigurationManager.ConnectionStrings["MappingStoreServer"]);

            return manager;
        }

        private static ISdmxObjectRetrievalManager GetManagerImmutable()
        {

            Estat.Nsi.StructureRetriever.Manager.AuthMutableStructureSearchManager srManager = new Estat.Nsi.StructureRetriever.Manager.AuthMutableStructureSearchManager(SQLConnString_DB);
            List<IStructureReference> query = new List<IStructureReference>();
            IStructureReference sr = new StructureReferenceImpl(new MaintainableRefObjectImpl("", "", ""), Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd);
            query.Add(sr);

            IMutableObjects retObject = srManager.RetrieveStructures(query, true, false, null);
            ISdmxObjectRetrievalManager retrievalManager = new InMemoryRetrievalManager(retObject.ImmutableObjects);

            return retrievalManager;
        }

        public static ISet<IDataStructureMutableObject> GetDSDList()
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            SDMXIdentifier sdmxKey = new SDMXIdentifier();
            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            ISet<IDataStructureMutableObject> dsds = manager.GetMutableDataStructureObjects(query, false, true);


            // Remove not final dsd
            //List<IDataStructureMutableObject> dsdNotFinal = new List<IDataStructureMutableObject>();
            //foreach (IDataStructureMutableObject dsd in dsds)
            //{
            //    if (!dsd.FinalStructure.IsTrue)
            //        dsdNotFinal.Add(dsd);
            //}
            //foreach (IDataStructureMutableObject dsd in dsdNotFinal)
            //{
            //    dsds.Remove(dsd);
            //}

            return dsds;
        }

        public static IDataStructureObject GetDSD(SDMXIdentifier sdmxKey)
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            IDataStructureMutableObject dsd = manager.GetMutableDataStructure(query, false, false);

            return dsd.ImmutableInstance;
        }
        public static IDataflowObject GetDataflow(SDMXIdentifier sdmxKey)
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            IDataflowMutableObject dataflow = manager.GetMutableDataflow(query, false, false);

            if (dataflow == null) return null;

            return dataflow.ImmutableInstance;
        }
        public static ICodelistObject GetCodelist(SDMXIdentifier sdmxKey)
        {

            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            ICodelistMutableObject codelist = manager.GetMutableCodelist(query, false, false);

            if (codelist != null) return codelist.ImmutableInstance;

            return GetConceptSchemeItems(sdmxKey);

        }

        public static ICodelistObject GetConceptSchemeItems(SDMXIdentifier sdmxKey)
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Codelist.CodelistMutableCore codelist =
                new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Codelist.CodelistMutableCore();

            codelist.Id = sdmxKey.id;
            codelist.AgencyId = sdmxKey.agencyid;
            codelist.Version = sdmxKey.version;
            codelist.StructureType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureType.GetFromEnum(Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList);
            //codelist.StartDate = codelist.EndDate = DateTime.Now;
            codelist.FinalStructure = Org.Sdmxsource.Sdmx.Api.Constants.TertiaryBool.GetFromEnum(Org.Sdmxsource.Sdmx.Api.Constants.TertiaryBoolEnumType.True);

            IConceptSchemeMutableObject concepts = manager.GetMutableConceptScheme(query, false, false);

            foreach (ITextTypeWrapper IText in concepts.ImmutableInstance.Names)
                codelist.Names.Add(new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Base.TextTypeWrapperMutableCore(IText));
            foreach (ITextTypeWrapper IText in concepts.ImmutableInstance.Descriptions)
                codelist.Descriptions.Add(new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Base.TextTypeWrapperMutableCore(IText));


            foreach (IConceptObject concept in concepts.ImmutableInstance.Items)
            {

                Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Codelist.CodeMutableCore code =
                    new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Codelist.CodeMutableCore();

                code.Id = concept.Id;
                code.ParentCode = concept.ParentConcept;

                foreach (ITextTypeWrapper IText in concept.Names)
                    code.Names.Add(new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Base.TextTypeWrapperMutableCore(IText));
                foreach (ITextTypeWrapper IText in concept.Descriptions)
                    code.Descriptions.Add(new Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Base.TextTypeWrapperMutableCore(IText));


                codelist.AddItem(code);

            }
            return codelist.ImmutableInstance;
        }
        public static IConceptObject GetConcept(SDMXIdentifier sdmxKey, string idConcept)
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            IConceptSchemeMutableObject concepts = manager.GetMutableConceptScheme(query, false, false);
            foreach (IConceptObject concept in concepts.ImmutableInstance.Items)
            {
                if (concept.Id == idConcept)
                {


                    return concept;
                }
            }
            return null;
        }

        public static List<ICategoryObject> GetCategoryScheme()
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            SDMXIdentifier sdmxKey = new SDMXIdentifier();
            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxKey.agencyid, sdmxKey.id, sdmxKey.version);

            ISet<Org.Sdmxsource.Sdmx.Api.Model.Mutable.CategoryScheme.ICategorySchemeMutableObject> categories =
                manager.GetMutableCategorySchemeObjects(query, false, false);


            List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject> cats = new List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject>();

            foreach (Org.Sdmxsource.Sdmx.Api.Model.Mutable.CategoryScheme.ICategorySchemeMutableObject catSchm in categories)
            {
                cats.AddRange(GetCategories(catSchm.ImmutableInstance.Items));
            }

            return cats;

        }
        private static IList<ICategoryObject> GetCategories(IList<ICategoryObject> categories)
        {

            List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject> cats =
                new List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject>();

            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject sub_cat in categories)
            {
                cats.Add(sub_cat);
                cats.AddRange(GetCategories(sub_cat.Items) as List<Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme.ICategoryObject>);
            }


            return cats;
        }

        public static int Insert_Dataflow(SDMXIdentifier sdmxKey, int dsd_id, int idCat, List<TextTypeWrapper> names, List<TextTypeWrapper> descs, string uri)
        {

            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);
            int idFlow = -1;
            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    #region Insert dataflow
                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.INSERT_DATAFLOW";

                    System.Data.IDbDataParameter _id = cmd.CreateParameter();
                    _id.DbType = System.Data.DbType.String;
                    _id.ParameterName = "p_id";
                    _id.Value = sdmxKey.id;
                    cmd.Parameters.Add(_id);

                    System.Data.IDbDataParameter _version = cmd.CreateParameter();
                    _version.DbType = System.Data.DbType.String;
                    _version.ParameterName = "p_version";
                    _version.Value = sdmxKey.version;
                    cmd.Parameters.Add(_version);

                    System.Data.IDbDataParameter _agency = cmd.CreateParameter();
                    _agency.DbType = System.Data.DbType.String;
                    _agency.ParameterName = "p_agency";
                    _agency.Value = sdmxKey.agencyid;
                    cmd.Parameters.Add(_agency);

                    System.Data.IDbDataParameter _uri = cmd.CreateParameter();
                    _uri.DbType = System.Data.DbType.String;
                    _uri.ParameterName = "p_uri";
                    _uri.Value = uri;
                    cmd.Parameters.Add(_uri);

                    System.Data.IDbDataParameter _dsd_id = cmd.CreateParameter();
                    _dsd_id.DbType = System.Data.DbType.Int32;
                    _dsd_id.ParameterName = "p_dsd_id";
                    _dsd_id.Value = dsd_id;
                    cmd.Parameters.Add(_dsd_id);

                    System.Data.IDbDataParameter _is_final = cmd.CreateParameter();
                    _is_final.DbType = System.Data.DbType.Int32;
                    _is_final.ParameterName = "p_is_final";
                    _is_final.Value = 0;
                    cmd.Parameters.Add(_is_final);

                    int pk = -1;
                    System.Data.IDbDataParameter _pk = cmd.CreateParameter();
                    _pk.DbType = System.Data.DbType.Int32;
                    _pk.ParameterName = "p_pk";
                    _pk.Value = pk;
                    _pk.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(_pk);

                    object obj = cmd.ExecuteScalar();

                    #endregion

                    idFlow = int.Parse(_pk.Value.ToString());

                    #region Insert Localised string

                    System.Data.IDbCommand cmd_localised = dtw.DBConnection.CreateCommand();
                    cmd_localised.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_localised.CommandText = "dbo.INSERT_LOCALISED_STRING";

                    System.Data.IDbDataParameter _p_art_id = cmd_localised.CreateParameter();
                    _p_art_id.DbType = System.Data.DbType.Int32;
                    _p_art_id.ParameterName = "p_art_id";
                    _p_art_id.Value = idFlow;
                    cmd_localised.Parameters.Add(_p_art_id);

                    System.Data.IDbDataParameter _p_text = cmd_localised.CreateParameter();
                    _p_text.DbType = System.Data.DbType.String;
                    _p_text.ParameterName = "p_text";
                    cmd_localised.Parameters.Add(_p_text);

                    System.Data.IDbDataParameter _p_type = cmd_localised.CreateParameter();
                    _p_type.DbType = System.Data.DbType.String;
                    _p_type.ParameterName = "p_type";
                    cmd_localised.Parameters.Add(_p_type);

                    System.Data.IDbDataParameter _p_language = cmd_localised.CreateParameter();
                    _p_language.DbType = System.Data.DbType.String;
                    _p_language.ParameterName = "p_language";
                    cmd_localised.Parameters.Add(_p_language);

                    int pk_localised = -1;
                    System.Data.IDbDataParameter _pk_localised = cmd_localised.CreateParameter();
                    _pk_localised.DbType = System.Data.DbType.Int32;
                    _pk_localised.ParameterName = "p_pk";
                    _pk_localised.Value = pk_localised;
                    _pk_localised.Direction = System.Data.ParameterDirection.Output;
                    cmd_localised.Parameters.Add(_pk_localised);

                    foreach (TextTypeWrapper name in names)
                    {
                        _p_language.Value = name.Locale;
                        _p_type.Value = "Name";
                        _p_text.Value = name.Value;
                        cmd_localised.ExecuteNonQuery();
                    }
                    foreach (TextTypeWrapper desc in descs)
                    {
                        _p_language.Value = desc.Locale;
                        _p_type.Value = "Desc";
                        _p_text.Value = desc.Value;
                        cmd_localised.ExecuteNonQuery();
                    }

                    #endregion

                    #region Insert Categorisation
                    System.Data.IDbCommand cmd_cat = dtw.DBConnection.CreateCommand();
                    cmd_cat.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd_cat.CommandText = "dbo.INSERT_CATEGORISATION";

                    System.Data.IDbDataParameter _id_df = cmd_cat.CreateParameter();
                    _id_df.DbType = System.Data.DbType.String;
                    _id_df.ParameterName = "p_id";
                    _id_df.Value = sdmxKey.id;
                    cmd_cat.Parameters.Add(_id_df);

                    System.Data.IDbDataParameter _version_df = cmd_cat.CreateParameter();
                    _version_df.DbType = System.Data.DbType.String;
                    _version_df.ParameterName = "p_version";
                    _version_df.Value = sdmxKey.version;
                    cmd_cat.Parameters.Add(_version_df);

                    System.Data.IDbDataParameter _agency_df = cmd_cat.CreateParameter();
                    _agency_df.DbType = System.Data.DbType.String;
                    _agency_df.ParameterName = "p_agency";
                    _agency_df.Value = sdmxKey.agencyid;
                    cmd_cat.Parameters.Add(_agency_df);

                    System.Data.IDbDataParameter _uri_df = cmd_cat.CreateParameter();
                    _uri_df.DbType = System.Data.DbType.String;
                    _uri_df.ParameterName = "p_uri";
                    _uri_df.Value = uri;
                    cmd_cat.Parameters.Add(_uri_df);

                    System.Data.IDbDataParameter _art_id = cmd_cat.CreateParameter();
                    _art_id.DbType = System.Data.DbType.Int32;
                    _art_id.ParameterName = "p_art_id";
                    _art_id.Value = idFlow;
                    cmd_cat.Parameters.Add(_art_id);

                    System.Data.IDbDataParameter _cat_id = cmd_cat.CreateParameter();
                    _cat_id.DbType = System.Data.DbType.Int32;
                    _cat_id.ParameterName = "p_cat_id";
                    _cat_id.Value = idCat;
                    cmd_cat.Parameters.Add(_cat_id);

                    System.Data.IDbDataParameter _pk_cat = cmd_cat.CreateParameter();
                    _pk_cat.DbType = System.Data.DbType.Int32;
                    _pk_cat.ParameterName = "p_pk";
                    _pk_cat.Direction = System.Data.ParameterDirection.Output;
                    cmd_cat.Parameters.Add(_pk_cat);

                    cmd_cat.ExecuteNonQuery();

                    #endregion

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return idFlow;
                }
                catch// (Exception ex)
                {
                    return idFlow;
                }
            } return idFlow;

        }
        public static int Delete_Dataflow(int dataflow_id)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "dbo.DELETE_DATAFLOW";

                    System.Data.IDbDataParameter _dataflow_id = cmd.CreateParameter();
                    _dataflow_id.DbType = System.Data.DbType.Int32;
                    _dataflow_id.ParameterName = "ART_ID";
                    _dataflow_id.Value = dataflow_id;
                    cmd.Parameters.Add(_dataflow_id);

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();

                    return 1;
                }
                catch// (Exception ex)
                {
                    return 0;
                }
            }
            return 0;
        }

        public static System.IO.MemoryStream GetStreamSDMXObject(SDMXIdentifier sdmxIdentity, Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType structureType)
        {
            ISdmxMutableObjectRetrievalManager manager = GetManager();

            IMaintainableRefObject query = new MaintainableRefObjectImpl(sdmxIdentity.agencyid, sdmxIdentity.id, sdmxIdentity.version);

            Org.Sdmxsource.Sdmx.Api.Model.Objects.ISdmxObjects sdmxObjects =
                new Org.Sdmxsource.Sdmx.Util.Objects.Container.SdmxObjectsImpl();

            switch (structureType)
            {
                case Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.AgencyScheme:
                    sdmxObjects.AddAgencyScheme(manager.GetMutableAgencyScheme(query, false, false).ImmutableInstance);
                    break;
                case Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CategoryScheme:
                    sdmxObjects.AddCategoryScheme(manager.GetMutableCategoryScheme(query, false, false).ImmutableInstance);
                    break;
                case Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.ConceptScheme:
                    sdmxObjects.AddConceptScheme(manager.GetMutableConceptScheme(query, false, false).ImmutableInstance);
                    break;
                case Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList:
                    sdmxObjects.AddCodelist(manager.GetMutableCodelist(query, false, false).ImmutableInstance);
                    break;
                case Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd:
                    sdmxObjects.AddDataStructure(manager.GetMutableDataStructure(query, false, false).ImmutableInstance);
                    break;
            }

            System.IO.MemoryStream mem = GetStream(sdmxObjects, Org.Sdmxsource.Sdmx.Api.Constants.StructureOutputFormatEnumType.SdmxV21StructureDocument);

            return mem;
        }
        private static System.IO.MemoryStream GetStream(ISdmxObjects sdmxObjects, Org.Sdmxsource.Sdmx.Api.Constants.StructureOutputFormatEnumType version)
        {

            Org.Sdmxsource.Sdmx.Api.Constants.StructureOutputFormat soFormat =
                Org.Sdmxsource.Sdmx.Api.Constants.StructureOutputFormat.GetFromEnum(version);
            Org.Sdmxsource.Sdmx.Api.Model.Format.IStructureFormat outputFormat =
                new Org.Sdmxsource.Sdmx.SdmxObjects.Model.SdmxStructureFormat(soFormat);

            Org.Sdmxsource.Sdmx.Structureparser.Manager.StructureWriterManager swm =
                new Org.Sdmxsource.Sdmx.Structureparser.Manager.StructureWriterManager();

            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();

            swm.WriteStructures(sdmxObjects, outputFormat, memoryStream);

            return memoryStream;
        }

        public static IList<ArtefactImportStatus> DeleteStructure(SDMXIdentifier sdmxKey, Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType typeArtefact = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd)
        {

            IList<ArtefactImportStatus> artefactImportStatuses = new List<ArtefactImportStatus>();

            if (typeArtefact == Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd)
            {
                IDataStructureObject dsd = DataSDMX.GetDSD(sdmxKey);
                var manager = new MappingStoreManager(SQLConnString_DB, artefactImportStatuses);
                manager.DeleteStructure(dsd);
            }
            else if (typeArtefact == Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dataflow)
            {

                IDataflowObject dataflow = DataSDMX.GetDataflow(sdmxKey);
                var manager = new MappingStoreManager(SQLConnString_DB, artefactImportStatuses);
                manager.DeleteStructure(dataflow);
            }

            return artefactImportStatuses;
        }

        public static IList<ArtefactImportStatus> SubmitStructure(System.IO.Stream stream)
        {

            System.IO.StreamReader _stream = new System.IO.StreamReader(stream);
            ReadableDataLocationFactory fact = new ReadableDataLocationFactory();
            IReadableDataLocation rdl = fact.GetReadableDataLocation(_stream.BaseStream);

            IList<ArtefactImportStatus> artefactImportStatuses = new List<ArtefactImportStatus>();

            try
            {
                StructureParsingManager spm = new StructureParsingManager();
                IStructureWorkspace workspace = spm.ParseStructures(rdl);
                ISdmxObjects sdmxObjects = workspace.GetStructureObjects(false);

                //sdmxObjects = RemoveNotFinalDSD(sdmxObjects);

                var manager = new MappingStoreManager(SQLConnString_DB, artefactImportStatuses);
                manager.SaveStructures(sdmxObjects);

                _stream.Close();
                rdl.Close();


                foreach (ArtefactImportStatus datastructure in artefactImportStatuses)
                {
                    if (datastructure.ImportMessage.StructureReference.MaintainableStructureEnumType == Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd)
                    {

                        Delete_Dataflow((int)datastructure.PrimaryKeyValue + 1);
                        /*
               DeleteStructure(new SDMXIdentifier() {
                   id = datastructure.ImportMessage.StructureReference.MaintainableId,
                   agencyid = datastructure.ImportMessage.StructureReference.AgencyId,
                   version = datastructure.ImportMessage.StructureReference.Version,
               }, Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dataflow);   */
                    }
                }

                return artefactImportStatuses;
            }
            catch (Exception ex)
            {
                _stream.Close();
                rdl.Close();
                throw ex;
            }


        }

        private static ISdmxObjects RemoveNotFinalDSD(ISdmxObjects sdmxObjects)
        {
            List<IDataStructureObject> lDsd = new List<IDataStructureObject>();

            foreach (IDataStructureObject dsd in sdmxObjects.DataStructures)
            {
                if (!dsd.IsFinal.IsTrue)
                    lDsd.Add(dsd);
            }

            foreach (IDataStructureObject dsd in lDsd)
            {
                sdmxObjects.RemoveDataStructure(dsd);
            }

            return sdmxObjects;
        }

        public static Dictionary<string, List<string>> GetView(System.IO.Stream stream, TranscodeTime transcode_time = null, int maxResult = 0)
        {
            Dictionary<string, List<string>> view = new Dictionary<string, List<string>>();

            using (System.IO.StreamReader _stream = new System.IO.StreamReader(stream))
            {
                ReadableDataLocationFactory fact = new ReadableDataLocationFactory();
                IReadableDataLocation rdl = fact.GetReadableDataLocation(_stream.BaseStream);

                try
                {
                    ISdmxObjectRetrievalManager retrievalManager = DataSDMX.GetManagerImmutable();

                    Org.Sdmxsource.Sdmx.DataParser.Manager.DataReaderManager dataReader = new Org.Sdmxsource.Sdmx.DataParser.Manager.DataReaderManager();
                    Org.Sdmxsource.Sdmx.Api.Engine.IDataReaderEngine dataEngine = dataReader.GetDataReaderEngine(rdl, retrievalManager);

                    if (dataEngine != null)
                    {
                        dataEngine.Reset();

                        #region Data Parsing

                        while (dataEngine.MoveNextDataset())
                        {
                            IDataStructureObject dsd = dataEngine.DataStructure;

                            while (dataEngine.MoveNextKeyable())
                            {

                                IKeyable currentKey = dataEngine.CurrentKey;

                                while (dataEngine.MoveNextObservation())
                                {
                                    IObservation obs = dataEngine.CurrentObservation;
                                    var freq = TranscodeTime.TypePeriod.A.ToString();

                                    #region add column for key of attributes at level series
                                    foreach (IKeyValue keyValue in currentKey.Attributes)
                                    {
                                        if (view.Keys.Contains<string>(keyValue.Concept))
                                        {
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                        else
                                        {
                                            view.Add(keyValue.Concept, new List<string>());
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                    }
                                    #endregion
                                    #region add column for key of dim
                                    foreach (IKeyValue keyValue in currentKey.Key)
                                    {
                                        if (keyValue.Concept == dsd.FrequencyDimension.Id)
                                            freq = keyValue.Code.Trim();

                                        if (view.Keys.Contains<string>(keyValue.Concept))
                                        {
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                        else
                                        {
                                            view.Add(keyValue.Concept, new List<string>());
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                    }
                                    #endregion
                                    #region add column for key of attributes to level observation
                                    foreach (IKeyValue keyValue in obs.Attributes)
                                    {
                                        if (view.Keys.Contains<string>(keyValue.Concept))
                                        {
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                        else
                                        {
                                            view.Add(keyValue.Concept, new List<string>());
                                            ((List<string>)view[keyValue.Concept]).Add(keyValue.Code.Trim());
                                        }
                                    }
                                    #endregion
                                    #region add column Cross Sectional Value
                                    if (obs.CrossSection)
                                        if (view.Keys.Contains<string>(obs.CrossSectionalValue.Concept))
                                        {
                                            ((List<string>)view[obs.CrossSectionalValue.Concept]).Add(obs.CrossSectionalValue.Code.Trim());
                                        }
                                        else
                                        {
                                            view.Add(obs.CrossSectionalValue.Concept, new List<string>());
                                            ((List<string>)view[obs.CrossSectionalValue.Concept]).Add(obs.CrossSectionalValue.Code.Trim());
                                        }
                                    #endregion

                                    #region Apply transcoding

                                    string obsTime = obs.ObsTime;

                                    bool useTranscode = true;
                                    //if (view.Keys.Contains<string>("FREQ"))
                                    if (freq == TranscodeTime.TypePeriod.A.ToString()) useTranscode = false;

                                    if (useTranscode)
                                    {
                                        int sepIndex = obsTime.IndexOf('-');
                                        string period = string.Empty;
                                        string period_change = obsTime[sepIndex].ToString();
                                        int nextChar;

                                        if (!int.TryParse(obsTime[sepIndex + 1].ToString(), out nextChar))
                                        {
                                            period = obsTime[sepIndex + 1].ToString();
                                            period_change += period;
                                        }
                                        else period = TranscodeTime.TypePeriod.M.ToString();

                                        if (view.Keys.Contains<string>("FREQ")) period = freq;

                                        TranscodeTime _transcode_time = new TranscodeTime();
                                        _transcode_time.stopChar = period_change;
                                        _transcode_time.periodChar = (TranscodeTime.TypePeriod)Enum.Parse(typeof(TranscodeTime.TypePeriod), period);

                                        obsTime = _transcode_time.TransCodific(obsTime);
                                    }

                                    #endregion

                                    #region add column TIME_PERIOD

                                    if (view.Keys.Contains<string>("TIME_PERIOD"))
                                    {
                                        ((List<string>)view["TIME_PERIOD"]).Add(obsTime);
                                    }
                                    else
                                    {
                                        view.Add("TIME_PERIOD", new List<string>());
                                        ((List<string>)view["TIME_PERIOD"]).Add(obsTime);
                                    }
                                    #endregion
                                    #region add column OBS_VALUE
                                    if (view.Keys.Contains<string>("OBS_VALUE"))
                                    {
                                        ((List<string>)view["OBS_VALUE"]).Add(obs.ObservationValue.Trim());
                                    }
                                    else
                                    {
                                        view.Add("OBS_VALUE", new List<string>());
                                        ((List<string>)view["OBS_VALUE"]).Add(obs.ObservationValue.Trim());
                                    }
                                    #endregion


                                    if (maxResult > 0
                                        && ((List<string>)view["OBS_VALUE"]).Count >= maxResult)
                                        return view;

                                }

                            }
                            break;
                        }
                        #endregion

                    }
                }
                catch (Exception ex)
                {
                    //Console.Write(ex.Message);
                }

                //_stream.Close();
                rdl.Close();

            }


            //return first dataset
            return (view.Count > 0) ? view : null;

        }

        // DB SDMX Query
        public static int Get_IDCategory(string urn)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);
            int idCat = -1;
            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    int indexS = urn.LastIndexOf('.') + 1;
                    string strCategory = urn.Substring(indexS, urn.Length - indexS);

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "SELECT * FROM [dbo].[CATEGORY] INNER JOIN dbo.ITEM ON [dbo].[CATEGORY].CAT_ID=ITEM.ITEM_ID WHERE ID='" + strCategory + "'";
                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        var _idStr = reader.GetInt64(reader.GetOrdinal("CAT_ID"));
                        idCat = int.Parse(_idStr.ToString());

                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return idCat;
                }
                catch// (Exception ex)
                {
                    return idCat;
                }
            } return idCat;
        }

        public static int Get_IDDsd(int dataflow_id)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);
            int id_dsd = -1;
            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "SELECT * FROM dbo.DATAFLOW WHERE DF_ID=" + dataflow_id;

                    System.Data.IDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        id_dsd = reader.GetInt32(reader.GetOrdinal("DSD_ID"));
                    }

                    ////////////////////////

                    dtw.DBConnection.Close();
                    return id_dsd;
                }
                catch// (Exception ex)
                {
                    return id_dsd;
                }
            } return id_dsd;

        }
        public static int Get_IDDsd(SDMXIdentifier sdmxKey)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);
            int dsd_id = -1;
            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "SELECT * FROM [dbo].[ARTEFACT] WHERE ID='" + sdmxKey.id + "' AND  AGENCY='" + sdmxKey.agencyid + "' AND  CAST(VERSION1 as char(1))+CASE ISNULL(VERSION2,-1) WHEN -1 THEN '' ELSE '.' END+CAST(VERSION2 as char(1))+CASE ISNULL(VERSION3,-1) WHEN -1 THEN '' ELSE '.' END+CASE ISNULL(VERSION3,-1) WHEN -1 THEN '' ELSE CAST(VERSION3 as char(1)) END ='" + sdmxKey.version + "'";
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                        dsd_id = int.Parse(result.ToString());

                    ////////////////////////

                    dtw.DBConnection.Close();

                    return dsd_id;
                }
                catch //(Exception ex)
                {
                    return dsd_id;
                }
            }
            return dsd_id;

        }

        public static void Set_DataflowProduction(int dataflow_id, bool active)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "UPDATE dbo.DATAFLOW SET PRODUCTION = " + (int)((active) ? DATAFLOW_PRODUCTION_STATUS.IN_PRODUCTION : DATAFLOW_PRODUCTION_STATUS.OUT_PRODUCTION) + " WHERE dbo.DATAFLOW.DF_ID=" + dataflow_id;

                    cmd.ExecuteNonQuery();

                    ////////////////////////

                    dtw.DBConnection.Close();

                }
                catch (Exception ex)
                {
                    Console.Write(ex.Message);
                }
            }

        }
        public static bool Get_DataflowProduction(int dataflow_id)
        {
            DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);

            if (dtw.TestConnection())
            {
                try
                {
                    dtw.DBConnection.Open();

                    ////////////////////////

                    System.Data.IDbCommand cmd = dtw.DBConnection.CreateCommand();
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "SELECT dbo.DATAFLOW.PRODUCTION FROM dbo.DATAFLOW WHERE dbo.DATAFLOW.DF_ID=" + dataflow_id;

                    var result = cmd.ExecuteScalar();


                    ////////////////////////

                    dtw.DBConnection.Close();

                    return (int.Parse(result.ToString()) == (int)DATAFLOW_PRODUCTION_STATUS.IN_PRODUCTION);
                }
                catch// (Exception ex)
                {
                    return false;
                }
            }
            return false;
        }

        public static bool IsValid
        {
            get
            {
                try
                {
                    DataWrapper dtw = new DataWrapper(DataWrapper.ECONNECTIONTYPE.SQL, DataSDMX.SQLConnString_DB.ConnectionString);
                    return dtw.TestConnection("SELECT TOP 1 [DSD_ID] FROM [dbo].[DSD]");
                }
                catch// (Exception ex)
                {
                    return false;
                }
            }
        }


    }

}
