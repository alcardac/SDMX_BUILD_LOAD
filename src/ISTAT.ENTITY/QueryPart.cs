using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{
    public class QueryCouple
    {
        string _member;
        string _code;
        object _value;
        public QueryCouple(string member, string code, object value = null)
        {
            _member = member;
            _code = code;
            _value = value;
        }
        public string MEMBER { get { return _member; } set { _member = value; } }
        public string CODE { get { return _code; } set { _code = value; } }
        public object VALUE { get { return (_value!=null)?_value:"NULL"; } set { _value = value; } }
    }
    public class QueryPart
    {
        Dictionary<string, QueryCouple> _query_part;

        const string _separator_select = " , ";
        const string _separator_insert = " , ";
        const string _separator_where = " AND ";

        public QueryPart() {
            _query_part = new Dictionary<string, QueryCouple>();
        }

        public QueryCouple this[string field]
        {

            get { return (this._query_part.Keys.Contains(field)) ? this._query_part[field] : null; }
            set
            {
                if (!this._query_part.Keys.Contains(field))
                {
                    this._query_part.Add(field, value);
                }
            }
        }

        public Dictionary<string, QueryCouple> FIELDS { get { return _query_part; } }

        public string SELECT_PART
        {
            get
            {
                string _sep = string.Empty;
                string _sql_part = string.Empty;
                foreach (string field in _query_part.Keys)
                {
                    _sql_part += _sep + "ID"+field;
                    _sep = _separator_select;
                }

                return _sql_part;
            }
        }
        public string INSERT_PART_VALUE
        {
            get
            {
                string _sep = string.Empty;
                string _sql_part = string.Empty;
                foreach (string field in _query_part.Keys)
                {
                    _sql_part += _sep + ((_query_part[field] != null) ? _query_part[field].VALUE.ToString() : "NULL");
                    _sep = _separator_insert;
                }

                return _sql_part;
            }
        }
        public string WHERE_PART_VALUE
        {
            get
            {
                string _sep = string.Empty;
                string _sql_part = string.Empty;
                foreach (string field in _query_part.Keys)
                {
                    _sql_part += _sep + "ID" + field + "=" + ((_query_part[field] != null) ? _query_part[field].VALUE.ToString() : "NULL");
                    _sep = _separator_where;
                }

                return _sql_part;
            }
        }
        public string WHERE_PART_CODE
        {
            get
            {
                string _sep = string.Empty;
                string _sql_part = string.Empty;
                foreach (string field in _query_part.Keys)
                {
                    _sql_part += _sep + field + "=" + ((_query_part[field] != null) ? "'"+_query_part[field].CODE.ToString()+"'" : "NULL");
                    _sep = _separator_where;
                }

                return _sql_part;
            }
        }            
        public string KEY_RECORD
        {
            get
            {
                string _sep = string.Empty;
                string _sql_part = string.Empty;
                foreach (string field in _query_part.Keys)
                {
                    _sql_part += _sep + ((_query_part[field] != null) ? "'" + _query_part[field].CODE.ToString() + "'" : "NULL");
                    _sep = _separator_insert;
                }

                return _sql_part;
            }
        }

    }

    public class QueryReport {

        int _recordCount;
        int _recordTargetCount;
        int _recordIgnoreCount;
        int _recordOverrideCount;
        int _queryExecCount;
        string _fileSource;
        string _scartedFilePath;

        // rappresentation of min and max time period insert in query
        string _min_time;
        string _max_time;

        TimeSpan _timeStart;
        TimeSpan _timeStop;
        List<string> _errors;

        public QueryReport() {
            _recordCount = 0;
            _recordTargetCount = 0;
            _recordOverrideCount = 0;
            _recordIgnoreCount = 0;
            _queryExecCount = 0;
            _errors = new List<string>();
        }

        public int RecordCount { get { return _recordCount; } set { _recordCount = value; } }
        public int RecordTargetCount { get { return _recordTargetCount; } set { _recordTargetCount = value; } }
        public int RecordIgnoreCount { get { return _recordIgnoreCount; } set { _recordIgnoreCount = value; } }
        public int RecordOverrideCount { get { return _recordOverrideCount; } set { _recordOverrideCount = value; } }
        public string FileSource { get { return _fileSource; } set { _fileSource = value; } }
        public string ScartedFilePath { get { return _scartedFilePath; } set { _scartedFilePath = value; } }

        public string MinTime { get { return _min_time; } set { _min_time = value; } }
        public string MaxTime { get { return _max_time; } set { _max_time = value; } }

        public int QueryExecCount { get { return _queryExecCount; } set { _queryExecCount = value; } }
        public List<string> Errors { get { return _errors; } }
        public TimeSpan TimeExecute { get { return _timeStop.Subtract(_timeStart); } }

        public TimeSpan TimeStart { get { return _timeStart; } }
        public TimeSpan TimeStop { get { return _timeStop; } }

        public void StartReport() {
            _timeStart = DateTime.Now.TimeOfDay;
        }
        public void StopReport()
        {
            _timeStop = DateTime.Now.TimeOfDay;
        }

        public void Merge(QueryReport q) {


            this._errors.AddRange(q.Errors);
            this._queryExecCount += q.QueryExecCount;
            this._recordCount += q.RecordCount;
            this._recordIgnoreCount += q.RecordIgnoreCount;
            this._recordOverrideCount += q.RecordOverrideCount;
            this._recordTargetCount += q.RecordTargetCount;
            this._timeStart = (this._timeStart.CompareTo(q.TimeStart) > 0) ? this._timeStart : q.TimeStart;
            this._timeStop = (this._timeStop.CompareTo(q.TimeStop) > 0) ? this._timeStop : q.TimeStop;

            this._scartedFilePath = String.IsNullOrEmpty(q.ScartedFilePath) ? this._scartedFilePath : q.ScartedFilePath;

            this._min_time = TranscodeTime.CompareMin(this._min_time, q.MinTime);
            this._max_time = TranscodeTime.CompareMin(this._max_time, q.MaxTime);
        }

    }
}
