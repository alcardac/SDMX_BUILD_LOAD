<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUploaderControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.FileUploaderControl" %>



<%@ Register TagPrefix="uc" TagName="CSVUploadControl" Src="~/Controls/CSVUploadControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="MultipleFileUploadControl" Src="~/Controls/MultipleFileUploadControl.ascx" %>


<div class="container">

    <div id="upload_notifier" class="notifier"></div>

    <div id="upload_tabs" class="innerContent">
        <ul>
            <li><a href="#tabs-1" class="fieldLabel">CSV</a></li>
            <li><a href="#tabs-2" class="fieldLabel">XML</a></li>
        </ul>
        <div id="tabs-1">
            <uc:CSVUploadControl ID="CSVUploadControl" runat="server"></uc:CSVUploadControl>
        </div>
        <div id="tabs-2">
            <uc:MultipleFileUploadControl ID="MultipleFileUploadControl" runat="server"  
            Text="<%# Resources.Messages.lbl_upload_file_xml_schema%>" 
            ServerDomain="<%# WSBuilder %>" 
            ServerPage="/UploadFileSDMXData" 
            NameParam="sdmxDataFiles"
            IDDivFile="sdmxDataFileUploader"
            ReloadOnUpload="false"
            ReportOnUpload="false" ></uc:MultipleFileUploadControl>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('#upload_tabs').tabs({ active: 0 });
</script>