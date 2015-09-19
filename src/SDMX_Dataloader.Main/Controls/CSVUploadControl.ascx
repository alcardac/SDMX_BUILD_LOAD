<%@ Control Language="C#" 
AutoEventWireup="true" 
CodeBehind="CSVUploadControl.ascx.cs"
Inherits="SDMX_Dataloader.Main.Controls.CSVUploadControl" 
%>

    <table>
        <tr>
            <td colspan="4"><p class="contentLabel"><%= Resources.Messages.lbl_uploadCSVChoise %></p></td>
        </tr>
        <tr>
            <td colspan="4"><input id="FileUploadCSV" class="fileInput" type="file" name="FileUploadCSV" /></td>
        </tr>
        <tr></tr>
        <tr>
            <td colspan="2"><p class="descriptionInput"><input id="CharSeparator" class="char" type="text" name="txtSeparator" maxlength="1" value=";" /><%= Resources.Messages.lbl_uploadCSVSeparator %></p></td>
            <td colspan="2"><p class="descriptionInput"><input id="chkFirstRowJump" type="checkbox" value="on" name="chkFirstRowJump" /><%= Resources.Messages.lbl_first_row_column%></p></td>
        </tr>
        <tr>
            <td colspan="4">
                <ul class="fileInfo">
                    <li><p><%= Resources.Messages.lbl_filename %> <span id="lbl_filename"></span></p></li>
                    <li><p><%= Resources.Messages.lbl_filesize %> <span id="lbl_filesize"></span></p></li>
                    <li><p><%= Resources.Messages.lbl_content %> <span id="lbl_content"></span></p></li>
                    <li><p><%= Resources.Messages.lbl_headers %> <span id="lbl_headers"></span></p></li>
                    <li><p><%= Resources.Messages.lbl_countRows %> <span id="lbl_count"></span></p></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td colspan="3"></td>
            <td><a id="btmUploadAjax"><span class="ui-icon ui-icon-arrowthickstop-1-n"></span><%= Resources.Messages.lbl_upload%></a></td>
        </tr>
    </table>

<script type="text/javascript">

    $(document).ready(function () {

        $('.fileInfo').hide();

        // Setup
        $('#btmUploadAjax').button();
    });

    $('#btmUploadAjax').click(function () {

        _layoutManager.EnableLoadingDialog();

        var data = new FormData();
        var file = $('#FileUploadCSV')[0].files[0];
        if (file) {
            data.append('UploadedCSV', file);
            data.append('CharSeparator', $('#CharSeparator').val());


            data.append('chkFirstRowJump', $('#chkFirstRowJump').prop('checked'));

        }
        $.ajax({
            type: "POST",
            url: "<%= WSBuilder %>/UploadFile",
            cache: false,
            contentType: false,
            processData: false,
            dataType: "json",
            data: data,
            success: function (jsonResult) {
                if (jsonResult.hasOwnProperty('error')) {
                    _layoutManager.InitControl_file();
                    _layoutManager.DisableLoadingDialog();
                } else {

                    $('#file_notifier').empty();
                    $('#lbl_filename').text(jsonResult.filename);

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
                    $('#lbl_filesize').text(kilobitsize.toFixed(2) + sizeUnit);

                    $('#lbl_headers').text(jsonResult.headers.length);
                    $('#lbl_count').text(jsonResult.countRows);
                    $('#lbl_content').text(jsonResult.content);
                    $('.fileInfo').show();
                    _layoutManager.DisableLoadingDialog();

                }
            },
            error: function () {

                _layoutManager.DisableLoadingDialog();
            }
        });

        return false;
    });

</script>