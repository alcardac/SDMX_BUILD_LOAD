<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Retrive.aspx.cs" Inherits="SDMX_Dataloader.Main.Retrive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    
    <div class="notifier">

        <% if(HasError){ %>
            <div class="ui-state-error ui-corner-all">
                <% foreach (string err in Errors)
                { %>
	            <p><span class="ui-icon ui-icon-alert"></span>
                    <%= err %>
                </p>
                <% } %>
	        </div>
        <% } %>

        <% if (HasMessage){ %>
            <div class="ui-state-highlight ui-corner-all">
	            <% foreach (string msg in Messages)
                { %>
	            <p><span class="ui-icon ui-icon-info"></span>
                    <%= msg %>
                </p>
                <% } %>
            </div>
        <% } %>
    
    </div>

    <div class="section ui-widget ui-widget-content ui-corner-all">  
        <p class="fieldLabel"><%= Resources.Messages.lbl_email %></p>
        <asp:TextBox TextMode="SingleLine" ID="txtemail" runat="server"></asp:TextBox>
        <input id="btmRetrive" type="submit" runat="server" value="<%# Resources.Messages.lbl_retrive %>"/>
    </div>

    <script type="text/javascript">
        $('#<%=btmRetrive.ClientID %>').button();

        $('#<%=btmRetrive.ClientID %>').click(function () {
            $(this).button("option", "disabled", true);
        });

    </script>

</asp:Content>
