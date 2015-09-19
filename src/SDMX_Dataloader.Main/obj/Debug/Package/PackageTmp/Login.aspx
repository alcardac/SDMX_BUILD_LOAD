<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SDMX_Dataloader.Main.Login" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="content" runat="server">

    <div class="notification">

        <% if(HasError){ %>
            <div class="ui-widget">
	            <div class="ui-state-error ui-corner-all">
                    <% foreach (string err in Errors)
                    { %>
	                <p><span class="ui-icon ui-icon-alert"></span>
                        <%= err %>
                    </p>
                    <% } %>
	            </div>
            </div>
        <% }
           else if (HasMessage)
           { %>
            <div class="ui-widget">
                <div class="ui-state-highlight ui-corner-all">
	                <% foreach (string msg in Messages)
                    { %>
	                <p><span class="ui-icon ui-icon-info"></span>
                        <%= msg %>
                    </p>
                    <% } %>
                </div>
            </div>
        <% } %>
    
    </div>
    
    <div class="section ui-widget ui-widget-content ui-corner-all">  
        <p class="fieldLabel"><%= Resources.Messages.lbl_username %></p>
        <asp:TextBox ID="txtuser" runat="server" TextMode="SingleLine" TabIndex="1"></asp:TextBox>
        <p class="fieldLabel"><%= Resources.Messages.lbl_password%></p>
        <asp:TextBox ID="txtpsw" runat="server" TextMode="Password"  TabIndex="2"></asp:TextBox>
        <a href="#" id="btmlogin"><span class="ui-icon ui-icon-locked" TabIndex="3"></span><%= Resources.Messages.lbl_login %></a>
    </div>

    <script type="text/javascript">
        $('#btmlogin').button();
        $('#btmlogin').click(function () {

            $("#wrapper").submit();

        });


    </script>

</asp:Content>
