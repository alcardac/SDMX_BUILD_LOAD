using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using ISTAT.ENTITY;
using ISTAT.IO;

namespace SDMX_Dataloader.Engine
{

    public class BuilderProcedure
    {

        private DataStructure _ds;
        private FileCSV _fileCsvData;
        private List<string> _filesXmlData;
        private Mapping _mapping;
        private bool _useTranscodeTime;
        private TranscodeTime _transcodeTime;

        public DataStructure DataSet { get { return _ds; } set { _ds = value; } }
        public FileCSV File_CSV { get { return _fileCsvData; } set { _fileCsvData = value; } }
        public List<string> Files_XML { get { return _filesXmlData; } set { _filesXmlData = value; } }
        public Mapping Mapping { get { return _mapping; } set { _mapping = value; } }
        public TranscodeTime TranscodeTime { get { return _transcodeTime; } set { _transcodeTime = value; } }
        public bool UseTranscodeTime { get { return _useTranscodeTime; } set { _useTranscodeTime = value; } }


        private static System.Globalization.CultureInfo cultureInfo;
        public static System.Globalization.CultureInfo CurrentCultureInfo { get { return cultureInfo; } set { cultureInfo = value; } }
        private static string TwoLetterIso { get { return (CurrentCultureInfo != null) ? CurrentCultureInfo.TwoLetterISOLanguageName : "en"; } }



        public BuilderProcedure()
        {

            _ds = null;
            _fileCsvData = null;
            _filesXmlData = null;
            _mapping = null;
            _transcodeTime = null;
            _useTranscodeTime = false;

        }

        public static BuilderProcedure Create()
        {
            return new BuilderProcedure();
        }

        public List<Dictionary<string, string>> Get_DSDs()
        {
            ISet<Org.Sdmxsource.Sdmx.Api.Model.Mutable.DataStructure.IDataStructureMutableObject> dsds = ISTAT.DBDAL.DataSDMX.GetDSDList();
            List<Dictionary<string, string>> _res = new List<Dictionary<string, string>>();
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Mutable.DataStructure.IDataStructureMutableObject dsd in dsds)
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

                int langIndex = TextTypeWrapper.GetIndexLocale(locations, SDMX_Dataloader.Engine.BuilderProcedure.CurrentCultureInfo);
               

                Dictionary<string, string> _result = new Dictionary<string, string>();

                string notFinal = "";

                if (!dsd.FinalStructure.IsTrue)
                    notFinal = "(Not final)";

                _result.Add("Text", string.Format(" [ {0} ] - {1} ", notFinal +" "+ sdmxIdentity.ToString(), dsd.Names[langIndex].Value));
                _result.Add("Value", sdmxIdentity.ToString());

                _res.Add(_result);
            }
            return _res;
        }
        public DataStructure Get_DSD(ISTAT.ENTITY.SDMXIdentifier sdmxIdentity)
        {
            DataStructure _ds = new ISTAT.ENTITY.DataStructure();
            Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDataStructureObject dsd = ISTAT.DBDAL.DataSDMX.GetDSD(sdmxIdentity);

            #region Get Dimension
            List<Dimension> dims = new List<Dimension>();
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDimension dim in dsd.DimensionList.Dimensions)
            {
                Dimension _dim = new Dimension(dim);
                dims.Add(_dim);
            }
            #endregion
            #region Get Attribute
            List<ISTAT.ENTITY.Attribute> atts = new List<ISTAT.ENTITY.Attribute>();
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IAttributeObject att in dsd.Attributes)
            {
                ISTAT.ENTITY.Attribute _att = new ISTAT.ENTITY.Attribute(att);
                atts.Add(_att);
            }
            #endregion

            _ds.Dimensions = dims;
            _ds.Attributes = atts;
            _ds.DSDIdentifier = sdmxIdentity;
            _ds.IDDsd = ISTAT.DBDAL.DataSDMX.Get_IDDsd(sdmxIdentity);
            _ds.IsFinal = dsd.IsFinal.IsTrue;

            this._ds = _ds;

            return _ds;
        }
        public void Delete_DSD(SDMXIdentifier sdmxIdentity) {
             
            var result=ISTAT.DBDAL.DataSDMX.DeleteStructure(sdmxIdentity);

        }

        public Dictionary<string, List<string>> Get_CUBE_DETAILS(string id)
        {
            return ISTAT.DBDAL.DataAccess.Get_CubeDetails(id);

        }

        public string Get_CUBE_NAME(string id)
        {
            return ISTAT.DBDAL.DataAccess.Get_CubeName(id);
        }

        public Codelist Get_CODELIST(string code, bool isDimensionCode)
        {
            Codelist codelsit = new Codelist();

            //IList<Code> return_codes = null;
            if (this._ds != null)
            {
                if (code == "TIME_PERIOD")
                {
                    codelsit.Identify = new SDMXIdentifier() { id = "TIME_PERIOD", agencyid = "", version = "" };
                    foreach (TimePeriod time in ISTAT.DBDAL.DataAccess.Get_TimePeriod())
                        codelsit.Items.Add(new Code() { Id = time.CODE });
                }
                else
                {

                    List<ConceptDimensionDB> _dimsPart = ISTAT.DBDAL.DataAccess.Get_DimensionsPartial(_ds.IDSet);
                    List<ConceptAttributeDB> _attsPart = ISTAT.DBDAL.DataAccess.Get_AttributesPartial(_ds.IDSet);


                    if (isDimensionCode)
                    {
                        #region Ricerca di una dimension Codelist
                        // cerco nelle dimensioni
                        foreach (Dimension dim in this._ds.Dimensions)
                        {
                            if (dim.Id == code)
                            {
                                if (dim.Codelist != null && dim.CodelistAgency != null && dim.CodelistVersion != null)
                                {
                                    codelsit.Identify = new SDMXIdentifier() { agencyid = dim.CodelistAgency, id = dim.Codelist, version = dim.CodelistVersion };

                                    IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode> _codes = ISTAT.DBDAL.DataSDMX.GetCodelist(codelsit.Identify).Items;

                                    foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode icode in _codes)
                                        codelsit.Items.Add(new Code(icode));
                                }
                                else {
                                    ConceptDimensionDB db_dim = (ConceptDimensionDB)(from d in _dimsPart where d.Code == code select d).OfType<ConceptDimensionDB>().First();
                                    
                                    string[] str = db_dim.MemberTable.Split('_');

                                    if (str.Length > 3)
                                    {                                  
                                        str[0] = "CL_" + str[0].Substring(3, str[0].Length - 3);
                                        for (int i = 1; i < str.Length - 2; i++) {
                                            str[0] += "_" + str[i];    
                                        }
                                    }
                                    else {
                                        str[0] = "CL_" + str[0].Substring(3, str[0].Length - 3);
                                    }

                                    str[str.Length - 1] = (str[str.Length - 1][0].ToString() + "." + str[str.Length - 1][1].ToString()).ToString();

                                    codelsit.Identify = new SDMXIdentifier() { id = str[0], agencyid = str[str.Length - 2], version = str[str.Length - 1] };
                                    IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode> _codes = ISTAT.DBDAL.DataSDMX.GetCodelist(codelsit.Identify).Items;

                                    foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode icode in _codes)
                                        codelsit.Items.Add(new Code(icode));
                                }
                            }
                        }

                        #endregion
                    }
                    else
                    {
                        #region Ricerca di una attribut codelist

                        if (this._ds.Attributes != null)
                        {
                            // cerco nelle dimensioni
                            foreach (ISTAT.ENTITY.Attribute att in this._ds.Attributes)
                            {
                                if (att.Id == code)
                                {
                                    if (att.Codelist != null && att.CodelistAgency != null && att.CodelistVersion != null)
                                    {
                                        codelsit.Identify = new SDMXIdentifier() { agencyid = att.CodelistAgency, id = att.Codelist, version = att.CodelistVersion };
                                        codelsit.Items = att.Codes;
                                        IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode> _codes = ISTAT.DBDAL.DataSDMX.GetCodelist(codelsit.Identify).Items;

                                        codelsit.Items = new List<Code>();
                                        foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode icode in _codes)
                                            codelsit.Items.Add(new Code(icode));
                                    }
                                    else {
                                        ConceptAttributeDB db_att = (ConceptAttributeDB)(from a in _attsPart where a.Code == code select a).OfType<ConceptAttributeDB>().First();

                                        string[] str = db_att.MemberTable.Split('_');

                                        if (str.Length > 3)
                                        {
                                            str[0] = "CL_" + str[0].Substring(3, str[0].Length - 3);
                                            for (int i = 1; i < str.Length - 2; i++)
                                            {
                                                str[0] += "_" + str[i];
                                            }
                                        }
                                        else
                                        {
                                            str[0] = "CL_" + str[0].Substring(3, str[0].Length - 3);
                                        }

                                        str[str.Length - 1] = (str[str.Length - 1][0].ToString() + "." + str[str.Length - 1][1].ToString()).ToString();

                                        codelsit.Identify = new SDMXIdentifier() { id = str[0], agencyid = str[str.Length - 2], version = str[str.Length - 1] };
                                        IList<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode> _codes = ISTAT.DBDAL.DataSDMX.GetCodelist(codelsit.Identify).Items;

                                        foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode icode in _codes)
                                            codelsit.Items.Add(new Code(icode));
                                    }
                                }
                            }
                        }

                        #endregion
                    }
                }
            }
            return codelsit;
        }

        public DataStructure Set_DATASET(int idset) {
            if (idset < 0)
            {
                this._ds = null;
                return null;
            }
            else
            {
                this._ds = ISTAT.DBDAL.DataAccess.Get_DataStructure(idset);
                this._ds.IDSet = idset;

                this._ds.Dimensions = ISTAT.DBDAL.DataAccess.Get_Dimensions(idset);
                this._ds.Attributes = ISTAT.DBDAL.DataAccess.Get_Attributes(idset);

                Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDataflowObject df=
                ISTAT.DBDAL.DataSDMX.GetDataflow(this._ds.DataFlowIdentifier);
                if (df != null)
                {
                    this._ds.DSDIdentifier = new SDMXIdentifier()
                    {
                        id = df.DataStructureRef.FullId,
                        agencyid = df.DataStructureRef.AgencyId,
                        version = df.DataStructureRef.Version,
                    };
                }

                return this._ds;
            }
        }
        public DataStructure Create_DATASET(int iduser, string code, string urnCategory, List<string[]> names, List<string[]> descs, List<string> dimensions, List<string> attributes,string uriDataflow)
        {

            #region GET ALL INFO FOR DIMENSIONI

            List<Dimension> _partDim = new List<Dimension>();
            foreach (Dimension dim in _ds.Dimensions)
            {
                try
                {
                    if (dimensions.Contains(dim.Id))
                    {
                        if (!dim.TimeDimension)
                        {
                            if (dim.MeasureDimension)
                            {
                                Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist =
                                ISTAT.DBDAL.DataSDMX.GetConceptSchemeItems(new SDMXIdentifier()
                                {
                                    agencyid = dim.CodelistAgency,
                                    id = dim.Codelist,
                                    version = dim.CodelistVersion
                                });

                                dim.Merge(codelist);
                            }
                            else
                            {
                                //Logger.DebugFormat("Create Datastructure Process: Retrive Codelist for dimension {0}", dim.Codelist);

                                Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist =
                                ISTAT.DBDAL.DataSDMX.GetCodelist(new SDMXIdentifier()
                                {
                                    agencyid = dim.CodelistAgency,
                                    id = dim.Codelist,
                                    version = dim.CodelistVersion
                                });

                                dim.Merge(codelist);

                            }
                        }
                        else
                        {

                            Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme.IConceptObject concept =
                            ISTAT.DBDAL.DataSDMX.GetConcept(new SDMXIdentifier()
                            {
                                agencyid = dim.ConceptSchemeAgency,
                                id = dim.ConceptSchemeId,
                                version = dim.ConceptSchemeVersion
                            }, dim.Id);

                            dim.Merge(concept);

                        }

                        _partDim.Add(dim);


                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            _ds.Dimensions = _partDim;

            #endregion
            #region GET ALL INFO FOR ATTRIBUTI

            List<ISTAT.ENTITY.Attribute> _partAtt = new List<ISTAT.ENTITY.Attribute>();
            foreach (ISTAT.ENTITY.Attribute att in _ds.Attributes)
            {
                try
                {
                    if (attributes.Contains(att.Id))
                    {
                        //Logger.DebugFormat("Create Datastructure Process: Retrive Codelist for attribute {0}", att.Codelist);

                        if (att.CodelistAgency != null && att.Codelist != null && att.CodelistVersion != null)
                        {
                            Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist =
                            ISTAT.DBDAL.DataSDMX.GetCodelist(new SDMXIdentifier()
                            {
                                agencyid = att.CodelistAgency,
                                id = att.Codelist,
                                version = att.CodelistVersion
                            });

                            att.Merge(codelist);
                        }
                        else
                        {
                            Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme.IConceptObject concept =
                            ISTAT.DBDAL.DataSDMX.GetConcept(new SDMXIdentifier()
                            {
                                agencyid = att.ConceptSchemeAgency,
                                id = att.ConceptSchemeId,
                                version = att.ConceptSchemeVersion
                            }, att.ConceptRef);

                            att.Merge(concept);
                        }

                        _partAtt.Add(att);
                    }
                }
                catch// (Exception ex)
                {
                    //Logger.Warn(ex.Message);
                }
            }
            _ds.Attributes = _partAtt;

            #endregion

            int idSet = -1;
            int idflow = -1;
            int idTheme = -1;
            try
            {

                if ((idTheme = ISTAT.DBDAL.DataAccess.Insert_Theme(urnCategory)) > 0)
                {

                    if ((idSet = ISTAT.DBDAL.DataAccess.Insert_DataStructure(iduser, idTheme, code)) > 0)
                    {
                        
                        List<TextTypeWrapper> locationNames = new List<TextTypeWrapper>();
                        foreach (string[] name in names)
                            if (name[1] != string.Empty)
                                locationNames.Add(new TextTypeWrapper(name[0].ToString(), name[1].ToString()));

                        List<TextTypeWrapper> locationDescs = new List<TextTypeWrapper>();
                        foreach (string[] desc in descs)
                            if (desc[1] != string.Empty)
                                locationDescs.Add(new TextTypeWrapper(desc[0].ToString(), desc[1].ToString()));

                        if (!ISTAT.DBDAL.DataAccess.Insert_LocalisedString(locationNames, idSet, "CatSet"))
                            throw new Exception("Insert string location fail");

                        _ds.IDSet = idSet;
                        _ds.DSDIdentifier.id = _ds.Code = code;
                        _ds.IDTheme = idTheme;
                        _ds.Names = locationNames;

                        int idCat = ISTAT.DBDAL.DataSDMX.Get_IDCategory(urnCategory);

                        if ((idflow = ISTAT.DBDAL.DataSDMX.Insert_Dataflow(_ds.DSDIdentifier, _ds.IDDsd, idCat, locationNames, locationDescs, uriDataflow)) > 0)
                        {
                            // Set status of production off
                            ISTAT.DBDAL.DataSDMX.Set_DataflowProduction(idflow,false);

                            //Logger.DebugFormat("Create Datastructure Process: Insert and registry Dataflow : {0}", idflow);
                            if (!ISTAT.DBDAL.DataAccess.Insert_DataFlow(idflow, _ds.IDSet, _ds.DSDIdentifier))
                                throw new Exception("Insert and registry Dataflow fail");

                            //Logger.DebugFormat("Create Datastructure Process: Insert and registry Dimensions");
                            if (!ISTAT.DBDAL.DataAccess.Insert_Dimension(_ds.IDSet, _ds.Dimensions))
                                throw new Exception("Insert and registry Dimensions fail");

                            //Logger.DebugFormat("Create Datastructure Process: Insert and registry Attributes");
                            if (!ISTAT.DBDAL.DataAccess.Insert_Attribute(_ds.IDSet, _ds.Attributes))
                                throw new Exception("Insert and registry Attributes fail");

                            //Logger.DebugFormat("Create Datastructure Process: Insert dimensions code");
                            if (!ISTAT.DBDAL.DataAccess.Insert_DimensionItems(_ds.Dimensions))
                                throw new Exception("Insert dimensions code fail");

                            //Logger.DebugFormat("Create Datastructure Process: Insert Attributes code");
                            if (!ISTAT.DBDAL.DataAccess.Insert_AttributeItems(_ds.Attributes))
                                throw new Exception("Insert Attributes code fail");

                            //Logger.DebugFormat("Create Datastructure Process: Create fact table");
                            if (!ISTAT.DBDAL.DataAccess.Create_FactTable(_ds.IDSet))
                                throw new Exception("Create fact table fail");

                            return this._ds;
                            //Logger.DebugFormat("Create Datastructure Process: End");

                        }
                        else throw new Exception();
                    }
                    else throw new Exception();
                }
                else throw new Exception();
            }
            catch(Exception ex)
            {

                ISTAT.DBDAL.DataAccess.Delete_Datastructure(idSet);
                ISTAT.DBDAL.DataSDMX.Delete_Dataflow(idflow);

                //this._ds = null;
                return null;
            }
        }
        public bool Delete_DATASET(int idset) {

            if (idset < 0)
            {
                this._ds = null;

                return false;
            }
            else
            {
                int idFlow = ISTAT.DBDAL.DataAccess.Get_DataStructure(idset).IDFlow;
                ISTAT.DBDAL.DataSDMX.Delete_Dataflow(idFlow);
                ISTAT.DBDAL.DataAccess.Delete_Datastructure(idset);
                this._ds = null;

                return true;
            }
        }

        public List<Mapping> Get_MAPPINGS(int idset, int iduser)
        {

            List<Mapping> _mappings = new List<Mapping>();

            Dictionary<string, int> lst_mapping = ISTAT.DBDAL.DataAccess.Get_Mapping(idset);
            if (lst_mapping != null)
            {
                foreach (string mapp in lst_mapping.Keys)
                {
                    Mapping m = new Mapping();
                    m.Name = mapp;
                    m.IDSchema = (int)lst_mapping[mapp.ToString()];
                    _mappings.Add(m);
                }
            }
            return _mappings;
        }
        public Mapping Set_MAPPING(int IDMappingSchema)
        {

            Dictionary<string, object> mapping_set = ISTAT.DBDAL.DataAccess.Get_MappingSet(IDMappingSchema);
            Dictionary<string, object> mapping_items = ISTAT.DBDAL.DataAccess.Get_MappingScheme(IDMappingSchema);

            if (mapping_set != null)
            {

                _ds = new DataStructure(int.Parse(mapping_set["ID_SET"].ToString()));

                _transcodeTime = new ISTAT.ENTITY.TranscodeTime();
                _transcodeTime.periodChar = (TranscodeTime.TypePeriod)mapping_set["TRANSCODE_VALUE"];
                _transcodeTime.stopChar = (mapping_set["TRANSCODE_CHAR"].ToString() != string.Empty) ? mapping_set["TRANSCODE_CHAR"].ToString() : string.Empty;

                _mapping = new Mapping();
                _mapping.IDSchema = IDMappingSchema;
                _mapping.Name = mapping_set["NAME"].ToString();
                _mapping.Time = ((DateTime)mapping_set["TIMESTAMP"]).TimeOfDay;

                _mapping.Description = mapping_set["DESCRIPTION"].ToString();

                _mapping.TranscodeUse = (bool)mapping_set["TRANSCODE_USE"];
                _mapping.TranscodeTime = _transcodeTime;

                _mapping.CSV_CHAR = (mapping_set["FILE_CSV_CHAR"].ToString() != string.Empty) ? char.Parse(mapping_set["FILE_CSV_CHAR"].ToString()) : ';';
                _mapping.CSV_HASHEADER = (bool)mapping_set["FILE_CSV_HASHEADER"];

                if (mapping_items != null)
                {
                    _mapping.Items = new MappingItem[mapping_items.Count];
                    int i = 0;
                    foreach (object mapp in mapping_items.Keys)
                    {
                        _mapping.Items[i] = new MappingItem();
                        Dictionary<int, string> c = mapping_items[mapp.ToString()] as Dictionary<int, string>;
                        _mapping.Items[i]._a = c.Keys.First();
                        _mapping.Items[i]._b = mapp.ToString();
                        _mapping.Items[i]._c = c.Values.First();
                        i++;
                    }
                }
            }

            return _mapping;

        }
        public Mapping Create_MAPPING(
            int idset,
            int iduser,
            string name,
            string desc,
            List<MappingItem> items,
            string csv_char,
            bool csv_header,
            bool trans_use,
            string trans_char,
            int trans_period)
        {

            _mapping = new Engine.Mapping();

            Dictionary<string, Dictionary<string, object>> dict = new Dictionary<string, Dictionary<string, object>>();
            foreach (MappingItem item in items) {
                Dictionary<string, object> c=new Dictionary<string,object>();
                c.Add(item._b.ToString(),item._c);
                dict.Add(item._a.ToString(),c );
            }
            int id = -1;
            if ((id = ISTAT.DBDAL.DataAccess.Create_Mapping(
                idset,
                iduser,
                name,
                desc,
                dict,
                csv_char,
                csv_header,
                trans_use,
                trans_char,
                trans_period)) > 0)
            {
                _mapping.IDSchema = id;
                _mapping.Items = items.ToArray<MappingItem>();
                return _mapping;
            }
            else return null;
        }
        public bool Delete_MAPPING(int idschema) {

            if (ISTAT.DBDAL.DataAccess.Delete_Mapping(idschema))
            {
                _mapping = null;
                return true;
            }
            else
                return false;
        }
        
        /*
        public void Set_TRANSCODE_TIME(string charEnd, TranscodeTime.TypePeriod typePeriod) {
            _useTranscodeTime = true;
            _transcodeTime = new TranscodeTime();
            _transcodeTime.stopChar = charEnd;
            _transcodeTime.periodChar = ((TranscodeTime.TypePeriod)typePeriod);

            if (this._mapping!=null && this._mapping.IsValid)
            {
                ISTAT.DBDAL.DataAccess.Update_TranscodeTime(this._mapping.IDSchema, charEnd, (int) typePeriod);
            }

        }
        public TranscodeTime Get_TRANSCODE_TIME()
        {
            _useTranscodeTime = true;
            if (this._mapping != null && this._mapping.IsValid)
            {
                return ISTAT.DBDAL.DataAccess.Get_TranscodeTime(this._mapping.IDSchema);
            }
            else return null;

        }
        
       
        public Dictionary<string, List<string>> Get_DATA_VIEW(int maxResult=0) 
        {
    
                Dictionary<string, List<string>> _view = null;

                // return view of csv file
                if (_fileCsvData != null && _fileCsvData.IsValid)
                {
                    string[] filesCSV= System.IO.Directory.GetFiles(_fileCsvData.filePath);

                    foreach (string fileName in filesCSV)
                    {
                        System.IO.StreamReader streamFile = new System.IO.StreamReader(fileName);
                        _view = Mapping.GetView(streamFile.BaseStream, _mapping, _transcodeTime, maxResult, (_fileCsvData.firstRowHeader) ? 1 : 0);
                        streamFile.Close();
                        break;
                    }
                }

                // return view of xml file
                if (_filesXmlData != null)
                    foreach (string fileName in _filesXmlData)
                    {
                        System.IO.StreamReader streamFile = new System.IO.StreamReader(fileName);
                        _view = ISTAT.DBDAL.DataSDMX.GetView(streamFile.BaseStream, _transcodeTime, maxResult);
                        streamFile.Close();
                        break;
                    }
                return _view;
        }

        public QueryReport Insert_DATA()
        {


            QueryReport result = new QueryReport();

            Dictionary<string, List<string>> _view = null;

            // return view of csv file
            if (_fileCsvData != null && _fileCsvData.IsValid)
            {
                string[] filesCSV = System.IO.Directory.GetFiles(_fileCsvData.filePath);

                foreach (string fileName in filesCSV)
                {
                    using (System.IO.StreamReader streamFile = new System.IO.StreamReader(fileName))
                    {
                        _view = Mapping.GetView(streamFile.BaseStream, _mapping, _transcodeTime, 0, 0);
                    }
                    QueryReport _result = ISTAT.DBDAL.DataAccess.Insert_Data(this.DataSet.IDSet, _view);
                    result.Marge(_result);
                }
            }

            // return view of xml file
            if (_filesXmlData != null)
                foreach (string fileName in _filesXmlData)
                {
                    using (System.IO.StreamReader streamFile = new System.IO.StreamReader(fileName))
                    {
                        _view = ISTAT.DBDAL.DataSDMX.GetView(streamFile.BaseStream, _transcodeTime, 0);
                    }
                    QueryReport _result = ISTAT.DBDAL.DataAccess.Insert_Data(this.DataSet.IDSet, _view);
                    result.Marge(_result);
                }

            return result;
        }
        */




    }

}
