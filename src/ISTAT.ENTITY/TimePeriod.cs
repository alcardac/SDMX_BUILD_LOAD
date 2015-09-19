using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{
    public class TimePeriod 
    {
        public int ID;
        public string CODE;

        public TimePeriod(int id, string code) {
            ID=id;
            CODE = code;
        }
    }
}
