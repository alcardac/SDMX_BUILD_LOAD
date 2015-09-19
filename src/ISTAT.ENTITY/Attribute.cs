using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Base;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme;

namespace ISTAT.ENTITY
{
    public class Attribute
    {
        private string _id;
        private string _assignmentStatus;
        private string _attachmentLevel;
        private bool _mandatory;
        private List<string> _dimensionReferences;

        private string _codelist;
        private string _codelistAgency;
        private string _codelistVersion;
        private bool _isCodelist;

        private string _conceptRef;
        private string _conceptSchemeId;
        private string _conceptSchemeAgency;
        private string _conceptSchemeVersion;

        private List<TextTypeWrapper> _names;
        private List<TextTypeWrapper> _descriptions;
        private IList<Code> _codelistItems;

        //private string _structureType;

        public Attribute()
        {

            this._names = new List<TextTypeWrapper>();
            this._descriptions = new List<TextTypeWrapper>();
            this._codelistItems = new List<Code>();

        }
        public Attribute(IAttributeObject attr){

            if (attr.HasCodedRepresentation())
            {
                this._codelist = attr.Representation.Representation.MaintainableReference.MaintainableId;
                this._codelistAgency = attr.Representation.Representation.MaintainableReference.AgencyId;
                this._codelistVersion = attr.Representation.Representation.MaintainableReference.Version;
                this._isCodelist = true;
            }
            else {
                this._isCodelist = false;
            }
            this._id = attr.Id;

            this._conceptRef = attr.ConceptRef.FullId;
            this._conceptSchemeId = attr.ConceptRef.MaintainableReference.MaintainableId;
            this._conceptSchemeAgency = attr.ConceptRef.MaintainableReference.AgencyId;
            this._conceptSchemeVersion = attr.ConceptRef.MaintainableReference.Version;

            this._assignmentStatus = attr.AssignmentStatus;
            this._attachmentLevel = attr.AttachmentLevel.ToString();
            if (this._attachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString())
            {
                _dimensionReferences = new List<string>();
                foreach (string str_dim in attr.DimensionReferences)
                    this._dimensionReferences.Add(str_dim);
            }
            this._mandatory = attr.Mandatory;

            this._names = new List<TextTypeWrapper>();
            this._descriptions = new List<TextTypeWrapper>();
            this._codelistItems = new List<Code>();
        }

        public void Merge(ICodelistObject codelist)
        {

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

        public bool Mandatory
        {
            get
            {
                return this._mandatory;
            }

            set
            {
                this._mandatory = value;
            }
        }
        public string AssignmentStatus
        {
            get
            {
                return this._assignmentStatus;
            }

            set
            {
                this._assignmentStatus = value;
            }
        }
        public string AttachmentLevel { get { return _attachmentLevel; } set { _attachmentLevel = value; } }
        public List<string> DimensionReferences { get { return _dimensionReferences; } set { _dimensionReferences = value; } }
        public bool IsObservationAtt {
            get {
                if (this.AttachmentLevel == null) return false;
                return (this.AttachmentLevel == Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.Observation.ToString()); 
            }
        }
        public bool IsCodelist { get { return _isCodelist; } set { _isCodelist=value; } }

        public List<TextTypeWrapper> Names { get { return _names; } set { _names = value; } }
        public List<TextTypeWrapper> Descriptions { get { return _descriptions; } set { _descriptions = value; } }
        public IList<Code> Codes
        {
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
