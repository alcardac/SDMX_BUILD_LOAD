using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ISTAT.ENTITY;
using ISTAT.IO;

namespace SDMX_Dataloader.Engine
{
    public struct MappingItem
    {
        public object _a;
        public object _b;
        public object _c;
    }
    
    public class Mapping
    {
        private int _idschema;
        private string _name;
        private string _desc;
        private TimeSpan _time;
        private MappingItem[] _items;

        private char _csv_file_char;
        private bool _csv_file_hasHeader;

        private bool _transcodeUse;
        private TranscodeTime _transcodeTime;

        public int IDSchema { get { return _idschema; } set { _idschema = value; } }
        public string Name { get { return _name; } set { _name = value; } }
        public string Description { get { return _desc; } set { _desc = value; } }
        public TimeSpan Time { get { return _time; } set { _time = value; } }

        public MappingItem[] Items { get { return _items; } set { _items = value; } }

        public bool TranscodeUse { get { return _transcodeUse; } set { _transcodeUse = value; } }
        public TranscodeTime TranscodeTime { get { return _transcodeTime; } set { _transcodeTime = value; } }

        public char CSV_CHAR { get { return _csv_file_char; } set { _csv_file_char = value; } }
        public bool CSV_HASHEADER { get { return _csv_file_hasHeader; } set { _csv_file_hasHeader = value; } }

        public bool IsValid { get { return (_name != string.Empty && _items != null); } }


        // Procedura molto pesante!!!
        // Trasforma un csv in un dizionario di liste una rappresentazione in memoria di una tabella in forma normale 
        
        public static Dictionary<string, List<string>> GetView(System.IO.Stream stream, Mapping mapping, int maxResult = 0, int offSet = 0)
        {
                if (stream == null) return null;
                if (mapping == null) return null;

                Dictionary<string, List<string>> view = new Dictionary<string, List<string>>();
                stream.Seek(0, System.IO.SeekOrigin.Begin);

                //create object for CSVReader and pass the stream
                CSVReader reader = new CSVReader((System.IO.Stream)stream);

                string[] dataRow;
                int indexRow = 0;

                try
                {
                    while ((dataRow = reader.GetCSVLine()) != null)
                    {
                        // offset salto le  offSet righe del csv
                        if (indexRow >= offSet)
                        {
                            foreach (MappingItem item in mapping.Items)
                            {
                                int numColumn = int.Parse(item._a.ToString());
                                string data = dataRow[numColumn - 1];
                                string header = item._b.ToString();

                                if (header.ToUpper() == "TIME_PERIOD")
                                    if (mapping.TranscodeUse)
                                        data = mapping.TranscodeTime.TransCodific(data);

                                if (view.Keys.Contains<string>(header))
                                {

                                    if (maxResult > 0
                                        && ((List<string>)view[header]).Count >= maxResult)
                                        return view;

                                    ((List<string>)view[header]).Add(data.Trim());
                                }
                                else
                                {
                                    view.Add(header, new List<string>());
                                    ((List<string>)view[header]).Add(data.Trim());
                                }
                            }

                        }

                        indexRow++;

                    }
                    return view;
                }
                catch (Exception ex)
                {
                    //Console.Write(ex.Message);
                }
            return null;
        }
        
    }


}
