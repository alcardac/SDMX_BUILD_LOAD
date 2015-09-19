<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="SDMX_Dataloader.Main.Profile" %>

<%@ Register TagPrefix="uc" TagName="UserControl" Src="~/Controls/UserControl.ascx" %>
<%@ Register TagPrefix="uc" TagName="ManagerUserControl" Src="~/Controls/ManagerUserControl.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
<!-- main content -->

<div class="section ui-widget ui-widget-content ui-corner-all"> 
          
    <h2><%= Resources.Messages.lbl_widget_profile %> 
         <a class="singleLabel onRight" href="./Loader"><%= Resources.Messages.lbl_loader %></a>
        <% if(ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser,ISTAT.ENTITY.UserDef.ActionDef.CRUDSchema)) {%>
            <a class="singleLabel onRight" href="./Builder"><%= Resources.Messages.lbl_builder%></a>
        <% } %>
    </h2>
                     
    <div class="innerContent">

        <div id="profile_tabs" class="innerContent">

	        <ul>
		        <li><a href="#tabs-1" class="fieldLabel"><%= Resources.Messages.lbl_page_profile%></a></li>
                <li><a href="#tabs-2" class="fieldLabel"><%= Resources.Messages.lbl_man_profile %></a></li>
	        </ul>
	        <div id="tabs-1">
                <uc:UserControl ID="UserControl" runat="server"></uc:UserControl>
            </div>    
	        <div id="tabs-2">
                <uc:ManagerUserControl ID="ManagerUserControl" runat="server"></uc:ManagerUserControl>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">


    $("#profile_tabs").tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $("#profile_tabs li").removeClass("ui-corner-top").removeClass("ui-corner-right").removeClass("ui-corner-left");
                      

    <% if(!ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser, ISTAT.ENTITY.UserDef.ActionDef.CRUDDomain)){ %>    
        $( "#profile_tabs" ).tabs( "option", "disabled", [ 1 ] );
    <% } %>

</script>

</asp:Content>

