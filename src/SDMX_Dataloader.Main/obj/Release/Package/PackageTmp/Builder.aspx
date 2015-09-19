<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Builder.aspx.cs" Inherits="SDMX_Dataloader.Main.Builder" %>
        
<%@ Register TagPrefix="uc" TagName="MultipleFileUploadControl" Src="~/Controls/MultipleFileUploadControl.ascx" %> 
<%@ Register TagPrefix="uc" TagName="CSVUploadControl" Src="~/Controls/CSVUploadControl.ascx" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="jquery/jQuery-File-Upload/jquery.form.js"></script>
    <script type="text/javascript"  src="jquery/jQuery-File-Upload/jquery.uploadfile.js"></script>





</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="content" runat="server">


<div class="section ui-widget ui-widget-content ui-corner-all"> 
                  
    <h2><%= Resources.Messages.lbl_builder %> 
         <a class="singleLabel onRight" href="./Loader"><%= Resources.Messages.lbl_loader %></a>
        <% if(ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser,ISTAT.ENTITY.UserDef.ActionDef.CRUDSchema)) {%>
            <a class="singleLabel onRight" href="./Builder"><%= Resources.Messages.lbl_builder%></a>
        <% } %>
    </h2>

    <div class="innerContent">

        <div id="builder_tabs">
            <ul>
                <li><a href="#tabs-1"><%= Resources.Messages.lbl_man_structure %></a></li>
                <li><a href="#tabs-2"><%= Resources.Messages.lbl_man_mappingset%></a></li>
            </ul>
            <div id="tabs-1">
                <table >
                    <tr>                         
                        <th class="fivety"></th>
                        <th class="fivety"></th>
                    </tr>
                    <tr>
                        <td style="max-width:460px">        
                            <!-- BEGIN DSD LIST -->
                            <a href="#" id="btm_delete_dsd"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_dsd_delete %></a>
                            <a href="#" id="btm_import_schema"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_importSDMXSchema %></a>
                            <div id="popup_import_schema" style="display:none;">
                                <uc:MultipleFileUploadControl ID="MultipleFileUploadControl1" runat="server"  
                                Text="<%# Resources.Messages.lbl_upload_file_xml_schema%>" 
                                ServerDomain="<%# WSBuilder %>" 
                                ServerPage="/UploadFileSDMXSchema" 
                                NameParam="sdmxSchemaFiles"
                                IDDivFile="sdmxSchemaFileUploader"
                                ReloadOnUpload="false"
                                ReportOnUpload="true"></uc:MultipleFileUploadControl>
                            </div>
                            <p class="contentLabel"><%= Resources.Messages.lbl_dsd_avaible%>
                                <a class="onRight btm_refresh_list_dsd" href="#"><span class="ui-icon ui-icon-refresh"></span><%= Resources.Messages.lbl_reload %></a>
                            </p>
                            <select class="dsd_list fixedContainer" size="10"></select>
                            <!-- END DSD LIST -->
                        </td>
                        <td style="max-width:460px">
                            <!-- BEGIN CUBE LIST -->
                            <a href="#" id="btm_cube_details"><%= Resources.Messages.lbl_cube_detail %></a> 
                            <a href="#" id="btm_production"><%= Resources.Messages.lbl_change_production %></a> 
                            <a href="#" id="btm_delete_dataset"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_ds_delete%></a>
                                     
                            <p class="contentLabel"><%= Resources.Messages.lbl_ds_avaible%>
                                <a class="onRight btm_refresh_list_cube" href="#"><span class="ui-icon ui-icon-refresh"></span><%= Resources.Messages.lbl_reload %></a>
                            </p>
                            <div id="cube_tree"  class="fixedContainer"></div> 
                            <!-- END CUBE LIST -->
                        </td>
                    </tr>
                    <tr><td colspan="2"><p id="dettail_label" class=""></p></td></tr>
                    <tr>
                        <td style="max-width:460px">  
                            <div id="ds_new">
                            
                                <p class="contentLabel"><%= Resources.Messages.lbl_ds_category%>
                                    <a class="onRight" href="#" id="btm_select_category"><%= Resources.Messages.lbl_select_category%></a>
                                </p>
                                <div id="jstree_theme_list" style="display:none;"></div>
                                <input type="text" id="txt_category" readonly="readonly" />

                                <p class="contentLabel"><%= Resources.Messages.lbl_ds_code%></p>
                                <input type="text" name="txt_ds_code" id="txt_ds_code" value="" />

                                <p class="contentLabel"><%= Resources.Messages.lbl_add_name%>
                                    <a href="#" id="btm_name_langs"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_add_name%></a>
                                </p>
                                <div id="div_name_langs"></div>
                                <p class="contentLabel"><%= Resources.Messages.lbl_add_desc%>
                                    <a href="#" id="btm_desc_langs"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_add_desc%></a>
                                </p>
                                <div id="div_desc_langs"></div>

                                <a href="#" id="btm_ds_create"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_ds_create %></a>

                            </div>
                        </td>
                        <td style="max-width:460px">
                            <div id="dsd_concept">
                                <div class="ds_viewer"></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>         
            <div id="tabs-2">
                <table>
                    <tr>
                        <th class="fivety"></th>
                        <th class="fivety"></th>
                    </tr>
                    <tr>
                        <td class="grey_0"  style="max-width:460px">
                            
                            <p class="contentLabel"><%= Resources.Messages.lbl_select_mapping %></p>
                            <select id="mapping_list"></select>
                            <p class="contentLabel">
                                <span class="inner" style="float:left !important">(1)</span> 
                                <a id="btm_mapping_new" class="onLeft" style="float:left !important"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_new_mapping%></a>
                                <a id="btm_mapping_delete" class="onRight" style="float:right !important"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_delete_mapping%></a>
                            </p>
                            
                            
                        </td>
                        <td class="grey_1"  style="max-width:460px">

                            <!-- BEGIN MAPPING INFO -->
                            <p class="contentLabel"><span class="inner">(4)</span><%= Resources.Messages.lbl_name_mapping%></p>
                            <input type="text" id="txt_mapping_name" />
                            <p class="contentLabel"><span class="inner">(5)</span><%= Resources.Messages.lbl_desc_mapping%></p>
                            <textarea id="txt_mapping_desc" rows="5" cols="5"></textarea>

                            <!-- END MAPPING INFO -->
                         </td>
                    </tr>
                    <tr>
                        <td class="grey_2" style="max-width:460px">

                                <!-- BEGIN SELECTION CUBE -->
                                <div>
                                    <p class="contentLabel">
                                        <span class="inner">(2)</span>
                                        <%= Resources.Messages.lbl_select_ds %>      
                                        <a href="#" id="btm_cube"><%= Resources.Messages.lbl_select_ds %></a> 
                                    </p>
                                    <input type="text" id="txt_cube" readonly="readonly" />
                                    <div id="cube_popup" style="display:none"></div>
                                </div>
                                <!-- END SELECTION CUBE -->

                                <!-- BEGIN CSV UPLOAD -->
                                <div>
                                    <p class="contentLabel">
                                        <span class="inner">(3)</span>
                                        <%= Resources.Messages.lbl_uploadCSVChoise %></p>
                                    <input id="FileUploadCSV" class="fileInput" type="file" name="FileUploadCSV" />
                                    <p class="descriptionInput"><input id="charSeparatorCSV" class="char" type="text" name="txtSeparator" maxlength="1" value=";" /><%= Resources.Messages.lbl_uploadCSVSeparator %></p>
                                    <p class="descriptionInput"><input id="chkFirstRowJump" type="checkbox" value="on" name="chkFirstRowJump" /><%= Resources.Messages.lbl_first_row_column%></p>
                                    <a id="btmUploadAjax"><span class="ui-icon ui-icon-arrowthickstop-1-n"></span><%= Resources.Messages.lbl_upload%></a>
                                </div>
                                <!-- END CSV UPLOAD -->

                        </td>
                        <td class="grey_3" style="max-width:460px">
                            <!-- BEGIN TRANSCODING -->
                            <table>
                                <tr>
                                    <td colspan="3"><p class="descriptionInput">
                                        <span class="inner">(6)</span>
                                        <input type="checkbox" name="transcodeTime" checked="checked" value="on" />
                                        Transcoding TIME_PERIOD</p></td>
                                </tr>
                                <tr class="transcodeTimeContainer">
                                    <td class="fivety">
                                        <p><%= Resources.Messages.lbl_format_sample%></p>
                                    </td>
                                    <td class="twentyfive">
                                        <p class=""><%= Resources.Messages.lbl_char_change%></p>
                                    </td>
                                    <td class="twentyfive">
                                        <p class="contentLabel"><span class="inner"></span><%= Resources.Messages.lbl_time_period%></p>
                                    </td>
                                </tr>
                                <tr class="transcodeTimeContainer">
                                    <td>
                                        <input type="text" maxlength="20" name="espCurr" value="1990-10"  readonly="readonly" />
                                    </td>
                                    <td>
                                        <input type="text" maxlength="50" name="charPeriod" id="charSeparator" class="char" />
                                    </td>
                                    <td>
                                        <ul class="list-radio">
                                        <% foreach (int periodValue in Enum.GetValues(typeof(ISTAT.ENTITY.TranscodeTime.TypePeriod)))
                                            { %>

                                            <li><input type="radio" name="periodIndex" value="<%=periodValue %>" /><%=((ISTAT.ENTITY.TranscodeTime.TypePeriod)periodValue).ToString()%></li>
                                                  
                                        <%} %>
                                        </ul>
                                    </td>
                                </tr>
                            </table>    
                            <!-- END TRANSCODING -->

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="grey_4"  style="max-width:920px">  
                            <!-- BEGIN MAPPING -->
                            <table id="mapping_new">
                                <tr>
                                    <th  class="thirty"> </th> 
                                    <th  class="fourty"> </th>
                                    <th  class="thirty"> </th>
                                </tr>
                                <tr>
                                    <td>
                                        <p class="contentLabel">CSV Headers</p>
                                        <div id="mapping_csv" class="selectable-list ui-widget-content"></div>
                                    </td>
                                    <td>
                                        <p class="contentLabel">
                                            <span class="inner">(9)</span>
                                            Custom mapping
                                            <a id="btm_mapping_create"><span class="ui-icon ui-icon-check"></span><%= Resources.Messages.lbl_save_mapping%></a>
                                            <a href="#"  id="btm_delRelation" class="onRight"><span class="ui-icon ui-icon-minus"></span></a>
                                            <a href="#"  id="btm_addRelation"class="onLeft"><span class="ui-icon ui-icon-plus"></span></a>
                                        </p>
                                        <div id="mapping_custom" class="selectable-list  ui-widget-content">
                                            <ul class="mapping-list"></ul>
                                        </div>
                                    </td>
                                    <td>
                                        <p class="contentLabel">SDMX Component</p>
                                        <div id="mapping_sdmx" class="selectable-list ui-widget-content"></div>
                                    </td>
                                </tr>
                            </table>    
                            <!-- END MAPPING -->
                        </td>
                    </tr>
                </table>
            </div>
        </div>

    </div>

</div>

                
<link rel="stylesheet" href="jquery/jquery-jstree/themes/default/style.min.css" />
<script type="text/javascript" src="jquery/jquery-jstree/jstree.min.js"></script>
<script type="text/javascript">
      
    var a=0;
    var b=0;
    var c=0;
    var c_a=0;
    var c_b=0;
         
    var IDMappingScheme=-1;
    var IDCube=-1;
    var lbl_record_count = "<%= Resources.Messages.lbl_record_count%>";
    var lbl_of = "<%= Resources.Messages.lbl_of%>";
    var CubeMaxRowCount = <%=System.Configuration.ConfigurationManager.AppSettings["CubeDetailMaxRecord"]%>;
    var lbl_ds_code = "<%=Resources.Messages.lbl_ds_code%>";

            
$(document).ready(function () {
                 
    var themeCredential={ 'idUser': <%= SDMX_Dataloader.Main.Global.LoggedUser.ID %>,'stub':true };

    $("#builder_tabs").tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $("#builder_tabs li").removeClass("ui-corner-top").removeClass("ui-corner-right").removeClass("ui-corner-left");
       
    $('#builder_tabs .dsd_list').change(function () {
        var dsd_indentity =  $(this).val();
        dsd_indentity=dsd_indentity.split('<%= ISTAT.ENTITY.SDMXIdentifier.char_separator %>');
        OnSelectDSD(dsd_indentity[0],dsd_indentity[1],dsd_indentity[2]);
    });
     
    $("#btm_delete_dsd").button({ disabled: false });
    $("#btm_delete_dsd").click(function () {

        
        var popupConfirm=document.createElement('div');
        $(popupConfirm).append('<p><%= Resources.Messages.lbl_delete_dsd_confirm %></p>');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_confirm_request %>",
            position: { my: "center", at: "center", of: window },
            resizable: true,
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    var dsd_indentity =  $('#builder_tabs .dsd_list').val();
                    dsd_indentity=dsd_indentity.split('<%= ISTAT.ENTITY.SDMXIdentifier.char_separator %>');
        
                    DeleteDSD(dsd_indentity[0],dsd_indentity[1],dsd_indentity[2]);

                    DisableStructureEditor();

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

        return false;
    });

    $("#btm_get_Structure").button({ disabled: false });
    $("#btm_get_Structure").click(function () {

        ShowPopupStructure();

        return false;
    }); 
        
    $("#btm_import_schema").button();
    $("#btm_import_schema").click(function (){
    
        ShowImportSchemaPopup();

        return false;
    });

    $(".btm_refresh_list_cube").button();
    $(".btm_refresh_list_cube").click(function (){

        PopolateListCube();
        
        DisableStructureEditor();
        
        return false;
    });
    $(".btm_refresh_list_dsd").button();
    $(".btm_refresh_list_dsd").click(function (){

        PopolateListDSD();
        
        DisableStructureEditor();

        return false;
    });
                   
    $("#btm_select_category").button();
    $("#btm_select_category").click(function (){

        ShowPopupTheme(themeCredential);

        return false;
    });
               
    $("#btm_ds_create").button();
    $("#btm_ds_create").click(function () {
        
        var popupConfirm=document.createElement('div');
        $(popupConfirm).append('<p><%= Resources.Messages.lbl_create_cube_confirm %></p>');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_confirm_request %>",
            position: { my: "center", at: "center", of: window },
            resizable: true,
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    CreateDatastructure();

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });
        

        return false;
    });

    $('#mapping_list').change(function () {
    
        
        var idMappingScheme = $(this).val();
        if(idMappingScheme>-1){
          
            ClearMappingEditor(); 
            LoadMapping(idMappingScheme);
            DisableMappingEditor();

        }

    });
    
    $('#btm_mapping_delete').button();
    $('#btm_mapping_delete').click(function(){
    
        var popupConfirm=document.createElement('div');
        $(popupConfirm).append('<p><%= Resources.Messages.lbl_delete_mapping_confirm %></p>');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_confirm_request %>",
            position: { my: "center", at: "center", of: window },
            resizable: true, 
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    DeleteMapping($('#mapping_list').val());

                    ClearMappingEditor(); 
        
                    LoadMapping($(this).val());

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

        return false;
    });
    $('#btm_mapping_create').button();
    $('#btm_mapping_create').click(function(){

        var popupConfirm=document.createElement('div');
        $(popupConfirm).append('<p><%= Resources.Messages.lbl_create_mapping_confirm %></p>');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_confirm_request %>",
            position: { my: "center", at: "center", of: window },
            resizable: true,
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    CreateMapping();

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });
        
        return false;
    });
    $("#btm_mapping_new").button();
    $("#btm_mapping_new").click(function (){

        ClearMappingEditor();
        EnableMappingEditor();

        $('#mapping_list').val("-1");

        return false;
    });
    
    $("#btm_cube").button();
    $("#btm_cube").click(function (){

        ShowCubePopUp();
        
        return false;
    });
       
    $('#btmUploadAjax').button();
    $('#btmUploadAjax').click(function () {

        UploadCSV();

        return false;
    });
    
    $('#btm_addRelation').button();
    $('#btm_addRelation').click(function(){

        if(a!=undefined && a!=0 && b!=0 && b!= undefined){
            var dataIndexA=$( "#mapping_csv ul li:nth-child("+a+") > p" ).data('index');
            var dataA=$( "#mapping_csv ul li:nth-child("+a+") > p" ).data('item');
            var dataIndexB=$( "#mapping_sdmx ul li:nth-child("+b+") > p" ).data('index');
            var dataB=$( "#mapping_sdmx ul li:nth-child("+b+") > p" ).data('item');

            $( "#mapping_csv ul li:nth-child("+dataIndexA+")" ).hide();
            $( "#mapping_sdmx ul li:nth-child("+dataIndexB+")" ).hide();

            $( "#mapping_csv ul li:nth-child("+dataIndexA+")" ).attr("mapped","true");
            $( "#mapping_sdmx ul li:nth-child("+dataIndexB+")" ).attr("mapped","true");



            $('#mapping_custom ul.mapping-list').append(
            "<li><p class='mapping_item' data-valuea='"+dataIndexA+"' data-valueastr='"+dataA+"' data-valueb='"+dataIndexB+"'  data-valuebstr='"+dataB+"'>"+
            "<span>"+dataA+"</span><span class='ui-icon ui-icon-transferthick-e-w'></span><span>"+dataB+"</span>"+
            "</p></li>");

            a=0;
            b=0;
            
        }
        return false;
    });

    $('#btm_delRelation').button();
    $('#btm_delRelation').click(function(){
        
        if(c_a!=undefined && c_a!=0 && c_b!=0 && c_b!= undefined && c!=0 && c!= undefined){
            $( "#mapping_csv ul li:nth-child("+c_a+")" ).show();
            $( "#mapping_sdmx ul li:nth-child("+c_b+")" ).show();

            $( "#mapping_csv ul li:nth-child("+c_a+")" ).attr("mapped","false");
            $( "#mapping_sdmx ul li:nth-child("+c_b+")" ).attr("mapped","false");

            $( "#mapping_custom ul li:nth-child("+c+")" ).remove();

            c_a=undefined; 
            c_b=undefined; 
            c=undefined;
        }

        return false;
    });

    $('#mapping_custom ul.mapping-list').selectable({
        selected: function (event, ui) {
            $(ui.selected).siblings().removeClass("ui-selected");
        },
        stop: function() {
            $( ".ui-selected", this ).each(function() {
                var index = $("#mapping_custom ul li").index( this );
                c=(index+1);
                c_a=$("#mapping_custom ul li:nth-child("+(c)+") > p" ).data('valuea');
                c_b=$( "#mapping_custom ul li:nth-child("+(c)+") > p" ).data('valueb');
            });
        }
    });

    $("#btm_name_langs").button();
    $("#btm_name_langs").click(function (){
        ShowLangPopUp("<%= Resources.Messages.lbl_add_name %>","#div_name_langs","label_name_cube");
        
        return false;
    });

    $("#btm_desc_langs").button();
    $("#btm_desc_langs").click(function (){
        ShowLangPopUp("<%= Resources.Messages.lbl_add_desc %>","#div_desc_langs","label_desc_cube");
        
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
    
    $('#btm_cube_details').button();
    $("#btm_cube_details").click(function (){

        var selected_obj = $("#cube_tree div").jstree(true).get_selected(true);

        var cubeSele=null;

        $.each(selected_obj, function(i,data){
            if(data.id.substring(0,3)=="ds_") cubeSele=(data.id.substring(3,data.id.length));
        });

        GetCubeDetails(cubeSele);

        return false;

    });

    $('#btm_delete_dataset').button();
    $("#btm_delete_dataset").click(function (){

        var popupConfirm=document.createElement('div');
        $(popupConfirm).append('<p><%= Resources.Messages.lbl_delete_cube_confirm %></p>');
        $(popupConfirm).dialog({
            title: "<%= Resources.Messages.lbl_confirm_request %>",
            position: { my: "center", at: "center", of: window },
            resizable: true, 
            width:200,
            height:160,
            modal: true,
            buttons: {
                "<%= Resources.Messages.lbl_confirm%>": function() {
                    
                    var selected_obj = $("#cube_tree div").jstree(true).get_selected(true);

                    var cubeSele=null;

                    $.each(selected_obj, function(i,data){
                        if(data.id.substring(0,3)=="ds_") cubeSele=(data.id.substring(3,data.id.length));
                    });

                    DeleteCube(cubeSele);
        
                    DisableStructureEditor();

                    $( this ).dialog( "close" );
                },
                "<%= Resources.Messages.lbl_cancel%>": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

        return false;

    });

    PopolateListDSD();
    PopolateListMapping();
    PopolateListCube();

    DisableStructureEditor();

}); 
 

function PopolateListDSD(){

    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"GetDSDs",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },
    {
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });


    _ajaxRequestMan.SendRequest(
        null,
        function(jsonResult){
            $('#builder_tabs .dsd_list').empty();

            $.each(jsonResult, function (i, item) {
                $('#builder_tabs .dsd_list').append('<option value="'+item.Value+'">'+item.Text+'</option>');
            });                                                             
            //$('#builder_tabs .dsd_list').height($('#builder_tabs .dsd_list').parent().height());
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


} 
function PopolateListCube(){
    $("#cube_tree").empty();
    $("#cube_tree").append(GetTreeCube());

    $("#btm_deleteDataset").button("option", "disabled", true);
    $("#btm_production").button("option", "disabled", true);

}
function PopolateListMapping(){

    var _ajaxRequestMan=new AjaxRequestManager({
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
                
            $('#mapping_list').empty();
            $('#mapping_list').append('<option value="-1"><%= Resources.Messages.lbl_loader_select_mapping %></option>');
            $.each(jsonResult,function(i,data){
                $('#mapping_list').append('<option value="'+data.ID_SCHEMA+'">'+data.NAME+'</option>');
            });

            if($("#mapping_list option:first").val()==-1){
                //$("#mapping_list").val(firstIDMapping);
                //LoadMapping(firstIDMapping);

                DisableMappingEditor();

                $("#btm_mapping_delete").button("option", "disabled", false);
                $("#btm_mapping_new").button("option", "disabled", false);

            }else{

                $("#btm_mapping_delete").button("option", "disabled", true);
                $("#btm_mapping_new").button("option", "disabled", true);
                
                ClearMappingEditor();
                EnableMappingEditor();

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

function DeleteCube(idcube){

        data={
            idset:idcube
        };

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"DeleteDataset",
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
                    DisableStructureEditor();
                    PopolateListCube();
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

function ShowImportSchemaPopup(){

    $('#popup_import_schema').dialog({
        title: "<%= Resources.Messages.lbl_upload_file_xml_schema%>",
        position: { my: "center", at: "center", of: window },
        resizable: true,
        width:400,
        height:400,
        modal: true,
        buttons: {
            "Ok": function() {
                PopolateListDSD();
                PopolateListCube();
                $( this ).dialog( "close" );
            }
        },
        beforeClose: function( event, ui ) {
                PopolateListDSD();
                PopolateListCube();
        }
    });


}
function ShowPopupStructure(){
 
    var structureDiv=document.createElement('div');

    var typeStructure_select=$("<select id='cmb_type_structure'>");
    
    typeStructure_select.append('<option value="<%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.AgencyScheme %>"><%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.AgencyScheme %></option>');
    typeStructure_select.append('<option value="<%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CategoryScheme %>"><%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CategoryScheme %></option>');
    typeStructure_select.append('<option value="<%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.ConceptScheme %>"><%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.ConceptScheme %></option>');
    typeStructure_select.append('<option value="<%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList %>"><%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList %></option>');
    typeStructure_select.append('<option value="<%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd %>"><%= Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Dsd %></option>');

    $(structureDiv).append('<p>ID<input type="text" id="txt_id_structure" /></p>');
    $(structureDiv).append('<p>AGENCY<input type="text" id="txt_agencyid_structure" /></p>');
    $(structureDiv).append('<p>VERSION<input type="text" id="txt_version_structure" /></p>');
    $(structureDiv).append(typeStructure_select);
        
    $(structureDiv).dialog({
        title: "Get SDMX Object",
        position: { my: "center", at: "center", of: window },
        resizable: true,
        width:400,
        height:300,
        modal: true,
        buttons: {
            "OK": function() {

                var data={
                    id:$('#txt_id_structure').val(),
                    agency:$('#txt_agencyid_structure').val(),
                    version:$('#txt_version_structure').val(),
                    type_structure:$('#cmb_type_structure').val(),
                };

                var _ajaxRequestMan=new AjaxRequestManager({
                    baseUrl:"<%= WSBuilder %>",
                    method:"CheckSDMXObject",
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
                    },
                    function(msg){
                    
                    },
                    true);


                $( this ).dialog( "close" );
                $(structureDiv).remove();

            },
            Cancel: function() {
                $( this ).dialog( "close" );
                $(structureDiv).remove();
            }
        }
    });
       
}
function ShowPopupTheme(data) {

    var _data = { 'idUser': 0,'stub':true };

    $.extend(_data, data);

    $('#jstree_theme_list').empty(); 
    var themeTreeView=document.createElement('div');
        
    $('#jstree_theme_list').dialog({
        title: "Category",
        position: { my: "center", at: "center", of: window },
        resizable: true,
        width:400,
        height:300,
        modal: true,
        buttons: {
            "<%= Resources.Messages.lbl_confirm%>": function() {

                var selected_obj = $(themeTreeView).jstree(true).get_selected(true);

                var categorySelected=null;

                $.each(selected_obj, function(i,data){
                    categorySelected=data;
                });

                if(categorySelected!=null){
                 
                     if(categorySelected.type=="category"){
                        $('#txt_category').val(categorySelected.text);
                        $('#txt_category').data('idCat',categorySelected.id);

                        $( this ).dialog( "close" );
                    }

                }


            },
            Cancel: function() {
                $( this ).dialog( "close" );
                $(themeTreeView).remove();
            }
        }
    });
                                       
    $(themeTreeView)
    .on('changed.jstree', function (e, data) {
        
    })
    .jstree({
        'core': {
            "multiple": false,
            "animation": 0,
            "check_callback": true,
            'data': {
                'url': '<%= WSProfile %>/GetDomains',
                'data': function (node) {
                    return _data;
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
                "valid_children" : ["categoryScheme"]
            },
            "categoryScheme" : {
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
                                 
    $(themeTreeView).appendTo($('#jstree_theme_list'));

}
 
function OnSelectDSD(dsd_id,dsd_agency,dsd_version){
    DisableStructureEditor();
        
    $("#cube_tree div").jstree(true).deselect_all(false);
    $('#btm_production').button({ disabled: true });
    $('#btm_delete_dataset').button({ disabled: true });
                
    GetDSDDettail(dsd_id,dsd_agency,dsd_version);

    EnableStructureEditor();
}
function GetDSDDettail(dsd_id,dsd_agency,dsd_version){
        var data = {
            agency: dsd_agency,
            id: dsd_id,
            version: dsd_version
        };
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetDSD",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },
        {
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if (jsonResult == "" 
                    || !jsonResult.hasOwnProperty('DIMENSION')
                    || !jsonResult.hasOwnProperty('ATTRIBUTE')) {
                    // Errore nei risultati
                        
                }else{
                    // Successo finale

                    _layoutManager.ConceptSchemeControl('#dsd_concept',jsonResult,{
                        cs_lbl_title: "<%= Resources.Messages.lbl_concept %>",
                        cs_msg_dim_cur: "<%= Resources.Messages.msg_dim_curr_sel %>",
                        cs_msg_dim_max: "<%= Resources.Messages.lbl_dim_max %>",
                    },
                    "<%= Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString() %>",
                    100,
                    false,
                    false);

                    $("#btm_ds_create").button("option", "disabled", false);

                }
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
}
function DeleteDSD(dsd_id,dsd_agency,dsd_version){
    var data = {
        agency: dsd_agency,
        id: dsd_id,
        version: dsd_version
    };
    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"DeleteDSD",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },
    {
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){
            DisableStructureEditor();
            PopolateListDSD(); 
        },
        function(msg){
            var div_popup = document.createElement('div');
            $(div_popup).append('<p>'+msg+'</p>');
            $(div_popup).dialog({
                title: "Error", 
                position: { my: "center", at: "center", of: window },
                autoOpen: true,
                draggable: false,
                modal: true,
                closeOnEscape: false,
                width:280,
                height:360,
            });
            $(div_popup).dialog("open");
        },
        function(msg){
            _layoutManager.EnableLoadingDialog();
        },
        function(msg){
            _layoutManager.DisableLoadingDialog();
        },
        true);
}
function GetConceptSchemaDettail(cssIdContainer, dimmId){
    _layoutManager.ShowConceptSchematPopUp(cssIdContainer, dimmId);
}
function GetCodelist(Id, IsDimm) {

        var data = {
            code: Id,
            isDimensionCode: IsDimm
        }

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetCodelist",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if (!jsonResult.hasOwnProperty('CODELIST')) {
                    // Errore nei risultati

                }else{
                    var codelist = jsonResult.CODELIST;
                    var codes = jsonResult.CODES;
                    _layoutManager.ShowCodelistPopUp(codelist,codes);
                }
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
    }

function GetCubeDetails(Id) {
        var data = {
            code: Id
        }

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetCubeDetails",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
            try {
                    _layoutManager.ShowCubeDetailsPopUp(jsonResult);
                } catch (e) {
                    alert("sto cazzo");
                }
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
    }


function CreateDatastructure(){
                        
        var error=false;
        var errorMsg=[];

        var checkedDimVals = $('.chk_dimAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
        var checkedAttVals = $('.chk_attAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
        var cubeCat=$('#txt_category').data('idCat');
        var cubeCode=$('#txt_ds_code').val().trim().replace(' ','_').toUpperCase();
          
        var locationNames = [];
        $('.label_name_cube').each( function( ){

            var locale=$(this).data('locale');
            var text= $(this).data('text');

            var lang=[locale,text];

            locationNames.push(lang);

        });  
        
        var locationDescs = [];
        $('.label_desc_cube').each( function( ){                    
            var locale=$(this).data('locale');
            var text= $(this).data('text');

            if(locale=="en")useLangEn=true;

            var lang=[locale,text];

            locationDescs.push(lang);
        });

        if(cubeCode.length<1){
            errorMsg.push("<%= Resources.Notification.err_cubeCode %>");
            error=true;
        }
        if(cubeCat==undefined){
            errorMsg.push("<%= Resources.Notification.err_cubeCategory %>");
            error=true;
        }
        if(locationNames.length<1){                                      
            errorMsg.push("<%= Resources.Notification.err_cubeName %>");
            error=true;
        }
        if(checkedDimVals.length<1){                   
            errorMsg.push("<%= Resources.Notification.err_cubeDimensions %>");
            error=true;
        }

        if(!error)
        {

            var data = {
                code: cubeCode,
                urnCategory:cubeCat,
                names: locationNames, 
                descs: locationDescs,
                dimensions: checkedDimVals,
                attributes: checkedAttVals
            }

            var _ajaxRequestMan=new AjaxRequestManager({
                baseUrl:"<%= WSBuilder %>",
                method:"CreateDataSet",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });

            _ajaxRequestMan.SendRequest(
                data,
                function(jsonResult){
                                    
                    var div_popup=$("<div>");
                
                    if (jsonResult.hasOwnProperty('ERRORS')){
                    
                        $.each(jsonResult.ERRORS, function(i,msg){                      
                            div_popup.append('<p>'+msg+'</p>');
                        });
                    
                        $(div_popup).dialog({
                            title:"Datastructure",
                            position: { my: "center", at: "center", of: window },
                            autoOpen: false,
                            draggable: false,
                            modal: true,       
                            width:180,       
                            width:160,
                            closeOnEscape: false,
                            buttons: {
                                "Ok": function() {
                                    $( this ).dialog( "close" );
                                }
                            }
                        });

                    }else{ 
                        
                        div_popup.append('<p>'+jsonResult.NAME+'</p>');
                        div_popup.append('<p><%= Resources.Notification.succ_ds_create %></p>');

                        $(div_popup).dialog({
                            title:"Datastructure",
                            position: { my: "center", at: "center", of: window },
                            autoOpen: false,
                            draggable: false,
                            width:280,
                            height:120,
                            modal: true,
                            closeOnEscape: false,
                            buttons: {
                                "Ok": function() {

                                    PopolateListCube();
                                    PopolateListDSD();
                                    DisableStructureEditor();

                                    GetCubeDettail(jsonResult.IDSET);

                                    $( this ).dialog( "close" );
                                }
                            }
                        }); 
                    }
                
                    $(div_popup).dialog("open");

            },
                function(msg){

                    var div_popup=$("<div>");
                    div_popup.append('<p>'+msg+'</p>');
                    $(div_popup).dialog({
                        title:"Datastructure",
                        position: { my: "center", at: "center", of: window },
                        autoOpen: false,
                        draggable: false,
                        modal: true,
                        closeOnEscape: false,
                        buttons: {
                            "Ok": function() {
                                $( this ).dialog( "close" );
                            }
                        }
                    });
                    $(div_popup).dialog("open");
                },
                function(){
                    _layoutManager.EnableLoadingDialog();
                },
                function(){
                    _layoutManager.DisableLoadingDialog();
                },
                true); 
        }else{
            var div_popup=$("<div>");
            
            $.each(errorMsg, function(i,msg){                      
                div_popup.append('<p>'+msg+'</p>');
            });
                    
            $(div_popup).dialog({
                title:"Datastructure",
                position: { my: "center", at: "center", of: window },
                autoOpen: false,
                draggable: false,
                modal: true,
                closeOnEscape: false,
                buttons: {
                    "Ok": function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            $(div_popup).dialog("open");
        }

    }

function ShowLangPopUp(title,container,selector){
    // show popup with list
    var div_popup=$("<div>");
    $(div_popup).addClass('lang_popoup');
    var lang_select=$("<select id='langLocale'>");
    <% foreach (System.Globalization.CultureInfo culture in AvaibleCulture) { %>
        lang_select.append('<option value="<%= culture.TwoLetterISOLanguageName %>"><%= culture.DisplayName %></option>');
    <%} %>
    var txt_lang=$("<textarea id='txt_lang'>");

    div_popup.append(txt_lang);
    div_popup.append(lang_select);
                    
    $(div_popup).dialog({
        title:title,
        position:{ my: "center", at: "center", of: window },
        autoOpen: true,
        draggable: false,
        modal: true,
        closeOnEscape: false,
        width:320,
        height:420,
        buttons: {
            "Ok": function() {
                                                           
                var targetLocale = $(lang_select).val(); 
                var text = $(txt_lang).val();

                if(text!=""){

                    var nameExist=false;          
                    var labelLang=$('<p class="'+selector+'">');

                    $(container+" p").each(function() {
                        if($( this ).data('locale')==targetLocale){
                            nameExist=true;
                            $(this).empty();
                            labelLang=$( this );
                        }
                    });

                    $(labelLang).data('locale',$('#langLocale').val());
                    $(labelLang).data('text',$('#txt_lang').val()); 
                    $(labelLang).append('<span>'+$(labelLang).data('locale')+'</span> ');
                    $(labelLang).append($(labelLang).data('text'));
                
                    if(!nameExist) $(labelLang).appendTo($(container));

                    $( this ).dialog( "close" );

                    $( this ).empty();

                }

            },
            "Cancel": function() {

                $( this ).dialog( "close" );
            },
        }
    });
    
    $(div_popup).dialog("open");
}

function DisableStructureEditor(){

    $("#btm_delete_dsd").button("option", "disabled", true);
    $("#btm_name_langs").button("option", "disabled", true);
    $("#btm_desc_langs").button("option", "disabled", true);
    $("#btm_ds_create").button("option", "disabled", true);
    $("#btm_name_langs").button("option", "disabled", true);
    $("#btm_select_category").button("option", "disabled", true); 
    $("#btm_select_category").button("option", "disabled", true);
    
    $("#dsd_concept .ds_viewer").empty();

    $('#txt_category').val("");
    $('#txt_category').data('idCat',undefined);
    $('#txt_ds_code').val("");
    $('#div_name_langs').empty(); 
    $('#div_desc_langs').empty();
}
function EnableStructureEditor(){

    $("#btm_delete_dsd").button("option", "disabled", false);
    $("#btm_name_langs").button("option", "disabled", false);
    $("#btm_desc_langs").button("option", "disabled", false);
    $("#btm_ds_create").button("option", "disabled", false);
    $("#btm_name_langs").button("option", "disabled", false);
    $("#btm_select_category").button("option", "disabled", false); 
    $("#btm_select_category").button("option", "disabled", false);

}

function DisableMappingEditor(){

    $('#btm_mapping_create').button({ disabled: true });
    $("#btm_cube").button({ disabled: true });
    $('#btmUploadAjax').button({ disabled: true });
    $('#btm_addRelation').button({ disabled: true });
    $('#btm_delRelation').button({ disabled: true });

    $('#txt_cube').prop('readonly', true);
    $('input [name=FileUploadCSV]').prop('disabled', 'disabled');
    $('#txt_mapping_name').prop('readonly', true);
    $('#txt_mapping_desc').prop('readonly', true);

    $('input[name=charPeriod]').prop('readonly', true);
    $('input[name=transcodeTime]').prop('disabled', 'disabled');
    $('input[name=periodIndex]').prop('disabled', 'disabled');
    
    $('#charSeparatorCSV').prop('readonly', true);
    $('#chkFirstRowJump').prop('disabled', 'disabled');


}    
function EnableMappingEditor(){

    $('#btm_mapping_create').button({ disabled: false });
    $("#btm_cube").button({ disabled: false });
    $('#btmUploadAjax').button({ disabled: false });
    $('#btm_addRelation').button({ disabled: false });
    $('#btm_delRelation').button({ disabled: false });

    $('#txt_cube').prop('readonly', true);
    $('input [name=FileUploadCSV]').removeAttr('disabled');
    $('#txt_mapping_name').prop('readonly', false);
    $('#txt_mapping_desc').prop('readonly', false);

    $('input[name=charPeriod]').prop('readonly', false);
    $('input[name=transcodeTime]').removeAttr('disabled');
    $('input[name=periodIndex]').removeAttr('disabled');
    
    $('#charSeparatorCSV').prop('readonly', false);
    $('#chkFirstRowJump').removeAttr('disabled');

} 
function ClearMappingEditor(){

    IDCube=-1;
    $('#txt_cube').val('');
    $('input [name=FileUploadCSV]').val('');
    $('#txt_mapping_name').val('');
    $('#txt_mapping_desc').val('');

    $('input[name=charPeriod]').val('');
    $(':radio[value="0"]').prop('checked', true);
    $('#charSeparatorCSV').val(';');
    $('#chkFirstRowJump').prop('checked',false);

    $('#mapping_csv').empty();
    $('#mapping_custom').empty();  
    $('#mapping_custom').append('<ul class="mapping-list">');
    $('#mapping_custom ul.mapping-list').selectable({
        selected: function (event, ui) {
            $(ui.selected).siblings().removeClass("ui-selected");
        },
        stop: function() {
            $( ".ui-selected", this ).each(function() {
                var index = $("#mapping_custom ul li").index( this );
                c=(index+1);
                c_a=$("#mapping_custom ul li:nth-child("+(c)+") > p" ).data('valuea');
                c_b=$( "#mapping_custom ul li:nth-child("+(c)+") > p" ).data('valueb');
            });
        }
    });
    $('#mapping_sdmx').empty();
}             
function LoadMapping(idMappingScheme){

    IDMappingScheme=idMappingScheme;

    var data = {
        idschema:idMappingScheme 
    }

    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"GetMappingSchema",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){
            if(jsonResult!=""){
               
                $('#txt_mapping_name').val(jsonResult.Name);
                $('#txt_mapping_desc').val(jsonResult.Description);
                $('input[name=transcodeTime]').prop('checked',jsonResult.TranscodeUse);
                $('input[name=charPeriod]').val(jsonResult.TranscodeTime.stopChar);
                $(':radio[value="'+jsonResult.TranscodeTime.periodChar+'"]').prop('checked', true);
                $('#charSeparatorCSV').val(jsonResult.CSV_CHAR);
                $('#chkFirstRowJump').prop('checked',jsonResult.CSV_HASHEADER);
                $.each(jsonResult.Items, function(i,data){

                    $('#mapping_custom ul.mapping-list').append(
                    "<li><p class='mapping_item' >"+
                    "<span>"+data._c+"</span><span class='ui-icon ui-icon-transferthick-e-w'></span><span>"+data._b+"</span>"+
                    "</p></li>");

                });
            }
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

}
function DeleteMapping(idMappingScheme){
    var data = {
        idschema: idMappingScheme
    }

    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"DeleteMapping",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){
            //$('#mapping_list option[value="'+data.idschema+'"]').remove();
            ClearMappingEditor();
            PopolateListMapping();
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
}
function CreateMapping(){
    
    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"CreateMapping",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    var items_mapping=[];
    $('.mapping_item').each(function( index ) {
        items_mapping.push({
            _a: $(this).data('valuea'),
            _b: $(this).data('valuebstr'),
            _c: $(this).data('valueastr'),
        });
    });
    var _name=$('#txt_mapping_name').val();
    var _description=$('#txt_mapping_desc').val();
    var _conceptCount=$('#mapping_sdmx').data('itemCount'); 
    var _useTrans=$('input[name=transcodeTime]').prop('checked');
    var _period=$('input[name=periodIndex]:checked').val();
    var _charPeriod=$('input[name=charPeriod]').val(); 
    var _csv_file_char=$('#charSeparatorCSV').val();
    var _csv_file_hasHeader=$('#chkFirstRowJump').prop('checked');

    var  error=false;
    var  errors=[];
    $('#mapping_sdmx .item-mapping-list').each(function( index ) {
        if(($(this).data('mandatory') == true || $(this).data('mandatory') == undefined) && $(this).parent().attr("mapped") != "true" )
        {
            error = true;
        }
    });

    if(error){
        errors.push("<%= Resources.Messages.lbl_mapping_all_component %>");
    }

//    if(items_mapping.length!=_conceptCount){
//        error=true;
//        errors.push("<%= Resources.Messages.lbl_mapping_all_component %>");  
//    
//    }

    if(_useTrans && _charPeriod==""){
        error=true;
        errors.push("<p><%= Resources.Messages.lbl_mapping_specific_char %></p>");  
    }
    if(IDCube<0){
        error=true;
        errors.push("<p><%= Resources.Messages.lbl_mapping_specific_dataset %></p>");  
    }

    if(!error){
        var data={
                idset: IDCube,
                name:_name,
                description:_description,
                items:items_mapping,
                csv_file_char:_csv_file_char,
                csv_file_hasHeader:_csv_file_hasHeader,
                trans_use:_useTrans,
                trans_char:_charPeriod,
                trans_period:_period
            };

            _ajaxRequestMan.SendRequest(
                data,
                function(jsonResult){

                    var div_popUp = document.createElement('div');
                    $(div_popUp).append('<p><%= Resources.Notification.succ_mapping_create %></p>');
                    $(div_popUp).dialog({
                        title: "Mapping Set",
                        position: { my: "center", at: "center", of: window },
                        resizable: false,
                        width:180,
                        height:160,
                        modal: true,
                        buttons: {
                            "Ok": function() {  
                                ClearMappingEditor();
                                PopolateListMapping();
                                
                                LoadMapping(jsonResult.IDSchema );
                                $("#mapping_list").val(jsonResult.IDSchema);

                                $( this ).dialog( "close" );
                            }
                        }
                    });


                },
                function(msg){

                    var div_popUp = document.createElement('div');
                    $(div_popUp).append('<p><%= Resources.Notification.err_mapping_create %></p>');
                    $(div_popUp).dialog({
                        title: "Mapping Set",
                        position: { my: "center", at: "center", of: window },
                        resizable: false,
                        width:180,
                        height:160,
                        modal: true,
                        buttons: {
                            "Ok": function() {
                                ClearMappingEditor();
                                PopolateListMapping();
                                $( this ).dialog( "close" );
                            }
                        }
                    });
                },
                function(msg){
                },
                function(msg){
                },
                true);
    }
    else{
        var div_popUp = document.createElement('div');            
        
        $.each(errors,function(i,dataMsg){
            $(div_popUp).append('<p>'+dataMsg+'</p>');
        });
        $(div_popUp).dialog({
            title: "Mapping Set",
            position: { my: "center", at: "center", of: window },
            resizable: false,
            width:320,
            height:240,
            modal: true,
            buttons: {
                "Ok": function() {
                    $( this ).dialog( "close" );
                }
            }
        }); 
    }
}

function ShowCubePopUp(){
  
    $('#cube_popup').empty(); 
         
    var domainTreeView=document.createElement('div');
        
    $('#cube_popup').dialog({
        title: "<%= Resources.Messages.lbl_set_domain %>",
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
                    $('#txt_mapping_name').val("MAPSET_"+cubeSelected.text+"_");
                    $('#txt_cube').val(cubeSelected.text);
                    $('#txt_cube').data('idCube',cubeSelected.id.substring(3,cubeSelected.id.length));
                                               
                    IDCube=$('#txt_cube').data('idCube');
                        
                    GetCubeComponent(IDCube);
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
                                 
    $(domainTreeView).appendTo($('#cube_popup'));

}
function UploadCSV(){
    _layoutManager.EnableLoadingDialog();

    var data = new FormData();
    var file = $('#FileUploadCSV')[0].files[0];
    if (file) {
        data.append('UploadedCSV', file);
        data.append('charSeparator', $('#charSeparatorCSV').val());
        data.append('chkFirstRowJump', $('#chkFirstRowJump').prop('checked'));
    }
    $.ajax({
        type: "POST",
        url: "<%= WSBuilder %>/UploadFileCSV",
        cache: false,
        contentType: false,
        processData: false,
        dataType: "json",
        data: data,
        success: function (jsonResult) {
            if (jsonResult.hasOwnProperty('error')) {
                _layoutManager.DisableLoadingDialog();
            } else {
                   
                if (jsonResult.hasOwnProperty('headers')) {

                    _layoutManager.ShowListMapping('#mapping_csv',jsonResult.headers,function(index){
                        a=index;
                    });
                }
                if (jsonResult.hasOwnProperty('timeformat')){
                    $('input[name=espCurr]').val(jsonResult.timeformat);
                }
                
                _layoutManager.DisableLoadingDialog();

            }
        },
        error: function () {

            _layoutManager.DisableLoadingDialog();
        }
    });
}
function GetCubeComponent(id){

    var data = {
        idCube: id
    }

    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"GetCubeComponent",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){
            
            _layoutManager.ShowListMappingSdmx('#mapping_sdmx',jsonResult.DIMENSION,jsonResult.ATTRIBUTE,function(index){
                b=index;
            });
        },
        function(msg){

        },
        function(msg){
        },
        function(msg){
                    
        },
        true);

}

function GetTreeCube(){
                                     
    var cubeTreeView=document.createElement('div');
    $('#btm_delete_cube').button({ disabled: true }); 
    $('#btm_production').button({ disabled: true });

    $(cubeTreeView)
    .on('changed.jstree', function (e, data) {
        if(data.selected.length>0){
            
            var selObj=data.instance.get_node(data.selected[0]);
                            
            $(".dsd_list").find("option").attr("selected", false);
            DisableStructureEditor();

            if(selObj.type=="dataset"){

                $('#btm_production span').text((selObj.data.inProduction.toString()=="true")?"<%= Resources.Messages.lbl_set_out_production %>":"<%= Resources.Messages.lbl_set_in_production %>");
                $('#btm_production').button({ disabled: false });
                $('#btm_delete_dataset').button({ disabled: false });
                                        
                var idCube=(selObj.id.substring(3,selObj.id.length));
                GetCubeDettail(idCube);
            }
            else{

                $('#btm_production').button({ disabled: true });
                $('#btm_delete_dataset').button({ disabled: true });
                
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
                "valid_children" : ["categoryScheme"]
            },
            "categoryScheme" : {
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

function GetCubeDettail(id){

    var data = {
        idset: id
    }

    var _ajaxRequestMan=new AjaxRequestManager({
        baseUrl:"<%= WSBuilder %>",
        method:"SetDataset",
        locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
    },{
        titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
        messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
    });

    _ajaxRequestMan.SendRequest(
        data,
        function(jsonResult){

            _layoutManager.ConceptSchemeControl('#dsd_concept',jsonResult,{
                cs_lbl_title: "<%= Resources.Messages.lbl_concept %>",
                cs_msg_dim_cur: "<%= Resources.Messages.msg_dim_curr_sel %>",
                cs_msg_dim_max: "<%= Resources.Messages.lbl_dim_max %>",
            },
            "<%= Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString() %>",
            100,
            true,
            false);

            $('#txt_category').val(jsonResult.THEME);
            $('#txt_ds_code').val(jsonResult.CODE);
          
            $('#div_name_langs').empty();
            $.each(jsonResult.NAMES,function(i,data){
                $('#div_name_langs').append("<p><span>"+data.Locale+"</span> "+data.Value+"</p>");
            });


            //console.log(jsonResult);
        },
        function(msg){

        },
        function(msg){
        },
        function(msg){
                    
        },
        true);
}
function OnDimmCheck(dimmId, maxDim) {
    var checkedValue = 0;
    var inputElements = document.getElementsByClassName('dimmChk');
    for (var i = 0; inputElements[i]; ++i) {
        if (inputElements[i].checked) {
            checkedValue++;
        }
    }
    if (checkedValue > maxDim)
        $('#' + dimmId).removeAttr('checked');

    $('#comp_count').text(checkedValue);
}

/*
$("#btm_export_dsd").button({ disabled: true });
$("#btm_export_dsd").click(function (){

    var divDownload = document.createElement('div');
    $(divDownload).append('<p><input type="radio" name="optDownload" value="dsd" checked="checked" />Download DSD</p>');
    $(divDownload).append('<p><input type="radio" name="optDownload" value="codelist" />Download Codelist</p>');
    $(divDownload).append('<p><input type="radio" name="optDownload" value="all" />Download DSD and Codelist</p>');
    $(divDownload).dialog({
        title: "Download",
        position: { my: "center", at: "center", of: window },
        resizable: false,
        height:180,
        modal: true,
        buttons: {
            "Download": function() {

                var dsd_indentity = $('#dsd_list').val();
                dsd_indentity=dsd_indentity.split(<= ISTAT.ENTITY.SDMXIdentifier.char_separator %>);
        
                var checkedDimVals = $('.chk_dimAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
                var checkedAttVals = $('.chk_attAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
                var optDownload=$('input[name=optDownload]:checked').val();
                var data = {
                    agency: dsd_indentity[0],
                    id: dsd_indentity[1],
                    version: dsd_indentity[2],
                    dimensions:checkedDimVals,
                    attributes:checkedAttVals,
                    type_download:optDownload
                };

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: "<= WSBuilder %>/CreateExport",
                    data: JSON.stringify(data),
                    success: function (data) {
                        if(data.hasOwnProperty("error")){
                            _layoutManager.ReportError('#ds_notifier','<= Resources.Notification.err_download %>',false);
                        }else{
                            document.getElementById('<= btm_hide_download.ClientID %>').click();
                        }
                    },
                    complete: function () {

                    }
                });
                $( this ).dialog( "close" );
            },
            Cancel: function() {
                $( this ).dialog( "close" );
            }
        }
    });

    return false;
    });
*/


</script>

</asp:Content>
