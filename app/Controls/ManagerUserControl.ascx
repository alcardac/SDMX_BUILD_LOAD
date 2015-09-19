<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManagerUserControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.ManagerUserControl" %>

<%@ Register TagPrefix="uc" TagName="UserControl" Src="~/Controls/UserControl.ascx" %> 
<%@ Register TagPrefix="uc" TagName="DomainControl" Src="~/Controls/DomainControl.ascx" %>

<div id="manprofile_notifier" class="notifier"></div>

<div id="newProfilePopUp" style="display:none">
    <uc:UserControl ID="NewUserControl" runat="server"></uc:UserControl>
</div>
       
<div id="domain_popup" style="display:none"></div>

<a id="BtmProfileAdd" href="#"><%= Resources.Messages.lbl_add%></a> 

<table class="usersTable table_container">
    <tr>
        <th class="twentyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_name %></p></th>
        <th class="twentyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_role %></p></th>
        <th class="twentyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_email %></p></th>  
        <th class="twentyfive"></th>
    </tr>

<% if (this.Users!=null) foreach (ISTAT.ENTITY.UserDef user in this.Users)
        {%>
       
    <tr id="userRow_<%= user.ID  %>">
        <td><p><%= user.Surname + " " + user.Name %> (<%= user.Username %>)</p></td>
        <td><p><%= user.Role.ToString() %> <%= (user.ProFlag)?"(Pro)":""%></p></td>
        <td><p><%= user.Email.ToString() %></p></td>
       
    <% if (user.ID != SDMX_Dataloader.Main.Global.LoggedUser.ID)
       { %>
        <td>
            <% if (user.Role != ISTAT.ENTITY.UserDef.RoleDef.Administrator)
               { %>
                    <a class="grpBtmProfileView" href="#" onclick="actionBtmView('<%= user.ID  %>')" ><%= Resources.Messages.lbl_domain%></a> 
                    <a class="grpBtmProfileDelete" href="#" onclick="actionBtmDelete('<%= user.ID  %>')" ><%= Resources.Messages.lbl_delete%></a>
            <% }
               else if (SDMX_Dataloader.Main.Global.LoggedUser.Role == ISTAT.ENTITY.UserDef.RoleDef.Administrator){ %>
                    <a class="grpBtmProfileView" href="#" onclick="actionBtmView('<%= user.ID  %>')" ><%= Resources.Messages.lbl_domain%></a> 
                    <a class="grpBtmProfileDelete" href="#" onclick="actionBtmDelete('<%= user.ID  %>')" ><%= Resources.Messages.lbl_delete%></a>
            <% } %>
        </td>
    <% }else{ %>
        <td></td>
    <% } %>
    </tr>


<% } %>
    

</table>

<link rel="stylesheet" href="jquery/jquery-jstree/themes/default/style.min.css" />
<script type="text/javascript" src="jquery/jquery-jstree/jstree.min.js"></script>
<script type="text/javascript">
      
    function IsEmail(email) {
      var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
      return regex.test(email);
    }
                         
    $(".grpBtmProfileView").button();

    <% if(ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser, ISTAT.ENTITY.UserDef.ActionDef.CRUDProfile)){ %> 
    
    $(".grpBtmProfileDelete").button();

    <% }else{ %>

    $(".grpBtmProfileDelete").button({ disabled: true });

    <% } %>

    <% if(ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser, ISTAT.ENTITY.UserDef.ActionDef.CRUDProfile)){ %> 
    
    $("#BtmProfileAdd").button();

    <% }else{ %>

    $("#BtmProfileAdd").button({ disabled: true });

    <% } %>
    $("#BtmProfileAdd").click(function(){

        $("#newProfilePopUp").dialog({
            title: "<%= Resources.Messages.lbl_new_user%>",
            position: { my: "center", at: "center", of: window },
            resizable: false,
            width:620,
            height:400,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {

                    var _username=$("#newProfilePopUp #txtUser").val();   
                    var _password=$("#newProfilePopUp #txtPsw").val();   
                    var _password2=$("#newProfilePopUp #txtPsw2").val(); 
                    var _role=$("#newProfilePopUp #cmbRole option:selected").index();
                    var _pro=$("#newProfilePopUp #chkPro").prop('checked');
                    var _name=$("#newProfilePopUp #txtName").val();
                    var _surname=$("#newProfilePopUp #txtSurname").val();  
                    var _email=$("#newProfilePopUp #txtEmail").val();

                    var _errorMessages = "";
                    var _errCounter = 0;

                    if($.trim(_username) == "")
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_add_username%><br>";

                    if($.trim(_password) == "")
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_add_password%><br>";

                    if(_password!=_password2)
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_password_not_match%><br>";

                    if($.trim(_name) == "")
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_add_name%><br>";

                    if($.trim(_surname) == "")
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_add_surname%><br>";

                    if($.trim(_email) == "")
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_add_email%><br>";

                    if(!IsEmail(_email))
                        _errorMessages = _errorMessages + ++_errCounter + ") <%= Resources.Messages.msg_not_valid_email%><br>";


                    if($.trim(_errorMessages) != "")
                    {
                        var divErrors = document.createElement('div');
                        $(divErrors).addClass('widget ui-widget-content ui-corner-bottom');

                        $(divErrors).append(_errorMessages);

                        $(divErrors).dialog({
                            title: "ValidationError",
                            position: { my: "center", at: "center", of: window },
                            //dialogClass: "no-close",
                            autoOpen: false,
                            draggable: false,
                            modal: true,
                            closeOnEscape: true
                        });
                        $(divErrors).dialog("open");
                        return;
                    }
                        
                    //if(_password===_password2){
                        var data =  {
                            id:-1,
                            username:_username,
                            password:_password,   
                            role:_role,
                            pro:_pro,
                            name:_name,
                            surname:_surname,
                            email:_email,
                        };

                        var _ajaxRequestMan=new AjaxRequestManager({
                        baseUrl:"<%= WSProfile %>",
                        method:"InsertProfile",
                        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                        },{
                            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                        });

                        _ajaxRequestMan.SendRequest(
                        data,
                        function(jsonResult){
                            
                            var userRow= document.createElement('tr');

                            $(userRow).attr('ID', "userRow_"+jsonResult.ID);
                            
                            $(userRow).append('<td><p>'+jsonResult.Surname+' '+jsonResult.Name+' ('+jsonResult.Username+')</p></td>');   
                            $(userRow).append('<td><p>'+jsonResult.Role+' '+((jsonResult.ProFlag)?'(Pro)':'')+'</p></td>');    
                            $(userRow).append('<td><p>'+jsonResult.Email+'</p></td>');
                            $(userRow).append('<td><a class="grpBtmProfileView" href="#" onclick="actionBtmView('+jsonResult.ID+')"><%= Resources.Messages.lbl_domain%></a><a class="grpBtmProfileDelete" href="#" onclick="actionBtmDelete('+jsonResult.ID+')"><%= Resources.Messages.lbl_delete%></a></td>');
                            
                            $(".usersTable").append(userRow);

                            $(".grpBtmProfileDelete").button();
                            $(".grpBtmProfileView").button();

                            $("#newProfilePopUp #txtUser").val("");   
                            $("#newProfilePopUp #txtPsw").val("");   
                            $("#newProfilePopUp #txtPsw2").val(""); 
                            $("#newProfilePopUp #txtName").val("");
                            $("#newProfilePopUp #txtSurname").val("");  
                            $("#newProfilePopUp #txtEmail").val("");

                        },
                        function(msg){
                            
                        },
                        function(msg){
                            _layoutManager.EnableLoadingDialog();
                        },
                        function(msg){
                            _layoutManager.DisableLoadingDialog();
                        },
                            true);
//                    }else{
//                    }
                    $( this ).dialog( "close" );
                },
                Cancel: function() {
                    $( this ).dialog( "close" );
                }
          }
        });

    });

    function actionBtmDelete(index){

    var popupConfirm=document.createElement('div');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_delete_user_confirm %>",
            position: { my: "center", at: "center", of: window },
            resizable: true,
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    
                    var data = {
                        id:index
                    };

                    var _ajaxRequestMan=new AjaxRequestManager(
                    {
                        baseUrl:"<%= WSProfile %>",
                        method:"DeleteProfile",
                        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                    },
                    {
                        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                    });

                    _ajaxRequestMan.SendRequest(
                    data,
                    function(jsonResult){
                        $("#userRow_"+index).remove();
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

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

    }

    function actionBtmView(index){
  
                        
        var domainTreeView=document.createElement('div');
        $('#domain_popup').empty();

        $('#domain_popup').dialog({
            title: "<%= Resources.Messages.lbl_set_domain %>",
            position: { my: "center", at: "center", of: window },
            resizable: true,
            width:400,
            height:300,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {

                var checked_obj = $(domainTreeView).jstree(true).get_checked(false);

                var themes=[];
                var structures=[];

                $.each(checked_obj, function(i,data){
                    if(data.substring(0,3)=="ds_") structures.push(data.substring(3,data.length));
                    else themes.push(data);
                });

                var data={
                    'idUser': index,
                    'urnThemes': themes,
                    'idDomainsStructure': structures
                };

                var _ajaxRequestMan=new AjaxRequestManager({
                    baseUrl:"<%= WSProfile %>",
                    method:"SetDomains",
                    locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                },{
                    titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                    messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                });

                _ajaxRequestMan.SendRequest(
                    data,
                    function(jsonResult){          

                    },
                    function(msg){
                
                    },
                    function(msg){
                        _layoutManager.EnableLoadingDialog();
                    },
                    function(msg){
                        _layoutManager.DisableLoadingDialog();
                    },
                    true);
                                                  
                    $( this ).dialog( "close" );
                    $(domainTreeView).remove();

                },
                Cancel: function() {
                    $( this ).dialog( "close" );
                    $(domainTreeView).remove();
                }
            }
        });

        $(domainTreeView).jstree({
            'core': {
                'data': {
                    'url': '<%= WSProfile %>/GetDomains',
                    'data': function (node) {
                        return { 'idUser': index ,'stub':false };
                    }
                }
            },
            'checkbox': {
                'keep_selected_style': false
            },
            'plugins': ["wholerow", "checkbox"]
        });
                                 
        $(domainTreeView).appendTo($('#domain_popup'));
    }

</script>