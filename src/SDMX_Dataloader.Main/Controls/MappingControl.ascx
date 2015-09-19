<%@ Control Language="C#" 
AutoEventWireup="true" 
CodeBehind="MappingControl.ascx.cs" 
Inherits="SDMX_Dataloader.Main.Controls.MappingControl" %>

<div class="container">

    <div id="mapping_notifier" class="notifier"></div>
    
    <p class="procedureText"><%= Resources.Messages.msg_mapping_a_1%></p>

    <div id="mapping_tabs" class=" innerContent">
        <ul>
            <li><a href="#tabs-1" class="fieldLabel"><%= Resources.Messages.lbl_mapping_avaible%></a></li>
            <li><a href="#tabs-2" class="fieldLabel"><%= Resources.Messages.lbl_mapping_new%></a></li>
        </ul>
        <div id="tabs-1">
            
            <table id="mapping_select">
                <tr>
                    <td class="seventyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_mapping_avaible%></p></td>
                    <td class="twentyfive"></td>
                </tr>
                <tr>
                    <td><asp:DropDownList id="mapping_avaible" runat="server"></asp:DropDownList></td>
                    <td><a href="#" id="btm_mapping_delete"><span class="ui-icon ui-icon-circle-minus"></span><%= Resources.Messages.lbl_mapping_delete%></a></td>
                </tr>
                <tr>
                    <td><div id="mapping_preview" class="selectable-list"></div></td>
                    <td></td>
                </tr>
            </table>

        </div>
        <div id="tabs-2">
            
            <table id="mapping_new">
                <tr>
                    <td class="twentyfive"><p class="fieldLabel"><%= Resources.Messages.lbl_mapping_new %></p></td>
                    <td colspan="2"><p id="lbl_mapping"></p></td>
                </tr>
                <tr>
                    <td class="thirty"></td>
                    <td class="fourty">
                        <a href="#"  id="btm_delRelation" class="onRight"><span class="ui-icon ui-icon-minus"></span></a>
                        <a href="#"  id="btm_addRelation"class="onLeft"><span class="ui-icon ui-icon-plus"></span></a>
                    </td>
                    <td class="thirty"></td>
                </tr>
                <tr>
                    <td><div id="mapping_csv" class="selectable-list ui-widget-content"></div></td>
                    <td>
                        <div id="mapping_custom" class="selectable-list  ui-widget-content">
                            <ul class="mapping-list"></ul>
                        </div>
                    </td>
                    <td><div id="mapping_sdmx" class="selectable-list ui-widget-content"></div></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td><a href="#" id="btm_mapping_create"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_mapping_create%></a></td>
                </tr>
            </table>

        </div>
    </div>


</div>

<script type="text/javascript">

    var a=0;
    var b=0;
    var c=0;
    var c_a=0;
    var c_b=0;

    _layoutManager.select_mapping='#<%= mapping_avaible.ClientID %>';

    $('#btm_mapping_delete').button();
    $('#btm_mapping_delete').click(function(){
    
        var data = {
            idschema: $('#<%=mapping_avaible.ClientID %>').val()
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
                _layoutManager.ReportSuccess('#mapping_notifier',"<%= Resources.Notification.succ_mapping_delete%>",false);
            },
            function(msg){
                _layoutManager.ReportError('#mapping_notifier',"<%= Resources.Notification.err_mapping_delete%>",false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
                $('#<%= mapping_avaible.ClientID %> option[value="'+data.idschema+'"]').remove();
                _layoutManager.InitControl_mapping();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

        return false;
    });

    $('#btm_mapping_create').button();
    $('#btm_mapping_create').click(function(){

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
            });
        });
        var data={
            name:$('#lbl_mapping').text(),
            items:items_mapping
        };

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                _layoutManager.ReportSuccess('#mapping_notifier',"<%= Resources.Notification.succ_mapping_create%>",false);
                $('#mapping_tabs').tabs({active:0});
            },
            function(msg){
                _layoutManager.ReportError('#mapping_notifier',"<%= Resources.Notification.err_mapping_create%>",false);
            },
            function(msg){
            },
            function(msg){
            },
            true);

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

            $('#mapping_custom ul.mapping-list').append(
            "<li><p class='mapping_item' data-valuea='"+dataIndexA+"' data-valueb='"+dataIndexB+"'  data-valuebstr='"+dataB+"'>"+
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
            $( "#mapping_custom ul li:nth-child("+c+")" ).remove();
        }

        return false;
    });

    $('#<%= mapping_avaible.ClientID %>').change(function () {
        
        var data = {
            idschema: $(this).val()
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
                    _layoutManager.ShowMappingViewer('#mapping_preview',jsonResult.Items);
                }
            },
            function(msg){
                _layoutManager.ReportError('#mapping_notifier',msg,false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
                _layoutManager.InitControl_ds();
            },
            function(msg){
                    
                _layoutManager.DisableLoadingDialog();
            },
            true);

    });

    $('#mapping_tabs').tabs({
        active:0,
        beforeActivate: function (event, ui) {
            GetMapping();    
            if(event.currentTarget!=undefined)
                if(event.currentTarget.hash =='#tabs-2') {

                    $('#lbl_mapping').text("");
                    $('#mapping_csv').empty();
                    $('#mapping_custom ul').empty();
                    $('#mapping_sdmx').empty();

                    LoadEditorMapping();
                }
        }
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

    function GetMapping(){
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetMappings",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                
                $('#<%= mapping_avaible.ClientID %>').empty();
                $('#<%= mapping_avaible.ClientID %>').append('<option value="-1" selected ><%= Resources.Messages.lbl_select_mapping %></option>');
                
                $.each(jsonResult,function(key,value){
                    $('#<%= mapping_avaible.ClientID %>').append('<option value="'+value.IDSchema+'">'+value.Name+'</option>');
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

    function LoadEditorMapping(){

        /************************
        Get name mapping
        ************************/
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"InitMapping",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                        
                $('#lbl_mapping').text(jsonResult.Name);


                /************************
                Get header of csv
                ************************/
                var _ajaxRequestMan=new AjaxRequestManager({
                    baseUrl:"<%= WSBuilder %>",
                    method:"GetCurrentHeaders",
                    locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                },{
                    titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                    messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                });
                _ajaxRequestMan.SendRequest(
                    null,
                    function(jsonResult){

                        _layoutManager.ShowListMapping('#mapping_csv',jsonResult,function(index){
                            a=index;
                        });

                        /************************
                        Get Concept of dsd
                        ************************/
                        var _ajaxRequestMan=new AjaxRequestManager({
                            baseUrl:"<%= WSBuilder %>",
                            method:"GetDimAtt",
                            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
                        },{
                            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
                        });

                        _ajaxRequestMan.SendRequest(
                            null,
                            function(jsonResult){
                                _layoutManager.ShowListMappingSdmx('#mapping_sdmx',jsonResult.DIMENSION,jsonResult.ATTRIBUTE,function(index){
                                    b=index;
                                });
                            },
                            function(msg){
                                _layoutManager.ReportError('#mapping_notifier',msg);
                            },
                            function(msg){
                            },
                            function(msg){
                    
                            },
                            true);
                        
                        /************************/
                    },
                    function(msg){
                        _layoutManager.ReportError('#mapping_notifier',msg);
                    },
                    function(msg){
                        _layoutManager.EnableLoadingDialog();
                        _layoutManager.InitControl_mapping();
                    },
                    function(msg){
                    
                        _layoutManager.DisableLoadingDialog();
                    },
                    true);
                
                /************************/

            },
            function(msg){
                _layoutManager.ReportError('#mapping_notifier',msg);
            },
            function(msg){
            },
            function(msg){
                    
            },
            true);
        
        /************************/
            
    }

</script>