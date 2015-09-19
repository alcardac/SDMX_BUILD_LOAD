using System.Collections.Generic;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist;

namespace ISTAT.ENTITY
{
    public class Codelist
    {

        public SDMXIdentifier Identify;

        private IList<Code> _items = new List<Code>();
        public IList<Code> Items
        {
            get
            {
                return this._items;
            }
            set
            {
                this._items = value;
            }
        }


        public Codelist() { 
        
        }

        public Codelist (ICodelistObject codelist)
        {
            foreach (ICode code in codelist.Items)
            {
                var codes = new Code();
                foreach (var text in code.Names)
                {
                    codes.Names.Add(new TextTypeWrapper(text.Locale, text.Value));
                }
                foreach (var text in code.Descriptions)
                {
                    codes.Descriptions.Add(new TextTypeWrapper(text.Locale, text.Value));
                }
                codes.Id = code.Id;
                codes.ParentCode = code.ParentCode;
                _items.Add(codes);
            }
        }

        
    }
}