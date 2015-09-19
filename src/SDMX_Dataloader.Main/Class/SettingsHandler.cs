using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace SDMX_Dataloader.Main.Settings
{
    public class MailSettingsHandler : ConfigurationSection
    {
        [ConfigurationProperty("smtpHost", DefaultValue = "smtp.gmail.com", IsRequired = true)]
        public string SmtpHost
        {
            get
            { return (string)this["smtpHost"]; }
            set
            { this["smtpHost"] = value; }
        }
        [ConfigurationProperty("smtpPort", DefaultValue = 465, IsRequired = true)]
        public int SmtpPort
        {
            get
            { return (int)this["smtpPort"]; }
            set
            { this["smtpHost"] = value; }
        }
        [ConfigurationProperty("smtpSsl", DefaultValue = true, IsRequired = true)]
        public bool SmtpSsl
        {
            get
            { return (bool)this["smtpSsl"]; }
            set
            { this["smtpSsl"] = value; }
        }
        [ConfigurationProperty("mailFrom", DefaultValue = "admin@admin.com", IsRequired = true)]
        public string MailFrom
        {
            get
            { return (string)this["mailFrom"]; }
            set
            { this["mailFrom"] = value; }
        }
        [ConfigurationProperty("mailFromName", DefaultValue = "admin", IsRequired = true)]
        public string MailFromName
        {
            get
            { return (string)this["mailFromName"]; }
            set
            { this["mailFromName"] = value; }
        }
        [ConfigurationProperty("mailFromPassword", DefaultValue = "", IsRequired = true)]
        public string MailFromPassword
        {
            get
            { return (string)this["mailFromPassword"]; }
            set
            { this["mailFromPassword"] = value; }
        } 
    }

    public class FilesSectionHandler : ConfigurationSection
    {

        [ConfigurationProperty("Files",IsDefaultCollection = false)]
        public FilesCollection Files
        {
            get
            {
                FilesCollection filesCollection =
                (FilesCollection)base["Files"];
                return filesCollection;
            }
        }

        protected override void DeserializeSection(System.Xml.XmlReader reader)
        {
            base.DeserializeSection(reader);
            // You can add custom processing code here.
        }

        protected override string SerializeSection(ConfigurationElement parentElement,string name, ConfigurationSaveMode saveMode)
        {
            string s =
                base.SerializeSection(parentElement,
                name, saveMode);
            // You can add custom processing code here. 
            return s;
        }

    }

    public class FilesCollection : ConfigurationElementCollection {
        
        public FilesCollection() {

        }
        
        public override ConfigurationElementCollectionType CollectionType
        {
            get
            {
                return

                    ConfigurationElementCollectionType.AddRemoveClearMap;
            }
        }

        protected override
            ConfigurationElement CreateNewElement()
        {
            return new FileConfigElement();
        }


        protected override
            ConfigurationElement CreateNewElement(
            string elementName)
        {
            return new FileConfigElement(elementName);
        }

        protected override Object GetElementKey(ConfigurationElement element)
        {
            return ((FileConfigElement)element).FilePath;
        }

        public new string AddElementName
        {
            get
            { return base.AddElementName; }

            set
            { base.AddElementName = value; }

        }

        public new string ClearElementName
        {
            get
            { return base.ClearElementName; }

            set
            { base.ClearElementName = value; }

        }

        public new string RemoveElementName
        {
            get
            { return base.RemoveElementName; }
        }

        public new int Count
        {
            get { return base.Count; }
        }

        public FileConfigElement this[int index]
        {
            get
            {
                return (FileConfigElement)BaseGet(index);
            }
            set
            {
                if (BaseGet(index) != null)
                {
                    BaseRemoveAt(index);
                }
                BaseAdd(index, value);
            }
        }

        new public FileConfigElement this[string filePath]
        {
            get
            {
                return (FileConfigElement)BaseGet(filePath);
            }
        }

        public int IndexOf(FileConfigElement filePathElement)
        {
            return BaseIndexOf(filePathElement);
        }

        public void Add(FileConfigElement filePathElement)
        {
            BaseAdd(filePathElement);
            // Add custom code here.
        }

        protected override void BaseAdd(ConfigurationElement element)
        {
            BaseAdd(element, false);
            // Add custom code here.
        }

        public void Remove(FileConfigElement filePathElement)
        {
            if (BaseIndexOf(filePathElement) >= 0)
                BaseRemove(filePathElement.FilePath);
        }

        public void RemoveAt(int index)
        {
            BaseRemoveAt(index);
        }

        public void Remove(string name)
        {
            BaseRemove(name);
        }

        public void Clear()
        {
            BaseClear();
            // Add custom code here.
        }
    }

    public class FileConfigElement : ConfigurationElement {
        public FileConfigElement(string filePath) {
            FilePath = filePath;
        }
        public FileConfigElement()
        {
        }
        [ConfigurationProperty("FilePath",
            IsRequired = true,
            IsKey = true)]
        public string FilePath
        {
            get
            {
                return (string)this["FilePath"];
            }
            set
            {
                this["FilePath"] = value;
            }
        }

    }

}