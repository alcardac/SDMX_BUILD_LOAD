<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserWidget.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.UserWidget" %>

<div class="user-menu">
<% if(SDMX_Dataloader.Main.Global.LoggedUser==null){ %>
    <a href="./Login"><%= Resources.Messages.lbl_login %></a>
    <a href="./Retrive"><%= Resources.Messages.lbl_retrive%></a>

<% }else{ %>
    <p><span class="fieldLabel"><%=SDMX_Dataloader.Main.Global.LoggedUser.Username %></span> (<%=SDMX_Dataloader.Main.Global.LoggedUser.Role.ToString() %> <%= (SDMX_Dataloader.Main.Global.LoggedUser.ProFlag)?"Pro":"" %> )</p>
    <a class="singleLabel" href="./Profile">Profilo</a>
    <a class="singleLabel" href="#" onclick="logout();">Logout</a>
<%} %>


<a id="about-version" href="#" title="About">About</a>


</div>
<script type="text/javascript">

function logout() {


    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSProfile %>",
        method:"Logout",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
    null,
    function(jsonResult){
        location.reload();
    },
    function(msg){
        _layoutManager.EnableLoadingDialog();
    },
    function(){
        _layoutManager.DisableLoadingDialog();
    },
    function(){
                    
    },
    true);
    return false;
}

$('#about-version').click(function () {
    
    var divContainer = document.createElement('div');
            
    $(divContainer).append('<p><span>Engine</span> V<%= SDMX_Dataloader.Engine.Utility.Version_major %>.<%= SDMX_Dataloader.Engine.Utility.Version_intermediate %>.<%= SDMX_Dataloader.Engine.Utility.Version_lower %></p>');
    $(divContainer).append('<p><span>Dissemination archive</span> V<%= ISTAT.DBDAL.DataAccess.Version_major %>.<%= ISTAT.DBDAL.DataAccess.Version_intermediate %>.<%= ISTAT.DBDAL.DataAccess.Version_lower %></p>');
    $(divContainer).append('<p><span>Metadata archive</span> V<%= ISTAT.DBDAL.DataSDMX.Version_major %>.<%= ISTAT.DBDAL.DataSDMX.Version_intermediate %>.<%= ISTAT.DBDAL.DataSDMX.Version_lower %></p>');
            
    $(divContainer).dialog({
        title: "<%= Resources.Messages.app_title %> - About",
        dialogClass: "no-close",
        position: { my: "center", at: "center", of: window },
        resizable: false,
        width: 240,
        height: 180,
        modal: true,
        autoOpen: true,
        draggable: false,
        closeOnEscape: false,
        buttons: {
            "OK": function () {
                $(this).dialog("close");
            }
        }
    });

});
</script>