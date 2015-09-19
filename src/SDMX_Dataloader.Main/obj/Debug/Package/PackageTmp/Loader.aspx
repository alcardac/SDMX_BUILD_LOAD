<%@ Page Title="" 
Language="C#" 
MasterPageFile="~/Site.Master" 
AutoEventWireup="true" 
CodeBehind="Loader.aspx.cs" 
Inherits="SDMX_Dataloader.Main.Loader" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="content" runat="server">

<% bool enableEmail = (System.Configuration.ConfigurationManager.AppSettings["EnableEmailReport"].ToString().ToLower() == "true"); %>

<div class="section ui-widget ui-widget-content ui-corner-all"> 

    <h2><%= Resources.Messages.lbl_loader %> 
         <a class="singleLabel onRight" href="./Loader"><%= Resources.Messages.lbl_loader %></a>
        <% if(ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser,ISTAT.ENTITY.UserDef.ActionDef.CRUDSchema)) {%>
            <a class="singleLabel onRight" href="./Builder"><%= Resources.Messages.lbl_builder%></a>
        <% } %>
    </h2>     

    <div class="innerContent">

     <div id="loader_tabs">
            <ul>
                <li><a href="#tabs-1"><%= Resources.Messages.lbl_data_import %></a></li>
                <li><a href="#tabs-2"><%= Resources.Messages.lbl_man_structure%></a></li>
            </ul>
            <div id="tabs-1">

                <table>   
                    <tr>
                        <td colspan="2">
                            <p><%= Resources.Messages.msg_loader_welcome %></p>
                        </td>
                    </tr>  
                    <tr>
                        <td colspan="2">
                            <p>
                                <input id="chk_file_type" type="checkbox" />
                                <%= Resources.Messages.lbl_use_file_type %>
                            </p>
                        </td>
                    </tr>
                    <!-- CSV FILE INPUT -->
                    <tr class="csv_file"> 
                        <td style="width:1%"><span>(1)</span></td>
                        <td><select id="cmb_map"></select></td>
                    </tr>
                    <tr class="csv_file"> 
                        <td colspan="2"><textarea id="desc_map" rows="5" cols="10"></textarea> </td>
                    </tr>
                    <tr class="csv_file">
                        <td colspan="2">
                            <p class="contentLabel"><%= Resources.Messages.lbl_loader_select_data %>
                                <a href="#" id="btm_view_map"><span class="ui-icon ui-icon ui-icon-transferthick-e-w"></span><%= Resources.Messages.lbl_loader_view_map %></a>
                                <a href="#" id="btm_refresh"><span class="ui-icon ui-icon-refresh"></span><%= Resources.Messages.lbl_reload %></a>
                            </p>
                        </td>
                    </tr>
                    <!-- CSV FILE INPUT END -->
                    <!-- SMDX-ML FILE INPUT -->
                    <tr class="sdmxml_file"> 
                        <td style="width:1%"><span>(1)</span></td>
                        <td><input type="text" id="txt_cube" readonly="readonly" /></td>
                    </tr>
                    <tr class="sdmxml_file">
                        <td colspan="2">
                            <p class="contentLabel"><%= Resources.Messages.lbl_loader_select_data %>
                                <a href="#" id="btm_cube"><%= Resources.Messages.lbl_select_ds %></a>
                            </p>
                        </td>
                    </tr>
                    <!-- SMDX-ML INPUT END -->
                    <tr>
                        <td colspan="2">
                            <p>
                            <span id="isAttribute">
                                <input id="chkIsAttributeFile" type="checkbox" />
                                <%= Resources.Messages.lbl_is_attribute_file %>
                            </span>
                            </p>
                        </td>
                    </tr>
                    <tr> 
                        <td><span>(2)</span></td>
                        <td><input type="file" id="fileData" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <p class="contentLabel" style="float:right; width:auto;">
                                <a href="#" id="btm_preview"><span class="ui-icon ui-icon-calculator"></span><%= Resources.Messages.lbl_preview %></a>   
                            </p>
                            <p class="contentLabel" style="float:right; width:auto;"><span style="margin:10px 0px; float:left;">(3)</span>
                                <a href="#" id="btm_uploadFile"><span class="ui-icon ui-icon-arrowthickstop-1-n"></span><%= Resources.Messages.lbl_upload %></a>
                            </p>
                            
                        </td>
                    </tr>
                    <% if (enableEmail) { %>
                    <tr>
                        <td><p><input type="checkbox" id="chk_report_email" value="on" name="optSendEmail"/><%= Resources.Messages.lbl_loader_mail_to%></p></td>
                    </tr>
                    <% } %>
                    <% if (enableEmail)
                       { %> 
                    <tr>
                        <td><input type="text" id="txt_email" name="optEmail" value="<%=SDMX_Dataloader.Main.Global.LoggedUser.Email %>" /></td>
                    </tr>
                    <% } %>
                    <tr>   
                        <td colspan="2">
                            <p class="contentLabel" style="float:right; width:auto;"><span style="margin:10px 0px; float:left;">(4)</span>
                                <a href="#" id="btm_import"><span class="ui-icon ui-icon-check"></span><%= Resources.Messages.lbl_import %></a>
                            </p>
                        </td>
                         
                    </tr>
                </table>

            </div>
            <div id="tabs-2">
                <!-- BEGIN CUBE LIST -->
                <p class="contentLabel"><%= Resources.Messages.lbl_ds_avaible%>
                    <a href="#" id="btm_production"><%= Resources.Messages.lbl_change_production %></a> 
                    <a id="btm_refresh_list_cube" class="onRight" href="#"><span class="ui-icon ui-icon-refresh"></span><%= Resources.Messages.lbl_reload %></a>
                </p>
                <div id="cube_tree"  class="fixedContainer"></div> 
                <!-- END CUBE LIST -->
            </div>
        
    </div>    
            
    <link rel="stylesheet" href="jquery/jquery-jstree/themes/default/style.min.css" />
    <script type="text/javascript" src="jquery/jquery-jstree/jstree.min.js"></script>
    <script type="text/javascript">

        var LastIdMapping=-1;
        var LastIdSet=-1;

        $(document).ready(function () {

            // Begin Setup

            ResetLoaderControl();

            $("#loader_tabs").tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
            $("#loader_tabs li").removeClass("ui-corner-top").removeClass("ui-corner-right").removeClass("ui-corner-left");
    
            // End Setup

            // Begin Bind Event
            $('#btm_refresh').click(function (){
                    
                LoadMappingSet();
            
            });
            $('#cmb_map').change(function () {
                
                LoadMappingDettail($(this).val());

            });
            $('#btm_view_map').click(function () {
                LoadMappingItems();
            });
            $('#btm_uploadFile').click(function () {
                UploadFile();
            });
            $('#btm_preview').click(function () {
                ShowPreview();
            });
            $('#btm_import').click(function () {

                var popupConfirm=document.createElement('div');
                $(popupConfirm).append('<p><%= Resources.Messages.lbl_start_import_confirm %></p>');
                $(popupConfirm).dialog({
                    title: "<%= Resources.Messages.lbl_confirm_request %>",
                    position: { my: "center", at: "center", of: window },
                    resizable: true,
                    width:200,
                    height:160,
                    modal: true,
                    buttons: {
                        "<%= Resources.Messages.lbl_confirm%>": function() {
                            StartImport();
                            $( this ).dialog( "close" );
                        },
                        "<%= Resources.Messages.lbl_cancel%>": function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
            });
            $('#chk_report_email').change(function() {
                $("#txt_email").prop('disabled', !this.checked);
            });

            $('#btm_refresh_list_cube').button();
            $("#btm_refresh_list_cube").click(function (){
                PopolateListCube();
                return false;
            });
            $('#btm_production').button();
            $("#btm_production").click(function (){

                var selected_obj = $("#cube_tree div").jstree(true).get_selected(true);

                var cubeSele=null;

                $.each(selected_obj, function(i,data){
                    if(data.id.substring(0,3)=="ds_") cubeSele=(data.id.substring(3,data.id.length));
                });

                SetInProd(cubeSele);

                return false;

            });

            $("#fileData").change(function() {
                if($(this).val()!=""){    
                    $('#btm_uploadFile').button({ disabled: false });
                }
            });
            
            $("#btm_cube").button();
            $("#btm_cube").click(function (){

                ShowCubePopUp();
        
                return false;
            });

            $("#chk_file_type").change(function() {
                var useSDMXML=$(this).prop('checked');
                if(useSDMXML==true){
                    $('.csv_file').hide();
                    $('.sdmxml_file').show();
                    $('#isAttribute').hide();
                }else{
                    $('.csv_file').show();
                    $('.sdmxml_file').hide();
                    $('#isAttribute').show();
                }
            });
            // End Bind Event

            // First! Load list mappingset avaible
            LoadMappingSet();
            
            PopolateListCube();

            
            $('.csv_file').show();
            $('.sdmxml_file').hide();

        });

        function SetInProd(idcube){

        data={
            idset:idcube,
            active:true
        };

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"SetDataFlowProduction",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if(jsonResult.hasOwnProperty('ERRORS')){
                
                }else{

                    var selected_obj = $("#cube_tree div").jstree(true).get_node("ds_"+idcube); 

                    if(jsonResult.PRODUCTION.toString()=="true"){ 
                        selected_obj.data.inProduction="true";
                        selected_obj.icon="img/cube_red.png";
                        $('#btm_production span').text("<%= Resources.Messages.lbl_set_out_production %>");
                        
                    }else{
                        selected_obj.data.inProduction="false";
                        selected_obj.icon="img/cube.png";
                        $('#btm_production span').text("<%= Resources.Messages.lbl_set_in_production %>");
                    }
                    
                    $("#cube_tree div").jstree(true).redraw(true);
                    
                }
            },
            function(msg){
            },
            function(msg){
            },
            function(msg){
                    
            },
            true);



}
        
        function PopolateListCube(){
            $("#cube_tree").empty();
            $("#cube_tree").append(GetTreeCube());
        }
        
        function ResetLoaderControl(){
            $('#btm_view_map').button({ disabled: true });
            $('#btm_uploadFile').button({ disabled: true });
            $('#btm_preview').button({ disabled: true });
            $('#btm_import').button({ disabled: true }); 
            $('#btm_refresh').button({ disabled: false });
                     
            $('#desc_map').prop('disabled', true);
            $('#desc_map').val("");
            $('#fileData').prop('disabled', true);
            $('#fileData').val("");
            $('#chk_report_email').prop('checked', false);
            $('#txt_email').prop('disabled', true);
            $('#txt_email').val("");

            $('#chkIsAttributeFile').prop('disabled', true);


        }

        function LoadMappingSet() { 
            // On document loaded init object for import
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSLoader %>",
                method:"GetMappings",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                //console.log("succ callback");

                $('#cmb_map').empty();
                $('#cmb_map').append('<option value="-1"><%= Resources.Messages.lbl_loader_select_mapping %></option>');
                $.each(jsonResult,function(i,data){
                    $('#cmb_map').append('<option value="'+data.ID_SCHEMA+'">'+data.NAME+'</option>');
                });

                if(LastIdMapping>-1){
                
                    $("#cmb_map").val(LastIdMapping);

                    LoadMappingDettail(LastIdMapping);    
                }

                _layoutManager.DisableLoadingDialog();

            },
            function(msg){
                //console.log("err callback");
                _layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                _layoutManager.DisableLoadingDialog();
            },
            true);
        }

        function LoadMappingDettail(idMapping){
            
            var data = {
                    IDMappingSchema: idMapping
                }       
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSLoader %>",
                method:"SetMappingScheme",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if(jsonResult.hasOwnProperty("ERRORS")){
                    ResetLoaderControl();
                }
                else
                {
                    $("#desc_map").text(jsonResult.Description);

                    $('#btm_view_map').button({ disabled: false });
                    $('#fileData').prop('disabled', false);
                    $('#chkIsAttributeFile').prop('disabled', false);
                    
                    //$('#btm_uploadFile').button({ disabled: false });
                     
                    LastIdMapping=idMapping;

                }
            },
            function(msg){
                //console.log("err callback");
                _layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                _layoutManager.DisableLoadingDialog();
            },
            true);

            
        }

        function LoadMappingItems(){
                  
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSLoader %>",
                method:"GetMappingItems",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                if(jsonResult.hasOwnProperty("ERRORS")){

                }
                else
                {
                    // show popup with list
                    var div_popup=$("<div>");

                    div_popup.append(_layoutManager.GetMappingViewer(jsonResult));
                    
                    $(div_popup).dialog({
                        title:"<%= Resources.Messages.lbl_loader_view_map %>",
                        position: { my: "center", at: "center", of: window },
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        width:280,
                        height:360,
                    });
                    $(div_popup).dialog("open");
                }
            },
            function(msg){
                //console.log("err callback");
                _layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                _layoutManager.DisableLoadingDialog();
            },
            true);
        }

        function UploadFile(){

             _layoutManager.EnableLoadingDialog();

            var data = new FormData();
            var file = $('#fileData')[0].files[0];
            if (file) {
                data.append('UploadedFileData', file);
            }

            $.ajax({
            type: "POST",
            url: "<%= WSLoader %>/UploadFileData",
            cache: false,
            contentType: false,
            processData: false,
            dataType: "json",
            data: data,
            success: function (jsonResult) {
                if (jsonResult.hasOwnProperty('error')) {
                    _layoutManager.DisableLoadingDialog();
                    var div_popup=$("<div>");

                    div_popup.append("<p><%= Resources.Notification.err_upload %></p>");

                    $(div_popup).dialog({
                        title:"<%= Resources.Notification.err_upload %>",
                        position: { my: "center", at: "center", of: window },
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        width:360,
                        height:150,
                    });
                    $(div_popup).dialog("open");
                } else {

                    _layoutManager.DisableLoadingDialog();

                    if(!$('#chkIsAttributeFile').prop('checked'))
                    {
                        $('#btm_preview').button({ disabled: false });
                    }
                    else
                    {
                        $('#btm_preview').button({ disabled: true });
                        $('#chkIsAttributeFile').prop('checked');
                    }

                    $('#btm_import').button({ disabled: false });

                    var kilobitsize = jsonResult.filesize;
                    var sudCount = 0;
                    while (kilobitsize > 1024) {
                        kilobitsize = (kilobitsize / 1024);
                        sudCount = sudCount + 1;
                    }
                    var sizeUnit = '';
                    if (sudCount == 0) sizeUnit = ' byte';
                    if (sudCount == 1) sizeUnit = ' Kb';
                    if (sudCount == 2) sizeUnit = ' Mb';
                    if (sudCount > 2) sizeUnit = ' Gb';

                    var div_popup=$("<div>");

                    div_popup.append("<p><span class='fieldLabel'>Filename</span></br>"+jsonResult.filename+" ("+kilobitsize.toFixed(2) + sizeUnit+")</p>");
                    div_popup.append("<p><span class='fieldLabel'>Content</span></br>"+jsonResult.content+"</p>");

                    $(div_popup).dialog({
                        title:"<%= Resources.Notification.succ_upload %>",
                        position: { my: "center", at: "center", of: window },
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        width:360,
                        height:150,
                    });
                    $(div_popup).dialog("open");

                }
            },
            error: function () {
                _layoutManager.DisableLoadingDialog();
            }
        });
        
    }
        
        function ShowPreview(){
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSLoader %>",
                method:"GetPreview",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                if(jsonResult.hasOwnProperty("ERRORS")){
                    
                    var div_popup=$("<div>");

                    div_popup.append("<p><%= Resources.Notification.err_resolve_mapping %></p>");
                    
                    $(div_popup).dialog({
                        position: { my: "center", at: "center", of: window },
                        position: { my: "center", at: "center", of: window },
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        width:240,
                        height:120,
                    });
                    $(div_popup).dialog("open");
                }
                else
                {
                    // show popup with list
                    var div_popup=$("<div>");

                    div_popup.append(_layoutManager.GetPreview(jsonResult));
                    
                    $(div_popup).dialog({
                        position: { my: "center", at: "center", of: window },
                        position: { my: "center", at: "center", of: window },
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        width:720,
                        height:360,
                    });
                    $(div_popup).dialog("open");
                }
            },
            function(msg){
                //console.log("err callback");
                _layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                _layoutManager.DisableLoadingDialog();
            },
            true);
        }
        
        function StartImport(){

            var emailToSend='';
            var attributeFile=false;

            <% if (enableEmail) { %>
            if($('input[type="checkbox"][name="optSendEmail"]').prop('checked'))
                emailToSend=$('input[type="text"][name="optEmail"]').val();
             <% } %>
             
            attributeFile = $('#chkIsAttributeFile').prop('checked');

            var data={
                'emailToReport':emailToSend,
                'attributeFile':attributeFile
            }
            var _ajaxRequestMan=new AjaxRequestManager(
                {
                    baseUrl:"<%= WSLoader %>",
                    method:"ImportData",
                    locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                },{
                    titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                    messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                });

            _ajaxRequestMan.SendRequest(
                data,
                function(jsonResult){
                    if(jsonResult.hasOwnProperty("ERRORS")){

                    } else {

                            var div_popup=$("<div>");

                            var strings={
                                lbl_user:"<%= Resources.Messages.lbl_report_user %>",
                                lbl_insert_type:"<%= Resources.Messages.lbl_report_mode %>",
                                lbl_record_count:"<%= Resources.Messages.lbl_report_count %>",
                                lbl_errors_occurred:"<%= Resources.Messages.lbl_report_error %>",
                                lbl_emailto:"<%= Resources.Messages.lbl_report_email %>"
                            }

                            div_popup.append(_layoutManager.GetReportQuery(strings,jsonResult));
                    
                            $(div_popup).dialog({
                                position: { my: "center", at: "center", of: window },
                                autoOpen: true,
                                draggable: false,
                                modal: true,
                                closeOnEscape: false,
                                width:360,
                                //height:240,
                            });
                            $(div_popup).dialog("open");

                            ResetLoaderControl();
                            LoadMappingSet();
                        }
                },
                function(msg){
                    //console.log("err callback");
                    _layoutManager.DisableLoadingDialog();
                },
                function(msg){
                    //console.log("pre callback");
                    _layoutManager.EnableLoadingDialog();
                },
                function(msg){
                    //console.log("post callback");
                    _layoutManager.DisableLoadingDialog();
                },
                true);
        }

        function GetTreeCube(){
                                     
            var cubeTreeView=document.createElement('div');
            $('#btm_production').button({ disabled: true });
            $(cubeTreeView)
            .on('changed.jstree', function (e, data) {
                if(data.selected.length>0){
                    var selObj=data.instance.get_node(data.selected[0]);
                    if(selObj.type=="dataset"){
                        $('#btm_production span').text((selObj.data.inProduction.toString()=="true")?"<%= Resources.Messages.lbl_set_out_production %>":"<%= Resources.Messages.lbl_set_in_production %>");
                        $('#btm_production').button({ disabled: false });
                    }
                    else{
                        $('#btm_production').button({ disabled: true });
                    }
                }
              })
            .jstree({
                'core': {
                    'data': {
                        'url': '<%= WSProfile %>/GetDomains',
                        'data': function (node) {
                            return { 'idUser': <%= SDMX_Dataloader.Main.Global.LoggedUser.ID %> ,'stub':false };
                        }
                    }
                },
                "types" : {
                    "#" : {
                        "max_children" : -1, 
                        "max_depth" : -1, 
                        "valid_children" : ["root"]
                    },
                    "root" : {
                        "valid_children" : ["category"]
                    },
                    "category" : {
                        "valid_children" : ["category","dataset"]
                    },
                    "dataset": {
                        "valid_children" : []
                    }
                },
                "plugins" : [
                    //"contextmenu", "dnd", "search","checkbox"
                    "state", "types", "wholerow", 
                ]
            });

            return cubeTreeView;

        }

        function ShowCubePopUp(){
  
            var cube_popup=document.createElement('div');
            var domainTreeView=document.createElement('div');
        
            $(cube_popup).dialog({
                title: "<%= Resources.Messages.lbl_select_ds %>",
                position: { my: "center", at: "center", of: window },
                resizable: true,
                width:400,
                height:300,
                modal: true,
                buttons: {
                    "<%= Resources.Messages.lbl_confirm%>": function() {

                        var selected_obj = $(domainTreeView).jstree(true).get_selected(true);

                        var cubeSelected=null;

                        $.each(selected_obj, function(i,data){
                            if(data.id.substring(0,3)=="ds_") cubeSelected=data;
                        });

                        if(cubeSelected!=null){ 
                            
                            $('#txt_cube').val(cubeSelected.text);
                            $('#txt_cube').data('idCube',cubeSelected.id.substring(3,cubeSelected.id.length));
                            
                            LoadCube($('#txt_cube').data('idCube'));

                        }

                        $( this ).dialog( "close" );

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
                            return { 'idUser': <%= SDMX_Dataloader.Main.Global.LoggedUser.ID %> ,'stub':false };
                        }
                    }
                },
                "types" : {
                    "#" : {
                        "max_children" : -1, 
                        "max_depth" : -1, 
                        "valid_children" : ["root"]
                    },
                    "root" : {
                        "icon" : "/img/cat.png",
                        "valid_children" : ["default"]
                    },
                    "default" : {
                        "valid_children" : ["default","dataset"]
                    },
                    "dataset": {
                        "icon" : "glyphicon glyphicon-file",
                        "valid_children" : []
                    }
                },
                'checkbox': {
                    'keep_selected_style': false
                },
                "plugins" : [
                    //"contextmenu", "dnd", "search","checkbox"
                    "state", "types", "wholerow", 
                ]
            });
                                 
            $(domainTreeView).appendTo($(cube_popup));

        }

        function LoadCube(IDCube){
            
            var data = {
                    idCube: IDCube
                }       
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSLoader %>",
                method:"SetCube",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if(jsonResult.hasOwnProperty("ERRORS")){
                    ResetLoaderControl();
                }
                else
                {
                    $('#fileData').prop('disabled', false);
                    $('#chkIsAttributeFile').prop('disabled', false);
                    
                    //$('#btm_uploadFile').button({ disabled: false });
                     
                    LastIdCube=IDCube;

                }
            },
            function(msg){
                //console.log("err callback");
                _layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                _layoutManager.DisableLoadingDialog();
            },
            true);

            
        }

    </script>
           
    </div>
            
</div>

</asp:Content>