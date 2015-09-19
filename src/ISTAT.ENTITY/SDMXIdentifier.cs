using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{

    public class SDMXIdentifier
    {
        public static readonly char char_separator = '+';
        public string agencyid = string.Empty;
        public string id = string.Empty;
        public string version = string.Empty;

        public override string ToString()
        {
            return id + SDMXIdentifier.char_separator + agencyid + SDMXIdentifier.char_separator + version;
        }
        public static SDMXIdentifier CreateFromString(string identify)
        {

            string[] strs= identify.Split(SDMXIdentifier.char_separator);

            return new SDMXIdentifier {
                id = strs[0],
                agencyid = strs[1],
                version = strs[2],
            };

        }
    }
}
