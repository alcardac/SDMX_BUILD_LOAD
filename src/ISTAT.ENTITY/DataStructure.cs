using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{

    public enum DATAFLOW_PRODUCTION_STATUS { 
        IN_PRODUCTION=9,
        OUT_PRODUCTION=8
    }

    public class DataStructure
    {
        int _id_set;
        int _dsd_id;
        int _dataflow_id;
        int _theme_id;
        bool _isFinal;

        string _code;

        ISTAT.ENTITY.SDMXIdentifier _dsdIdentifier;
        ISTAT.ENTITY.SDMXIdentifier _dataFlowIdentifier;

        List<Dimension> _dimensions;
        List<Attribute> _attributes;
        List<TextTypeWrapper> _names;
        List<TextTypeWrapper> _descriptions;
        List<TextTypeWrapper> _themes;

        public DataStructure()
        {
            _id_set = -1;
            _dsd_id = -1;
            _code = string.Empty;

            _dimensions = new List<Dimension>();
            _attributes = new List<Attribute>();
            _names = new List<TextTypeWrapper>();
            _themes = new List<TextTypeWrapper>();
        }
        public DataStructure(int IDSet) {

            _id_set = IDSet;
            _dsd_id = -1;
            _code = string.Empty;
            _dimensions = new List<Dimension>();
            _attributes = new List<Attribute>();
            _names = new List<TextTypeWrapper>();
            _themes = new List<TextTypeWrapper>();
        }
        public DataStructure(int IDSet,string code)
        {

            _id_set = IDSet;
            _dsd_id = -1;
            _code = code;
            _dimensions = new List<Dimension>();
            _attributes = new List<Attribute>();
            _names = new List<TextTypeWrapper>();
            _themes = new List<TextTypeWrapper>();
        }
        public DataStructure(int IDSet, string code, int dataflow_id)
        {

            _id_set = IDSet;
            _dataflow_id = dataflow_id;
            _code = code;
            _dimensions = new List<Dimension>();
            _attributes = new List<Attribute>();
            _names = new List<TextTypeWrapper>();
            _themes = new List<TextTypeWrapper>();
        }
        public DataStructure(int IDSet, string code, int dataflow_id,int idTheme)
        {
            _id_set = IDSet;
            _dataflow_id = dataflow_id;
            _code = code;
            _theme_id = idTheme;
            _dimensions = new List<Dimension>();
            _attributes = new List<Attribute>();
            _names = new List<TextTypeWrapper>();
            _themes = new List<TextTypeWrapper>();
        }
        
        public int IDSet { get { return _id_set; } set { _id_set = value; } }
        public string Code { get { return _code; } set { _code = value; } }
        public int IDDsd { get { return _dsd_id; } set { _dsd_id = value; } }
        public int IDTheme { get { return _theme_id; } set { _theme_id = value; } }
        public int IDFlow { get { return _dataflow_id; } set { _dataflow_id = value; } }
        public bool IsFinal { get { return _isFinal; } set { _isFinal = value; } }

        public ISTAT.ENTITY.SDMXIdentifier DSDIdentifier { get { return _dsdIdentifier; } set { _dsdIdentifier = value; } }
        public ISTAT.ENTITY.SDMXIdentifier DataFlowIdentifier { get { return _dataFlowIdentifier; } set { _dataFlowIdentifier = value; } }

        public List<Dimension> Dimensions { get { return _dimensions; } set { _dimensions = value; } }
        public List<Attribute> Attributes { get { return _attributes; } set { _attributes = value; } }
        public List<TextTypeWrapper> Names { get { return _names; } set { _names = value; } }
        public List<TextTypeWrapper> Themes { get { return _themes; } set { _themes = value; } }

        public bool IsValid { get { return (IDSet > 0 && Dimensions.Count > 0 && Names.Count > 0); } }
    }
}
