using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using ISTAT.ENTITY;
using ISTAT.IO;
using BulkUpload;

namespace SDMX_Dataloader.Engine
{
    public class LoaderProcedure
    {
        private DataStructure _ds;
        private FileCSV _fileCsvData;
        private ISTAT.IO.Utility.FileGeneric _filesXmlData;
        private Mapping _mapping;
        private bool _useTranscodeTime;
        private TranscodeTime _transcodeTime;


        public DataStructure DataSet { get { return _ds; } set { _ds = value; } }
        public FileCSV File_CSV { get { return _fileCsvData; } set { _fileCsvData = value; } }
        public ISTAT.IO.Utility.FileGeneric Files_XML { get { return _filesXmlData; } set { _filesXmlData = value; } }
        public Mapping Mapping { get { return _mapping; } set { _mapping = value; } }
        public TranscodeTime TranscodeTime { get { return _transcodeTime; } set { _transcodeTime = value; } }
        public bool UseTranscodeTime { get { return _useTranscodeTime; } set { _useTranscodeTime = value; } }

        private static System.Globalization.CultureInfo cultureInfo;
        public static System.Globalization.CultureInfo CurrentCultureInfo { get { return cultureInfo; } set { cultureInfo = value; } }
        private static string TwoLetterIso { get { return (CurrentCultureInfo != null) ? CurrentCultureInfo.TwoLetterISOLanguageName : "en"; } }


        public LoaderProcedure()
        {
                            
            _ds = null;     
            _mapping = null;
            _fileCsvData = null;
            _filesXmlData = null;
            _transcodeTime = null;
        }

        public static LoaderProcedure Create()
        {
            return new LoaderProcedure();
        }

        public void Set_DataStructure(int IDCube) {

            if (IDCube >= 0)
            {
                _ds = ISTAT.DBDAL.DataAccess.Get_DataStructure(IDCube);
                _transcodeTime = null;
                _mapping = null;
            }
        }

        public void Set_Mappingset(int IDMappingSchema)
        {

            Dictionary<string, object> mapping_set = ISTAT.DBDAL.DataAccess.Get_MappingSet(IDMappingSchema);
            Dictionary<string, object> mapping_items = ISTAT.DBDAL.DataAccess.Get_MappingScheme(IDMappingSchema);

            if (mapping_set != null)
            {

                int idSet = int.Parse(mapping_set["ID_SET"].ToString());

                _ds=ISTAT.DBDAL.DataAccess.Get_DataStructure(idSet);


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
        }

        public Dictionary<string, List<string>> Get_DATA_VIEW(int maxResult = 0)
        {

            Dictionary<string, List<string>> _view = null;

            // return view of csv file
            if (_fileCsvData != null && _fileCsvData.IsValid)
            {
                string[] filesData = System.IO.Directory.GetFiles(_fileCsvData.filePath);
                using (System.IO.StreamReader streamFile = new System.IO.StreamReader(filesData[0]))
                {
                    _view = Mapping.GetView(streamFile.BaseStream, _mapping, maxResult, (_fileCsvData.firstRowHeader) ? 1 : 0);
                    streamFile.Close();
                }
            }

            // return view of xml file
            if (_filesXmlData != null)
            {
                string[] filesData = System.IO.Directory.GetFiles(_filesXmlData.filePath);
                using (System.IO.StreamReader streamFile = new System.IO.StreamReader(filesData[0]))
                {
                    TranscodeTime transcode = (_mapping != null) ? (_mapping.TranscodeUse) ? _mapping.TranscodeTime : null : null;

                    _view = ISTAT.DBDAL.DataSDMX.GetView(streamFile.BaseStream, transcode, 0); 
                    
                    streamFile.Close();
                }
            }
            return _view;
        }

        public QueryReport Insert_AttributeDATA(string PathDir)
        {
            QueryReport result = new QueryReport();
            result.StartReport();

            if (_fileCsvData != null && _fileCsvData.IsValid)
            {
                result.FileSource = _fileCsvData.filename;
                QueryReport _result = ISTAT.DBDAL.DataAccess.Insert_AttributeData(_fileCsvData.filePath + @"\" + _fileCsvData.filename, this.DataSet.IDSet, PathDir);
                result.Merge(_result);
            }

            if (result.RecordCount > 0 || result.RecordOverrideCount > 0)
                ISTAT.DBDAL.DataAccess.Insert_Load(
                    this.DataSet.IDSet,
                    this.DataSet.IDFlow,
                    result.MinTime,
                    result.MaxTime,
                    result.RecordCount + result.RecordOverrideCount,
                    result.FileSource);

            result.StopReport();

            return result;
        }

        public QueryReport Insert_DATA()
        {

            QueryReport result = new QueryReport();
            result.StartReport();
            Dictionary<string, List<string>> _view = null;

            // return view of csv file
            if (_fileCsvData != null && _fileCsvData.IsValid)
            {
                result.FileSource = _fileCsvData.filename;
                string[] filesData = System.IO.Directory.GetFiles(_fileCsvData.filePath);
                using (System.IO.StreamReader streamFile = new System.IO.StreamReader(filesData[0]))
                {
                    _view = Mapping.GetView(streamFile.BaseStream, _mapping, 0, (_mapping.CSV_HASHEADER)?1:0);
                    streamFile.Close();
                }
                QueryReport _result = ISTAT.DBDAL.DataAccess.Insert_Data(this.DataSet.IDSet, _view);
                result.Merge(_result);
            }

            // return view of xml file
            if (_filesXmlData != null)
            {
                result.FileSource = _filesXmlData.filename;
                string[] filesData = System.IO.Directory.GetFiles(_filesXmlData.filePath);
                using (System.IO.StreamReader streamFile = new System.IO.StreamReader(filesData[0]))
                {

                    TranscodeTime transcode = (_mapping != null) ? (_mapping.TranscodeUse) ? _mapping.TranscodeTime : null : null;

                    _view = ISTAT.DBDAL.DataSDMX.GetView(streamFile.BaseStream, transcode, 0);
                    streamFile.Close();
                }
                QueryReport _result = ISTAT.DBDAL.DataAccess.Insert_Data(this.DataSet.IDSet, _view);
                result.Merge(_result);
            }
            

            // Write log on db for RSS

            if (result.RecordCount>0 || result.RecordOverrideCount>0)
                ISTAT.DBDAL.DataAccess.Insert_Load(
                    this.DataSet.IDSet,
                    this.DataSet.IDFlow,
                    result.MinTime,
                    result.MaxTime,
                    result.RecordCount+result.RecordOverrideCount,
                    result.FileSource);

            result.StopReport();

            return result;
        }

        public bool HasValidMappingSet { get { return (_mapping != null && _mapping.IsValid); } }

    }
}
