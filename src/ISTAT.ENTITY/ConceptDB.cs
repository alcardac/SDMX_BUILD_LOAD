using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{
    public class ConceptDimensionDB
    {
        public int IDDim;
        public string IDName;
        public string Code;
        public string MemberTable;

        public bool IsTimeSeriesDim;
    }
    public class ConceptAttributeDB
    {
        public int IDAtt;
        public string IDName;
        public string Code;
        public string MemberTable;

        public bool IsCodelist;
        public bool IsObservationValue;
    }
    
}
