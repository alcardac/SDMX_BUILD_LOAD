using System.Collections.Generic;


namespace ISTAT.ENTITY
{
    public class Code
    {
        private IList<TextTypeWrapper> _names;
        private IList<TextTypeWrapper> _descriptions;
        private string _id;
        private string _parentCode;

        public Code()
        {
            _names = new List<TextTypeWrapper>();
            _descriptions = new List<TextTypeWrapper>();
        }
        public Code(Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode _code)
        {
            _id = _code.Id;

            _parentCode = _code.ParentCode;

            _names = new List<TextTypeWrapper>();
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper text in _code.Names)
                _names.Add(new TextTypeWrapper(text.Locale, text.Value));
            _descriptions = new List<TextTypeWrapper>();
            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Base.ITextTypeWrapper text in _code.Descriptions)
                _descriptions.Add(new TextTypeWrapper(text.Locale, text.Value));
        }
        #region Public Properties

        public string ParentCode
        {
            get
            {
                return this._parentCode;
            }
            set
            {
                this._parentCode = value;
            }
        }

        public string Id 
        {
            get
            {
                return this._id;
            }
            set
            {
                this._id = value;
            }
        }

        public IList<TextTypeWrapper> Descriptions
        {
            get
            {
                return this._descriptions;
            }
            set
            {
                this._descriptions = value;
            }
        }

        public IList<TextTypeWrapper> Names
        {
            get
            {
                return this._names;
            }
            set
            {
                this._names = value;
            }
        }
     
          #endregion
    }
}