// --------------------------------------------------------------------------------------------------------------------
// <copyright file="Concept.cs" company="Eurostat">
//   Date Created : 2014-05-30
//   Copyright (c) 2014 by the European   Commission, represented by Eurostat. All rights reserved.
//   Licensed under the European Union Public License (EUPL) version 1.1. 
//   If you do not accept this license, you are not allowed to make any use of this file.
// </copyright>
// <summary>
//   Concept class />
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace ISTAT.ENTITY
{
    using System;
    using System.Collections.Generic;
    using Org.Sdmxsource.Sdmx.Api.Model.Objects.Base;
    using Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme;
    using Org.Sdmxsource.Sdmx.Api.Model.Objects.Reference;

    /// <summary>
    /// Concept class 
    /// </summary>
    public class Concept
    {

        public string _id;

        private IList<TextTypeWrapper> _names;
        private IList<TextTypeWrapper> _descriptions;
        private readonly IRepresentation _coreRepresentation;
        private readonly ICrossReference _isoConceptReference;
        private string _parentAgency;
        private string _parentConcept;
        private Uri _uri;
        private Uri _urn;

        #region Constructors and Destructors

        public Concept (IConceptObject concept)
        {
            this._id = concept.Id;
            this._names = new List<TextTypeWrapper>();
            this._descriptions = new List<TextTypeWrapper>();
        
            foreach (var text in concept.Names)
                this._names.Add(new TextTypeWrapper(text.Locale, text.Value));
            foreach (var text in concept.Descriptions)
                this._descriptions.Add(new TextTypeWrapper(text.Locale, text.Value));

            this._coreRepresentation = concept.CoreRepresentation;
            this._isoConceptReference = concept.IsoConceptReference;
            this._parentAgency = concept.ParentAgency;
            this._parentConcept = concept.ParentConcept;
            this._uri = concept.Uri;
            this._urn = concept.Urn;

        }

        #endregion

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

        /// <summary>
        ///     Gets the URI for this component, returns null if there is no URI.
        ///     <p />
        ///     URI describes where additional information can be found for this component, this is guaranteed to return
        ///     a value if the structure is a <c>IMaintainableObject</c> and isExternalReference is true
        /// </summary>
        /// <value> </value>
        public Uri Uri
        {
            get
            {
                return this._uri;
            }
        }

        /// <summary>
        ///     Gets the URN for this component.  The URN is unique to this instance and is a computable generated value based on
        ///     other attributes set within the component.
        /// </summary>
        /// <value> </value>
        public   Uri Urn
        {
            get
            {
                return this._urn;
            }
        }

        public  string ParentAgency
        {
            get
            {
                return this._parentAgency;
            }
        }

        public string ParentConcept
        {
            get
            {
                return this._parentConcept;
            }
        }

        #endregion
    }
}