<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TranscodingTimeControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.TranscodingTimeControl" %>

<div class="container">
    <div id="transcoding_notifier" class="notifier"></div>

    <div id="transcoding_time" class="innerContent">
        <table>
            <tr>
                <td colspan="3"><p class="descriptionInput"><input type="checkbox" name="transcodeTime" checked="checked" value="on" onclick="$('.transcodeTimeContainer').toggle();" />E' necessaria una transcodifica per la colonna TIME_PERIOD</p></td>
            </tr>
            <tr class="transcodeTimeContainer">
                <td class="fivety">
                    <p class="descriptionInput"><span><%= Resources.Messages.lbl_format_sample%></span></p>
                </td>
                <td class="twentyfive">
                    <p class="descriptionInput"><span><%= Resources.Messages.lbl_char_change%></span></p>
                </td>
                <td class="twentyfive">
                    <p class="descriptionInput"><span><%= Resources.Messages.lbl_time_period%></span></p>
                </td>
            </tr>
            <tr class="transcodeTimeContainer">
                <td>
                    <input type="text" maxlength="20" name="espCurr" value="1990-10"  readonly="readonly" />
                </td>
                <td>
                    <input type="text" maxlength="1" name="charPeriod" id="CharSeparator" class="char" />
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
            <tr>
                <td colspan="2"></td>
                <td><a id="transAccept" href="#"><span class="ui-icon ui-icon-check"></span><%= Resources.Messages.lbl_confirm%></a></td>
            </tr>
        </table>
    </div>

    <script type="text/javascript">

    function loadTranscodeTime(){

        
        
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"GetTranscodeTime",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            null,
            function(jsonResult){
                if(jsonResult.hasOwnProperty('error'))
                    _layoutManager.ReportError('#transcoding_notifier',jsonResult.error,false);
                else if(jsonResult.hasOwnProperty('stopChar') && jsonResult.hasOwnProperty('targetChar'))  {
                    $('input[name=transcodeTime]').prop('checked', true);
                    $('input[name=espCurr]').val("1990-10");
                    $(':radio[value="'+jsonResult.targetChar+'"]').prop('checked', true);
                    $('input[name=charPeriod]').val(jsonResult.stopChar);
                    $('.transcodeTimeContainer').show();
                }else{
                    $('input[name=transcodeTime]').prop('checked', false); 
                    $('input[name=charPeriod]').val('');   
                    $('.transcodeTimeContainer').hide();
                }
            },
            function(msg){
                _layoutManager.ReportError('#transcoding_notifier','Error in transcoding',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

    }

    $('#transAccept').button();
    $('#transAccept').click(function(){
        
        var _useTrans=$('input[name=transcodeTime]').prop('checked');
        var _period=(_useTrans)?$('input[name=periodIndex]:checked').val():0;
        var _espCurr=(_useTrans)?$('input[name=espCurr]').val():"1990-10";
        var _charPeriod=(_useTrans)?$('input[name=charPeriod]').val():'-';

        var data = {
            useTranscode:_useTrans,
            period: _period,
            espCurr: _espCurr,
            charPeriod: _charPeriod
        }
        
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"SetTranscodeTime",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                if(jsonResult.hasOwnProperty('error'))
                    _layoutManager.ReportError('#transcoding_notifier',jsonResult.error,false);
                    
                if(jsonResult.hasOwnProperty('result'))
                    _layoutManager.ReportSuccess('#transcoding_notifier',jsonResult.result,false);
            },
            function(msg){
                _layoutManager.ReportError('#transcoding_notifier','Error in transcoding',false);
            },
            function(msg){
                _layoutManager.EnableLoadingDialog();
            },
            function(msg){
                _layoutManager.DisableLoadingDialog();
            },
            true);

        });

    </script>

</div>