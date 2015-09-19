<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImportControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.ImportControl" %>


<div class="container">

    <div id="final_notifier" class="notifier"></div>

    <div id="data_importer" class="innerContent">

        <table>
            <tr>
                <td><input type="checkbox" name="optSendEmail" checked="checked" <%--disabled="disabled"--%>/><p><%= Resources.Messages.lbl_opt_import_send_mail %></p></td>
                <td><input type="text" value="<%= SDMX_Dataloader.Main.Global.LoggedUser.Email %>" name="optEmail"<%-- disabled="disabled"--%>/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <a href="#" id="btmPreview"><span class="ui-icon ui-icon-transfer-e-w"></span><%= Resources.Messages.lbl_preview %></a>
                    <a href="#" id="btmConfirm"><span class="ui-icon ui-icon-check"></span><%= Resources.Messages.lbl_start_import%></a>
                </td>
            </tr>
            <tr>
                <td colspan="2"><div id="result_import"></div></td>
            </tr>
        </table>

    </div>
</div>

<script type="text/javascript">

    $('input[type="checkbox"][name="optSendEmail"]').change(function() {
          $("input:text[name=optEmail]").prop('disabled', !this.checked);
     });

    $('#btmConfirm').button();
    $('#btmConfirm').click(function () {

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"ImportData",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        var emailToSend='';
        if($('input[type="checkbox"][name="optSendEmail"]').prop('checked'))
            emailToSend=$('input[type="text"][name="optEmail"]').val();
        var data={
            'typeImport':'override',
            'emailToReport':emailToSend
        }

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                
                $('#result_import').empty();
                if(jsonResult.hasOwnProperty("error")){
                    _layoutManager.ReportError('#final_notifier','<%= Resources.Notification.err_import_data %>',false);
                }else{
                var strings={
                    lbl_user:"<%= Resources.Messages.lbl_report_user %>",
                    lbl_insert_type:"<%= Resources.Messages.lbl_report_mode %>",
                    lbl_record_count:"<%= Resources.Messages.lbl_report_count %>",
                    lbl_errors_occurred:"<%= Resources.Messages.lbl_report_error %>",
                    lbl_emailto:"<%= Resources.Messages.lbl_report_email %>",
                    lbl_end:"<%= Resources.Messages.lbl_report_finish %>",
                    lbl_continue:"<%= Resources.Messages.lbl_report_continue %>",
                }
                    _layoutManager.ShowReportQuery(strings,jsonResult); 
                }
            },
            function(msg){
                _layoutManager.ReportError('#final_notifier','<%= Resources.Notification.err_import_data %>',false);
            },
            function(msg){
                _layoutManager.InitControl_final();
                _layoutManager.EnableLoadingDialog();
            },
            function(time){
                _layoutManager.ReportSuccess('#final_notifier','Data Load in '+GetTimeFormat(time),true);
                _layoutManager.DisableLoadingDialog();
            },
            true);

    });

    $('#btmPreview').button();
    $('#btmPreview').click(function () {

        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetPreview",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                if (jsonResult == "" ) {
                    _layoutManager.ReportError('#final_notifier','<%= Resources.Notification.err_preview_data %>',false);

                }else{
                    $('#result_import').empty();
                    _layoutManager.ShowListPreview('#result_import',jsonResult);
            }
            },
            function(msg){
                    _layoutManager.ReportError('#final_notifier','<%= Resources.Notification.err_preview_data %>',false);
            },
            function(msg){
                _layoutManager.InitControl_final();
                _layoutManager.EnableLoadingDialog();

            },
            function(msg){
                    
                _layoutManager.DisableLoadingDialog();
            },
            true);

    });

    function GetTimeFormat(millisecond){
        
        var _ret=millisecond/1000;

        if(_ret>60){
            _ret=_ret/60;
            if(_ret>60){
                _ret=_ret/60;
                return _ret.toFixed(2)+' h ';
            }else{
                return _ret.toFixed(2)+' m ';
            }
        }else{ 
            return _ret.toFixed(2)+' s ';
        }

    }

</script>