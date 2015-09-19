<%@ Control 
Language="C#" 
AutoEventWireup="true" 
CodeBehind="DataFlowControl.ascx.cs" 
Inherits="SDMX_Dataloader.Main.Controls.DataFlowControl" %>

<% int maxDimension = 100; %>

<%@ Register TagPrefix="uc" TagName="MultipleFileUploadControl" Src="~/Controls/MultipleFileUploadControl.ascx" %>

<script type="text/javascript">

    var MaxDimm = <%= maxDimension %>;
    _layoutManager.select_ds='#<%=ds_avaible.ClientID %>';
    _layoutManager.select_dsd='#dsd_list';

</script>

<div class="container">

    <div id="ds_notifier" class="notifier"></div>

    <div id="ds_tabs" class="innerContent">
        <ul>
            <li><a href="#tabs-1" class="fieldLabel"><%= Resources.Messages.lbl_ds_avaible%></a></li>
            <li><a href="#tabs-2" class="fieldLabel"><%= Resources.Messages.lbl_ds_new%></a></li>
            <li><a href="#tabs-3" class="fieldLabel"><%= Resources.Messages.lbl_dsd_import%></a></li>
        </ul>
        <div id="tabs-1">
            <table id="ds_select" class="table_container">
                <tr>
                    <td colspan="2"><p class="procedureText"><%= Resources.Messages.msg_dtcontrol_a_1%></p></td>
                </tr>
                <tr>
                    <td><p class="fieldLabel"><%= Resources.Messages.lbl_ds_avaible%></p></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="fivety"><asp:ListBox id="ds_avaible" runat="server" CssClass="fillHeight"></asp:ListBox></td>
                    <td><div class="ds_viewer"></div></td>
                </tr>
                <tr>
                    <td><a href="#" id="btm_production"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_in_production%></a></td>
                    <td><a href="#" id="btm_ds_delete"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_ds_delete%></a></td>
                </tr>
                <tr>
                    <td colspan="2"><p class="procedureText"><%= Resources.Messages.msg_dtcontrol_a_2%></p></td>
                </tr>
            </table>
        </div>
        <div id="tabs-2">
            
            <table id="ds_new" class="table_container">
                <tr>
                    <td colspan="2"><p class="procedureText"><%= Resources.Messages.msg_dtcontrol_b_1%></p></td>
                </tr>
                <tr>
                    <td><p class="fieldLabel"><%= Resources.Messages.lbl_dsd_avaible%></p> </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="fivety column" >
                        <select id="dsd_list" size="10"></select>
                    </td>
                    <td>
                        <p class="contentLabel"><%= Resources.Messages.lbl_ds_code%></p>
                        <input type="text" name="txt_ds_code" id="txt_ds_code" value="" />
                        <p class="contentLabel"><%= Resources.Messages.lbl_ds_category%></p>

                        <asp:DropDownList ID="theme_avaible"  runat="server" SelectionMode="Single"></asp:DropDownList>
                         
                        <% char optional=' '; %>
                        <% foreach (System.Globalization.CultureInfo culture in AvaibleCulture)
                            { %>
                                <p class="contentLabel"><%= optional %><%= Resources.Messages.lbl_ds_name%> <%= culture.DisplayName%></p>
                                <input type="text" class="txt_names" data-locale="<%= culture.TwoLetterISOLanguageName %>" name="txt_ds_name_<%= culture.TwoLetterISOLanguageName %>" value="" />
                                <% optional='*'; %>
                            <%} %>
                        <div class="ds_viewer"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                        <a href="#" id="btm_refresh_list_dsd"><span class="ui-icon ui-icon-circle-check"></span><%= Resources.Messages.lbl_reload %></a>
                        <a href="#" id="btm_dsd_delete"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_dsd_delete %></a>
                        </td>
                    <td>
                        <a href="#" id="btm_ds_create"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_ds_create %></a>
                        
                        <asp:Button CssClass="hidden" runat="server" id="btm_hide_download" OnClick="btm_export_dsd_Click" Text="Download .Stat"></asp:Button>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><p class="procedureText"><%= Resources.Messages.msg_dtcontrol_b_2%></p></td>
                </tr>
            </table>

        </div>
        <div id="tabs-3">
            
            <uc:MultipleFileUploadControl ID="MultipleFileUploadControl_data" runat="server"  
                    Text="<%# Resources.Messages.lbl_upload_file_xml_schema%>" 
                    ServerDomain="<%# WSBuilder %>" 
                    ServerPage="/UploadFileSDMXSchema" 
                    NameParam="sdmxSchemaFiles"
                    IDDivFile="sdmxSchemaFileUploader"
                    ReloadOnUpload="true"
                    ReportOnUpload="true"  ></uc:MultipleFileUploadControl>

        </div>
    </div>  

</div>

<script type="text/javascript">

    //Setup
    $('#ds_tabs').tabs({ 
        active: 0,
        beforeActivate: function (event, ui) {
            if (event.currentTarget != undefined){
                if (event.currentTarget.hash == '#tabs-1') {

                }
                if (event.currentTarget.hash == '#tabs-2') {

                    PopolateListDSD();       
                    $('#dsd_list').height($('#dsd_list').closest('td').height());
                    _layoutManager.InitControl_ds();
                }
                if (event.currentTarget.hash == '#tabs-3') {

                }
            }
        } 
    });

    $("#btm_ds_delete").button(); 
    
    $("#btm_ds_create").button({ disabled: true });
    $("#btm_dsd_delete").button({ disabled: true }); 
    $("#btm_production").button({ disabled: true }); 
    $("#btm_export_dsd").button({ disabled: true }); 
    $("#btm_refresh_list_dsd").button({ disabled: false });

    $('.ds_viewer').empty();
    $('.ds_input').hide();
      
    /* Select df procedure */
    $('#<%=ds_avaible.ClientID %>').change(function () {
        
        var data = {
            idset: $(this).val()
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
                if (jsonResult == "" 
                    || !jsonResult.hasOwnProperty('DIMENSION')
                    || !jsonResult.hasOwnProperty('ATTRIBUTE')) {
                    // Errore nei risultati
                    
                    //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);

                }else{
                
                    //_layoutManager.ReportSuccess('#ds_notifier','<%= Resources.Notification.succ_dsd_valid %>',false);

                    _layoutManager.ConceptSchemeControl('#ds_select',jsonResult,{
                        cs_lbl_title: "<%= Resources.Messages.lbl_concept %>",
                        cs_msg_dim_cur: "<%= Resources.Messages.msg_dim_curr_sel %>",
                        cs_msg_dim_max: "<%= Resources.Messages.lbl_dim_max %>",
                    },
                    "<%= Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString() %>",
                    MaxDimm,
                    true,
                    false);

                    if(jsonResult.PRODUCTION.toString()==="true"){            
                        $("#btm_production").html("<span class='ui-icon ui-icon-circle-minus'></span> <%= Resources.Messages.lbl_out_production%>");
                        $('#btm_production').data('status','true');
                    }else{                                                      
                        $("#btm_production").html("<span class='ui-icon ui-icon-circle-plus'></span> <%= Resources.Messages.lbl_in_production%>");
                        $('#btm_production').data('status','false');
                    }
                    $("#btm_production").button({ disabled: false });


                }
            },
            function(msg){
                //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

    });
    /* New df procedure */

    $('#dsd_list').change(function () {


        var dsd_indentity = $(this).val();
        dsd_indentity=dsd_indentity.split('<%= ISTAT.ENTITY.SDMXIdentifier.char_separator %>');
        
        var data = {
            agency: dsd_indentity[0],
            id: dsd_indentity[1],
            version: dsd_indentity[2]
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
                    //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);
                }else{
                    // Successo finale

                    _layoutManager.ConceptSchemeControl('#ds_new',jsonResult,{
                        cs_lbl_title: "<%= Resources.Messages.lbl_concept %>",
                        cs_msg_dim_cur: "<%= Resources.Messages.msg_dim_curr_sel %>",
                        cs_msg_dim_max: "<%= Resources.Messages.lbl_dim_max %>",
                    },
                    "<%= Org.Sdmxsource.Sdmx.Api.Constants.AttributeAttachmentLevel.DimensionGroup.ToString() %>",
                    MaxDimm,
                    false,
                    false);

                    $('#comp_info').show();
                    $('#ds_new .ds_viewer').show();
                    $('#ds_select .ds_viewer').show();
                    $("#btm_ds_create").button("option", "disabled", false);
                    $("#btm_export_dsd").button("option", "disabled", false);
                    $("#btm_dsd_delete").button("option", "disabled", false);                                                            
                    $('#dsd_list').height($('#dsd_list').closest('td').height());

                }
            },
            function(msg){
                //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);
    });
    
    $("#btm_ds_create").click(function () {
    
        var checkedDimVals = $('.chk_dimAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
        var checkedAttVals = $('.chk_attAvaible:checkbox:checked').map(function () { return $(this).attr('id'); }).get();
        var idTheme;
        var locationNames = [];

        $('.txt_names').each( function( ){
            var lang=[$(this).data('locale'),$(this).val()];
            locationNames.push(lang);
        });
        
        var data = {
            code: $('#txt_ds_code').val(),
            idtheme:$('#<%=theme_avaible.ClientID %>').val(),
            names: locationNames,
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

                if (jsonResult == "" 
                    || !jsonResult.hasOwnProperty('DIMENSION')
                    || !jsonResult.hasOwnProperty('ATTRIBUTE')) {
                    // Errore nei risultati
                    _layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_create %>',false);
                }else{
                    // Successo finale
                    if (jsonResult.hasOwnProperty('IDSET')
                    || !jsonResult.hasOwnProperty('NAME')
                    || !jsonResult.hasOwnProperty('DIMENSION')
                    || !jsonResult.hasOwnProperty('ATTRIBUTE')){
                    
                        _layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_create %>',false);
                    }
                    
                    _layoutManager.ReportSuccess('#ds_notifier','<%= Resources.Notification.succ_dsd_create %>',false);
                    
                    
                    if (jsonResult.hasOwnProperty('IDSET') && jsonResult.hasOwnProperty('NAME')) {
                        $('#<%= ds_avaible.ClientID %>').append('<option value="'+jsonResult.IDSET+'">'+jsonResult.NAME+'</option>');
                    }

                    $("#ds_tabs").tabs( "option", "active", 0 );
                    
                }
            },
            function(msg){
                _layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_create %>',false);
            },
            function(){
                _layoutManager.InitControl_ds();
                _layoutManager.EnableLoadingDialog();
            },
            function(){
                    
                _layoutManager.DisableLoadingDialog();
            },
            true);
        return false;
    });
      
    $("#btm_production").click(function (){
        var data = {
            active: ($('#btm_production').data('status')==="true")?false:true
        }

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
                _layoutManager.ReportSuccess('#ds_notifier','<%= Resources.Notification.succ_cube_in_prod %>',false);
                
                if(jsonResult.hasOwnProperty('PRODUCTION')){
                    if(jsonResult.PRODUCTION.toString()==="true"){            
                        $("#btm_production").html("<span class='ui-icon ui-icon-circle-minus'></span> <%= Resources.Messages.lbl_out_production%>");
                        $('#btm_production').data('status','true');
                    }else{                                                      
                        $("#btm_production").html("<span class='ui-icon ui-icon-circle-plus'></span> <%= Resources.Messages.lbl_in_production%>");
                        $('#btm_production').data('status','false');
                    } 
                    $("#btm_production").button("option", "disabled", false); 
                }
            },
            function(msg){
                _layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_cube_in_prod %>',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

        return false;
    });

    $("#btm_ds_delete").click(function (){

    
        var data = {
            idset: $('#<%=ds_avaible.ClientID %>').val()
        }
        if(data.idset<0)return false;

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
                _layoutManager.ReportSuccess('#ds_notifier','<%= Resources.Notification.succ_dsd_delete %>',false);
            },
            function(msg){
                _layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_delete %>',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
                
                $('#<%= ds_avaible.ClientID %> option[value="'+data.idset+'"]').remove();

                _layoutManager.InitControl_ds();

            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

        return false;
    });

    <% if(!ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser, ISTAT.ENTITY.UserDef.ActionDef.CRUDDataset)){ %>    
        $( "#ds_tabs" ).tabs( "option", "disabled", [ 1 ] );
    <% } %>
               
    <% if(!ISTAT.ENTITY.UserDef.UserCan(SDMX_Dataloader.Main.Global.LoggedUser, ISTAT.ENTITY.UserDef.ActionDef.CRUDSchema)){ %>    
        $( "#ds_tabs" ).tabs( "option", "disabled", [ 1,2 ] );
    <% } %>

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
                    //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);
                }else{
                    var codelist = jsonResult.CODELIST;
                    _layoutManager.ShowCodelistPopUp(codelist);
                }
            },
            function(msg){
                
                //_layoutManager.ReportError('#ds_notifier','<%= Resources.Notification.err_dsd_invalid %>',false);
            },
            function(){
                _layoutManager.EnableLoadingDialog();
            },
            function(){
                _layoutManager.DisableLoadingDialog();
            },
            true);
    }

</script>