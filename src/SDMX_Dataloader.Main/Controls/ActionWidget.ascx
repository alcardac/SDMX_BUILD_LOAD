<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ActionWidget.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.ActionWidget" %>

<% if (SDMX_Dataloader.Main.Global.LoggedUser != null) { %>
<div class="widget ui-widget ui-widget-content ui-corner-bottom">
    <h3 class="ui-widget-header"><%= Resources.Messages.lbl_widget_action %></h3>
    <ul> 
        <%  
                   
            string url_loader = System.Configuration.ConfigurationManager.AppSettings["pageLoaderRedirect"].ToString();
            string url_import=System.Configuration.ConfigurationManager.AppSettings["pageImportRedirect"].ToString();

            SDMX_Dataloader.Engine.Client client = HttpContext.Current.Session[ISTAT.ENTITY.UserDef.UserSessionKey] as SDMX_Dataloader.Engine.Client;
            if (ISTAT.ENTITY.UserDef.UserCan(client.LoggedUser,ISTAT.ENTITY.UserDef.ActionDef.CRUDDataset)){ %>
        <li><a href="<%= ResolveUrl(url_import) %>"><%= Resources.Messages.lbl_import %></a></li>
        <%  } %>

        <li><a href="<%= ResolveUrl(url_loader) %>">Loader</a></li>

    </ul>
</div>
<%} %>