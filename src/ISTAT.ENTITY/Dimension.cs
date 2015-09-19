using System.Collections.Generic;

using Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Base;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist;

using System.Linq;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme;

namespace ISTAT.ENTITY
{
    public class Dimension
    {
        private bool _timeDimension;
        private bool _measureDimension;
        private bool _frequencyDimension;
        private bool _isCodelist;
        private string _id;

        private string _codelist;
        private string _codelistAgency;
        private string _codelistVersion;

        private string _conceptRef;
        private string _conceptSchemeId;
        private string _conceptSchemeAgency;
        private string _conceptSchemeVersion;

        private List<TextTypeWrapper> _names;
        private List<TextTypeWrapper> _descriptions;
        private IList<Code> _codelistItems;

        public Dimension() {

            this._names = new List<TextTypeWrapper>();
            this._descriptions = new List<TextTypeWrapper>();
            this._codelistItems = new List<Code>();

        }
        public Dimension(IDimension dimension)
        {
            if (dimension.HasCodedRepresentation())
            {
                this._isCodelist = true;
                this._codelist = dimension.Representation.Representation.MaintainableReference.MaintainableId;
                this._codelistAgency = dimension.Representation.Representation.MaintainableReference.AgencyId;
                this._codelistVersion = dimension.Representation.Representation.MaintainableReference.Version;
            }
            else {
                this._isCodelist = false;
            }

            this._id = dimension.Id;
            this._conceptRef = dimension.ConceptRef.FullId;
            this._conceptSchemeId= dimension.ConceptRef.MaintainableReference.MaintainableId;
            this._conceptSchemeAgency = dimension.ConceptRef.MaintainableReference.AgencyId;
            this._conceptSchemeVersion = dimension.ConceptRef.MaintainableReference.Version;

            this._timeDimension = dimension.TimeDimension;
            this._measureDimension = dimension.MeasureDimension;
            this._frequencyDimension = dimension.FrequencyDimension;

            this._names=new List<TextTypeWrapper>();
            this._descriptions=new List<TextTypeWrapper>();
            this._codelistItems=new List<Code>();
            
        }

        public void Merge(ICodelistObject codelist) {

            Codelist _codelist = new Codelist(codelist);
            _codelistItems = _codelist.Items;
            this._names = new List<TextTypeWrapper>();
            foreach (ITextTypeWrapper text in codelist.Names)
            {
                this._names.Add(new TextTypeWrapper(text.Locale, text.Value));
            }

            this._descriptions = new List<TextTypeWrapper>();
            foreach (ITextTypeWrapper text in codelist.Descriptions)
            {
                this._descriptions.Add(new TextTypeWrapper(text.Locale, text.Value));
            }

        }
        public void Merge(IConceptObject concept)
        {
            Concept _concept = new Concept(concept);

            this._names = new List<TextTypeWrapper>();
            foreach (TextTypeWrapper text in _concept.Names)
            {
                this._names.Add(new TextTypeWrapper(text.Locale, text.Value));
            }

            this._descriptions = new List<TextTypeWrapper>();
            foreach (TextTypeWrapper text in _concept.Descriptions)
            {
                this._descriptions.Add(new TextTypeWrapper(text.Locale, text.Value));
            }

        }

        #region Public Properties

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

         public bool TimeDimension
         {
             get
             {
                 return this._timeDimension;
             }

             set
             {
                 this._timeDimension = value;
             }
         }
         public bool MeasureDimension
         {
             get
             {
                 return this._measureDimension;
             }

             set
             {
                 this._measureDimension = value;
             }
         }
         public bool FrequencyDimension
         {
             get
             {
                 return this._frequencyDimension;
             }

             set
             {
                 this._frequencyDimension = value;
             }
         }
         public bool IsCodelist { get { return _isCodelist; } }

         public List<TextTypeWrapper> Names { get { return _names; } set { _names = value; } }
         public List<TextTypeWrapper> Descriptions { get { return _descriptions; } set { _descriptions = value; } }

         public IList<Code> Codes {
             get { return _codelistItems; }
         }

         public string Codelist
         {
             get
             {
                 return this._codelist;
             }

             set
             {
                 this._codelist = value;
             }
         }
         public string CodelistAgency
         {
             get
             {
                 return this._codelistAgency;
             }

             set
             {
                 this._codelistAgency = value;
             }
         }
         public string CodelistVersion
         {
             get
             {
                 return this._codelistVersion;
             }

             set
             {
                 this._codelistVersion = value;
             }
         }

         public string ConceptRef
         {
             get
             {
                 return this._conceptRef;
             }

             set
             {
                 this._conceptRef = value;
             }
         }

         public string ConceptSchemeId
         {
             get
             {
                 return this._conceptSchemeId;
             }

             set
             {
                 this._conceptSchemeId = value;
             }
         }
         public string ConceptSchemeAgency
         {
             get
             {
                 return this._conceptSchemeAgency;
             }

             set
             {
                 this._conceptSchemeAgency = value;
             }
         }
         public string ConceptSchemeVersion
         {
             get
             {
                 return this._conceptSchemeVersion;
             }

             set
             {
                 this._conceptSchemeVersion = value;
             }
         }

         #endregion
    }
}