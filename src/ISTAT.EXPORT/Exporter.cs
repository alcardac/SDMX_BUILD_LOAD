using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace ISTAT.EXPORT
{
    public class ContactRef
    {
        public string name = "alcardac";
        public string direction = "PSS -  Servizio Patrimonio informativo e sviluppo di prodotti";
        public string email = "alcardac@istat.it";
    }
    public class SecurityDef
    {
        public string userGroup = "ANBRUNI";
        public string domain = "PCISTAT";
    }
    public enum LocalisedKey { 
        en=1033,
        it=1036
    }

    public class DSDExporter
    {
        Org.Sdmxsource.Sdmx.Api.Model.Objects.ISdmxObjects sdmxObjects;

        //List<string> _dimensions;
        //List<string> _attributes;

        System.Xml.XmlDocument _xmlDoc;
        List<ISTAT.EXPORT.CodelistExporter> _codelistExport;

        public System.Xml.XmlDocument XMLDoc { get { return _xmlDoc; } }
        public List<ISTAT.EXPORT.CodelistExporter> ExporterCodelists { get { return _codelistExport; } }

        public DSDExporter(Org.Sdmxsource.Sdmx.Api.Model.Objects.ISdmxObjects sdmxObjects)
        {
            this.sdmxObjects = sdmxObjects;

            _xmlDoc = null;
            _codelistExport = null;
        }

        public bool CreateData(List<ContactRef> contacsNode,List<SecurityDef> securitiesNode,bool includeCommon=true,bool includeData=false)
        {
            if (this.sdmxObjects == null) return false;

            Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDataStructureObject _dsd = 
                this.sdmxObjects.DataStructures.First();

            System.Xml.XmlDocument xDom = new System.Xml.XmlDocument();
            
            #region Root node
            System.Xml.XmlElement _rootNode = xDom.CreateElement("OECD.STAT");
            _rootNode.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
            _rootNode.SetAttribute("xmlns:xsd", "http://www.w3.org/2001/XMLSchema");
            _rootNode.SetAttribute("Version", "1.0"); 
            #endregion

            #region Admin node

            System.Xml.XmlElement _adminNode = xDom.CreateElement("Admin");

            System.Xml.XmlElement _separatorNode = xDom.CreateElement("Separator");
            _separatorNode.InnerText = "|";
            _adminNode.AppendChild(_separatorNode);

            #region Contacts Node

            System.Xml.XmlElement _contactsNode = xDom.CreateElement("Contacts");
            foreach (ContactRef _conRef in contacsNode)
            {
                System.Xml.XmlElement _contactNode = xDom.CreateElement("Contact");
                System.Xml.XmlElement _nameNode = xDom.CreateElement("Name");
                _nameNode.InnerText = _conRef.name;
                System.Xml.XmlElement _directionNode = xDom.CreateElement("Direction");
                _directionNode.InnerText = _conRef.direction;
                System.Xml.XmlElement _emailNode = xDom.CreateElement("E-mail");
                _emailNode.InnerText = _conRef.email;
                System.Xml.XmlElement _languageNode = xDom.CreateElement("Language");
                _languageNode.InnerText = ((int)LocalisedKey.en).ToString();
                _contactNode.AppendChild(_nameNode);
                _contactNode.AppendChild(_directionNode);
                _contactNode.AppendChild(_emailNode);
                _contactNode.AppendChild(_languageNode);
                _contactsNode.AppendChild(_contactNode);
            }
            _adminNode.AppendChild(_contactsNode);

	        #endregion;

            #region Secutiry node

            System.Xml.XmlElement _securityNode = xDom.CreateElement("Security");

            foreach (SecurityDef _secRef in securitiesNode)
            {


                System.Xml.XmlElement _membershipNode = xDom.CreateElement("Membership");
                System.Xml.XmlElement _userGroupNode = xDom.CreateElement("UserGroup");
                _userGroupNode.InnerText = _secRef.userGroup;
                System.Xml.XmlElement _domainNode = xDom.CreateElement("Domain");
                _domainNode.InnerText = _secRef.domain;
                _membershipNode.AppendChild(_userGroupNode);
                _membershipNode.AppendChild(_domainNode);
                _securityNode.AppendChild(_membershipNode);

            }
            _adminNode.AppendChild(_securityNode);

            #endregion

            #endregion

            #region Dataset node
            System.Xml.XmlElement _datasetNode = xDom.CreateElement("Dataset");

            System.Xml.XmlElement _datasetNameNode_en = xDom.CreateElement("DatasetName");
            System.Xml.XmlElement _datasetNameLanguageNode_en = xDom.CreateElement("Language");
            _datasetNameLanguageNode_en.InnerText = ((int)LocalisedKey.en).ToString();
            System.Xml.XmlElement _datasetNameValueNode_en = xDom.CreateElement("Value");
            _datasetNameValueNode_en.AppendChild(xDom.CreateCDataSection((_dsd.Names.Count > 0 && _dsd.Names[0] != null) ? _dsd.Names[0].Value : string.Empty));
            _datasetNameNode_en.AppendChild(_datasetNameLanguageNode_en);
            _datasetNameNode_en.AppendChild(_datasetNameValueNode_en);

            System.Xml.XmlElement _datasetNameNode_it = xDom.CreateElement("DatasetName");
            System.Xml.XmlElement _datasetNameLanguageNode_it = xDom.CreateElement("Language");
            _datasetNameLanguageNode_it.InnerText = ((int)LocalisedKey.it).ToString();
            System.Xml.XmlElement _datasetNameValueNode_it = xDom.CreateElement("Value");
            _datasetNameValueNode_it.AppendChild(xDom.CreateCDataSection((_dsd.Names.Count > 1 && _dsd.Names[1] != null) ? _dsd.Names[1].Value : _dsd.Names[0].Value));
            _datasetNameNode_it.AppendChild(_datasetNameLanguageNode_it);
            _datasetNameNode_it.AppendChild(_datasetNameValueNode_it);

            _datasetNode.AppendChild(_datasetNameNode_en);
            _datasetNode.AppendChild(_datasetNameNode_it);

            System.Xml.XmlElement _codeNode = xDom.CreateElement("Code");
            _codeNode.InnerText = _dsd.Id;
            _datasetNode.AppendChild(_codeNode);

            System.Xml.XmlElement _actionNode = xDom.CreateElement("Action");
            _actionNode.InnerText = "CREATE";
            _datasetNode.AppendChild(_actionNode);

            System.Xml.XmlElement _updatequeriesNode = xDom.CreateElement("UpdateQueries");
            _updatequeriesNode.InnerText = "true";
            _datasetNode.AppendChild(_updatequeriesNode);

            System.Xml.XmlElement _themeNode = xDom.CreateElement("Theme");
            _themeNode.InnerText = "General Statistics|General Statistics";
            _datasetNode.AppendChild(_themeNode);

            System.Xml.XmlElement _directorateNode = xDom.CreateElement("Directorate");
            _directorateNode.InnerText = "STD";
            _datasetNode.AppendChild(_directorateNode);

            #endregion

            #region Dimensions node

            _codelistExport = new List<CodelistExporter>();

            System.Xml.XmlElement _dimsNode = xDom.CreateElement("Dimensions");

            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IDimension dim in _dsd.DimensionList.Dimensions)
            {
                if (dim.HasCodedRepresentation())
                {
                    ISet<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject> codelists =
                        sdmxObjects.GetCodelists(
                        new Org.Sdmxsource.Sdmx.Util.Objects.Reference.MaintainableRefObjectImpl()
                        {
                            AgencyId = dim.Representation.Representation.MaintainableReference.AgencyId,
                            MaintainableId = dim.Representation.Representation.MaintainableReference.MaintainableId,
                            Version = dim.Representation.Representation.MaintainableReference.Version
                        }
                        );
                    if (codelists != null &&  codelists.Count>0)
                    {
                        ISTAT.EXPORT.CodelistExporter exporter = new CodelistExporter(dim.Id, codelists.First());
                        exporter.CreateData(contacsNode);
                        _codelistExport.Add(exporter);
                        _dimsNode.AppendChild(exporter.Get_DimensionNode(xDom, codelists.First(), includeCommon, includeData));
                    }
                }
            }

            foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure.IAttributeObject att in _dsd.Attributes)
            {
                if (att.HasCodedRepresentation())
                {
                    ISet<Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject> codelists =
                        sdmxObjects.GetCodelists(
                        new Org.Sdmxsource.Sdmx.Util.Objects.Reference.MaintainableRefObjectImpl()
                        {
                            AgencyId = att.Representation.Representation.MaintainableReference.AgencyId,
                            MaintainableId = att.Representation.Representation.MaintainableReference.MaintainableId,
                            Version = att.Representation.Representation.MaintainableReference.Version
                        }
                        );
                    if (codelists != null && codelists.Count>0)
                    {
                        ISTAT.EXPORT.CodelistExporter exporter = new CodelistExporter(att.Id, codelists.First());
                        exporter.CreateData(contacsNode);
                        _codelistExport.Add(exporter);
                        _dimsNode.AppendChild(exporter.Get_DimensionNode(xDom, codelists.First(), includeCommon, includeData));
                    }
                }
            }

            System.Xml.XmlElement _dimensionCountNode = xDom.CreateElement("DimensionCount");
            _dimensionCountNode.InnerText = _codelistExport.Count.ToString();
            _datasetNode.AppendChild(_dimensionCountNode);

            _datasetNode.AppendChild(_dimsNode);

            #endregion

            _rootNode.AppendChild(_adminNode);
            _rootNode.AppendChild(_datasetNode);

            xDom.AppendChild(_rootNode);
            _xmlDoc = xDom;

            return true;

        }
    
    }

    public class CodelistExporter {

        Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject _codelist;
        string _code;

        System.Xml.XmlDocument _xmlDoc;
        string _dataFilename;
        List<string[]> _dataView;


        public System.Xml.XmlDocument XMLDoc { get { return _xmlDoc; } }
        public string Code { get { return _code; } }
        public string DataFilename { get { return _dataFilename; } }
        public List<string[]> DataView { get { return _dataView; } }

        public CodelistExporter(string code,Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist)
        {
            _codelist = codelist;
            _code = code;
            _xmlDoc = null;
            _dataFilename = string.Empty;
            _dataView = null;
        }

        public bool CreateData(List<ContactRef> contacsNode)
        {
            if (_codelist == null) return false;

            System.Xml.XmlDocument xDom = new System.Xml.XmlDocument();

            #region Root node
            System.Xml.XmlElement _rootNode = xDom.CreateElement("OECD.STAT");
            _rootNode.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
            _rootNode.SetAttribute("xmlns:xsd", "http://www.w3.org/2001/XMLSchema");
            _rootNode.SetAttribute("Version", "1.0");
            #endregion

            #region Admin node
            
            System.Xml.XmlElement _adminNode = xDom.CreateElement("Admin");

            System.Xml.XmlElement _separatorNode = xDom.CreateElement("Separator");
            _separatorNode.InnerText = "|";
            _adminNode.AppendChild(_separatorNode);

            #region Contacts Node

            System.Xml.XmlElement _contactsNode = xDom.CreateElement("Contacts");
            foreach (ContactRef _conRef in contacsNode)
            {
                System.Xml.XmlElement _contactNode = xDom.CreateElement("Contact");
                System.Xml.XmlElement _nameNode = xDom.CreateElement("Name");
                _nameNode.InnerText = _conRef.name;
                System.Xml.XmlElement _directionNode = xDom.CreateElement("Direction");
                _directionNode.InnerText = _conRef.direction;
                System.Xml.XmlElement _emailNode = xDom.CreateElement("E-mail");
                _emailNode.InnerText = _conRef.email;
                System.Xml.XmlElement _languageNode = xDom.CreateElement("Language");
                _languageNode.InnerText = ((int)LocalisedKey.en).ToString();
                _contactNode.AppendChild(_nameNode);
                _contactNode.AppendChild(_directionNode);
                _contactNode.AppendChild(_emailNode);
                _contactNode.AppendChild(_languageNode);
                _contactsNode.AppendChild(_contactNode);
            }

            _adminNode.AppendChild(_contactsNode);

            #endregion;

            #endregion

            #region Dataset node
            System.Xml.XmlElement _datasetNode = xDom.CreateElement("Dataset");
            System.Xml.XmlElement _datasetNameNode_en = xDom.CreateElement("DatasetName");
            System.Xml.XmlElement _datasetNameLanguageNode_en = xDom.CreateElement("Language");
            _datasetNameLanguageNode_en.InnerText = ((int)LocalisedKey.en).ToString();
            System.Xml.XmlElement _datasetNameValueNode_en = xDom.CreateElement("Value");
            _datasetNameValueNode_en.AppendChild(xDom.CreateCDataSection("common dimension"));
            _datasetNameNode_en.AppendChild(_datasetNameLanguageNode_en);
            _datasetNameNode_en.AppendChild(_datasetNameValueNode_en);
            _datasetNode.AppendChild(_datasetNameNode_en);

            System.Xml.XmlElement _datasetNameNode_it = xDom.CreateElement("DatasetName");
            System.Xml.XmlElement _datasetNameLanguageNode_it = xDom.CreateElement("Language");
            _datasetNameLanguageNode_it.InnerText = ((int)LocalisedKey.it).ToString();
            System.Xml.XmlElement _datasetNameValueNode_it = xDom.CreateElement("Value");
            _datasetNameValueNode_it.AppendChild(xDom.CreateCDataSection("dimension commune"));
            _datasetNameNode_it.AppendChild(_datasetNameLanguageNode_it);
            _datasetNameNode_it.AppendChild(_datasetNameValueNode_it);
            _datasetNode.AppendChild(_datasetNameNode_it);


            System.Xml.XmlElement _codeNode = xDom.CreateElement("Code");
            _codeNode.InnerText = "commondimension";
            _datasetNode.AppendChild(_codeNode);

            System.Xml.XmlElement _actionNode = xDom.CreateElement("Action");
            _actionNode.InnerText = "CREATE";
            _datasetNode.AppendChild(_actionNode);

            System.Xml.XmlElement _dimensionCountNode = xDom.CreateElement("DimensionCount");
            _dimensionCountNode.InnerText = "1";
            _datasetNode.AppendChild(_dimensionCountNode);
            #endregion

            #region Dimension node


            System.Xml.XmlElement _dimsNode = xDom.CreateElement("Dimensions");
            _dimsNode.AppendChild(Get_DimensionNode(xDom, _codelist, true, true));
            _datasetNode.AppendChild(_dimsNode);

            #endregion

            System.Xml.XmlElement _inlineNode = xDom.CreateElement("Inline");
            _inlineNode.InnerText = "false";
            _datasetNode.AppendChild(_inlineNode);
            
            System.Xml.XmlElement _microDataNode = xDom.CreateElement("MicroInfoDataCount");
            _microDataNode.InnerText = "0";
            _datasetNode.AppendChild(_microDataNode);
            
            System.Xml.XmlElement _microTable = xDom.CreateElement("MicroTableDataCount");
            _microTable.InnerText = "0";
            _datasetNode.AppendChild(_microTable);

            _rootNode.AppendChild(_adminNode);
            _rootNode.AppendChild(_datasetNode);

            xDom.AppendChild(_rootNode);

            _xmlDoc = xDom;

            return true;

        }

        public XmlElement Get_DimensionNode(XmlDocument xDom, Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICodelistObject codelist, bool includeCommon, bool includeData){
        
            System.Xml.XmlElement _dimNode = xDom.CreateElement("Dimension");
            
            System.Xml.XmlElement _dimNameNode_en = xDom.CreateElement("DimensionName");
            System.Xml.XmlElement _dimNameLanguageNode_en = xDom.CreateElement("Language");
            System.Xml.XmlElement _dimNameValueNode_en = xDom.CreateElement("Value");
            _dimNameLanguageNode_en.InnerText =((int)LocalisedKey.en).ToString();
            _dimNameValueNode_en.AppendChild(xDom.CreateCDataSection((codelist.Names.Count > 0 && codelist.Names[0] != null) ? codelist.Names[0].Value : string.Empty));
            _dimNameNode_en.AppendChild(_dimNameLanguageNode_en);
            _dimNameNode_en.AppendChild(_dimNameValueNode_en);
            
            System.Xml.XmlElement _dimNameNode_it = xDom.CreateElement("DimensionName");
            System.Xml.XmlElement _dimNameLanguageNode_it = xDom.CreateElement("Language");
            System.Xml.XmlElement _dimNameValueNode_it = xDom.CreateElement("Value");
            _dimNameLanguageNode_it.InnerText =((int)LocalisedKey.it).ToString();
            _dimNameValueNode_it.AppendChild(xDom.CreateCDataSection((codelist.Names.Count > 1 && codelist.Names[1] != null) ? codelist.Names[1].Value :  codelist.Names[0].Value));
            _dimNameNode_it.AppendChild(_dimNameLanguageNode_it);
            _dimNameNode_it.AppendChild(_dimNameValueNode_it);
            
            _dimNode.AppendChild(_dimNameNode_en);
            _dimNode.AppendChild(_dimNameNode_it);

            System.Xml.XmlElement _dimcodeNode = xDom.CreateElement("Code");
            _dimcodeNode.InnerText = _code;
            _dimNode.AppendChild(_dimcodeNode);

            if(includeCommon){
                System.Xml.XmlElement _dimcommonNode = xDom.CreateElement("Common");
                _dimcommonNode.InnerText = _code;
                _dimNode.AppendChild(_dimcommonNode);
            }
            if(includeData){
                System.Xml.XmlElement _datastructureNode = xDom.CreateElement("DataStructure");
                System.Xml.XmlElement _key = xDom.CreateElement("Key");
                _key.InnerText = "1";
                System.Xml.XmlElement _nameNode_en = xDom.CreateElement("NameEN");
                _nameNode_en.InnerText = "2";
                System.Xml.XmlElement _nameNode_it = xDom.CreateElement("NameFR");
                _nameNode_it.InnerText = "3";
                System.Xml.XmlElement _orderNode = xDom.CreateElement("Order");
                _orderNode.InnerText = "4";

                _datastructureNode.AppendChild(_key);
                _datastructureNode.AppendChild(_nameNode_en);
                _datastructureNode.AppendChild(_nameNode_it);
                _datastructureNode.AppendChild(_orderNode);
                _dimNode.AppendChild(_datastructureNode);

                string dataFilename = _code + ".csv";
                List<string[]> dataView = new List<string[]>();
                int order=10;
                foreach (Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist.ICode code in codelist.Items) {
                    string[] dataRow ={
                                      code.Id,
                                      (code.Names.Count>0 && code.Names[0]!=null)?code.Names[0].Value:string.Empty,
                                      (code.Names.Count>1 && code.Names[1]!=null)?code.Names[1].Value:code.Names[0].Value,
                                      order.ToString()
                                      };
                    dataView.Add(dataRow);
                    order += 10;
                }
                System.Xml.XmlElement _dimensionData = xDom.CreateElement("DimensionData");
                _dimensionData.AppendChild(xDom.CreateCDataSection(".//CSVFILES//" + dataFilename));
                _dimNode.AppendChild(_dimensionData);

                System.Xml.XmlElement _dimensionDataCount = xDom.CreateElement("DimensionDataCount");
                _dimensionDataCount.InnerText = codelist.Items.Count.ToString();
                _dimNode.AppendChild(_dimensionDataCount);


                _dataFilename = dataFilename;
                _dataView = dataView;

            }
            return _dimNode;
        }

    }

}
