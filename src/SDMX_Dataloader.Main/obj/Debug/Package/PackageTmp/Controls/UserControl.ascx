<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.UserControl" %>

<table class="table_container">
    <tr>
        <td class="twentyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_id %></p></td>
        <td class="fivety"><p class="fieldLabel"><%= Resources.Messages.lbl_username %></p></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtId" ClientIDMode="Static" runat="server" TextMode="SingleLine" Text=""></asp:TextBox></td>
        <td><asp:TextBox ID="txtUser" ClientIDMode="Static"  runat="server" TextMode="SingleLine" Text=""></asp:TextBox></td>
            
    </tr>
    <tr>
        <td><p class="fieldLabel"><%= Resources.Messages.lbl_role %></p></td>  
        <td><p class="fieldLabel"><%= Resources.Messages.lbl_prouser %></p></td>
    </tr>  
    <tr>
        <td><asp:DropDownList ID="cmbRole" ClientIDMode="Static" runat="server"></asp:DropDownList></td>  
        <td><asp:CheckBox ID="chkPro" ClientIDMode="Static" runat="server"/></td>
    </tr>
</table>
    
<table class="table_container">
    <tr>
        <td class="fivety"><p class="fieldLabel"><%= Resources.Messages.lbl_password %></p></td>
        <td class="fivety"><p class="fieldLabel"><%= Resources.Messages.lbl_password_repeat%></p></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtPsw" ClientIDMode="Static"  runat="server" TextMode="Password" Text=""></asp:TextBox></td>
        <td><asp:TextBox ID="txtPsw2" ClientIDMode="Static"  runat="server" TextMode="Password" Text=""></asp:TextBox></td>
    </tr>
    <% if (Modality == UserControlMode.Edit)
        { %>
    <tr>
        <td></td>
        <td><a class="grpBtmPasswordChange" href="#" ><%= Resources.Messages.lbl_password_change%></a></td>
    </tr>
    <% } %>
</table>

<table class="table_container">
    <tr>
        <td class="fivety"><p class="fieldLabel"><%= Resources.Messages.lbl_name %></p></td>
        <td class="fivety"><p class="fieldLabel"><%= Resources.Messages.lbl_surname %></p></td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtName" ClientIDMode="Static"  runat="server" TextMode="SingleLine" Text=""></asp:TextBox></td>
        <td><asp:TextBox ID="txtSurname" ClientIDMode="Static"  runat="server" TextMode="SingleLine" Text=""></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan="2"><p class="fieldLabel"><%= Resources.Messages.lbl_email %></p></td>
    </tr>
    <tr>
        <td colspan="2"><asp:TextBox ID="txtEmail" ClientIDMode="Static"  runat="server" TextMode="SingleLine" Text=""></asp:TextBox></td>
    </tr>
    <% if (Modality == UserControlMode.Edit) { %>
    <tr>
        <td></td>
        <td><a class="grpBtmProfileEdit" href="#" ><%= Resources.Messages.lbl_edit%></a></td>
    </tr>
    <% } %>
</table>

<script type="text/javascript">

    $(".grpBtmProfileEdit").button();
    $(".grpBtmProfileEdit").click(function(){

        var data = {
            name:$('#<%= txtName.ClientID %>').val(),
            surname:$('#<%= txtSurname.ClientID %>').val(),
            email:$('#<%= txtEmail.ClientID %>').val()
        };

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSProfile %>",
            method:"UpdateProfile",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>",

        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });
        _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){
            location.reload();
        },
        function(msg){
            _layoutManager.ReportError('#profile_notifier',msg,false);
        },
        function(){
            _layoutManager.EnableLoadingDialog();
        },
        function(){
            _layoutManager.DisableLoadingDialog();
        },
        true);

        return false;

    });

    $(".grpBtmPasswordChange").button();
    $(".grpBtmPasswordChange").click(function(){

        var _psw=$('#<%=txtPsw.ClientID %>').val();
        var _psw2=$('#<%=txtPsw2.ClientID %>').val();

        if(_psw!=_psw2){
            return false;
        }

        var data = {
            code:_psw
        };

        var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSProfile %>",
                method:"ChangePasswordProfile",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },
            {
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });
        
        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                $('#<%=txtPsw.ClientID %>').val("");
                $('#<%=txtPsw2.ClientID %>').val("");
            },
            function(msg){
                
            },
            function(){
                _layoutManager.EnableLoadingDialog();
            },
            function(){
                _layoutManager.DisableLoadingDialog();   
            },
            true);
            
        return false;

    });
        

</script>