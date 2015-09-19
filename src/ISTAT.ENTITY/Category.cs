using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{
    public class Category
    {
        object _idTheme;
        object _idThemeParent;
        string _urn;
        List<TextTypeWrapper> _names;

        public Category(object idTheme, object idParent, string urn)
        {
            _idTheme = idTheme;
            _idThemeParent = idParent;
            _urn = urn;
            _names = new List<TextTypeWrapper>();
        }

        public object IDTheme { get { return _idTheme; } set { _idTheme = value; } }
        public object IDParentTheme { get { return _idThemeParent; } set { _idThemeParent = value; } }
        public List<TextTypeWrapper> Names { get { return _names; } set { _names = value; } }
        public string Urn { get { return _urn; } set { _urn = value; } }
    }
}
