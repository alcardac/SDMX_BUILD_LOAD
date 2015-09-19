<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Install.aspx.cs" Inherits="SDMX_Dataloader.Main.Install" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

<div class="section ui-widget ui-widget-content ui-corner-all"> 

    <div class="innerContent">

    <p class="fieldLabel"><%= Resources.Messages.msg_DB_Not_Found%></p>

<%--    <table> 
        <tr>
            <th class="seventyfive"></th>
            <th class="twentyfive"></th>
        </tr>
        <tr>
            <td colspan="2"><p class="fieldLabel"><%= Resources.Messages.lbl_install_required %></p></td>
        </tr>
        <tr>
            <td colspan="2"><p><%= Resources.Messages.msg_install_required %></p></td>
        </tr>
        <tr>                                               
            <td><p><span id="icon_db_<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>" class="ui-icon ui-icon-alert"></span><%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString()%></p></td>
            <td><a href="#" id="btm_install_<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>"><%= Resources.Messages.lbl_btn_install%></a></td>
        </tr>
        <tr>                                               
            <td><p><span id="icon_db_<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>" class="ui-icon ui-icon-alert"></span><%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString()%></p></td>
            <td><a href="#" id="btm_install_<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>"><%= Resources.Messages.lbl_btn_install%></a></td>
        </tr>
    </table>--%>

           
    </div>
</div>

    <script type="text/javascript">

    $(document).ready(function () {
        $("#btm_install_<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>").button();
        $("#btm_install_<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>").button();

        $("#btm_install_<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>").click(function () {
                       
            ShowAlertClient("<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>");

        });
        $("#btm_install_<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>").click(function () {

            ShowAlertClient("<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>");

        });
    
        CheckDB("<%= ISTAT.DBDAL.DB_NAME.DatawarehouseServer.ToString() %>");
        CheckDB("<%= ISTAT.DBDAL.DB_NAME.MappingStoreServer.ToString() %>");
    
    });

        function ShowAlertClient(dbname){
            // Client alert
            // show popup with list
            var div_popup=$("<div/>");

            div_popup.append("<p><%= Resources.Messages.lbl_msg_alert_install%></p>");
                    
            $(div_popup).dialog({
                title:"<%= Resources.Messages.lbl_install_required %>",
                position: { my: "center", at: "center", of: window },
                autoOpen: false,
                draggable: true,
                closeOnEscape: false, 
                width:240,
                height:120,
                buttons: {
                        "Ok": function() {
                            $( this ).dialog( "close" );
                            ResetDB(dbname) ;
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
            });

            $(div_popup).dialog("open");
            
        }

        function ShowLog(listMsgs){
              
            var   resultItems=[];
            $.each(listMsgs, function (i, item) {
                resultItems.push("<li><p><span>"+item.LogTitle+"</span>"+item.LogMessage+"</p></li>");
            });

            var divReportPanel = document.createElement('div');
                $(divReportPanel).addClass('report-container');
                $("<ul/>", {
                    "class": "report-list",
                    html: resultItems.join("")
                }).appendTo($(divReportPanel));

            var div_popup=$("<div/>");

            div_popup.append(divReportPanel);
                    
            $(div_popup).dialog({
                title:"<%= Resources.Messages.lbl_install_required %>",
                position: { my: "center", at: "center", of: window },
                autoOpen: false,
                draggable: true, 
                width:360,
                height:240,
                closeOnEscape: true
            });

            $(div_popup).dialog("open");
        }

        function ResetDB(dbname) {
            
            // Send request to Service
            var data = {
                    dbName: dbname
                }       
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSProfile %>",
                method:"ResetDB",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });
            _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                
                if(jsonResult.hasOwnProperty("ERRORS")){
                    ShowLog(jsonResult.ERRORS);
                }
                
                CheckDB(dbname);

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

        function CheckDB(dbname) {
            var data = {
                    dbName: dbname
                }       
            var _ajaxRequestMan=new AjaxRequestManager(
            {
                baseUrl:"<%= WSProfile %>",
                method:"CheckDB",
                locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
            },{
                titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
                messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
            });
            _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if(jsonResult.toString()==="true"){                                
                    $('#icon_db_'+dbname).removeClass('ui-icon-check');
                    $('#icon_db_'+dbname).removeClass('ui-icon-alert');
                    $('#icon_db_'+dbname).addClass('ui-icon-check');
                    //$('#btm_install_'+dbname).button({ disabled: true }); 
                }else {                                             
                    $('#icon_db_'+dbname).removeClass('ui-icon-check');
                    $('#icon_db_'+dbname).removeClass('ui-icon-alert');
                    $('#icon_db_'+dbname).addClass('ui-icon-alert');
                    //$('#btm_install_'+dbname).button({ disabled: false });
                }   
            },
            function(msg){
                //console.log("err callback");
                //_layoutManager.DisableLoadingDialog();
            },
            function(msg){
                //console.log("pre callback");
                //_layoutManager.EnableLoadingDialog();
            },
            function(msg){
                //console.log("post callback");
                //_layoutManager.DisableLoadingDialog();
            },
            true);
        }

    </script>


</asp:Content>