<%@ Control Language="C#"
AutoEventWireup="true" 
CodeBehind="MultipleFileUploadControl.ascx.cs" 
Inherits="SDMX_Dataloader.Main.Controls.MultipleFileUploadControl" %>

<div class="multi-file-upload">
     
    <p class="contentLabel">
        <a href="#" id="btm_<%= this.IDDivFile %>"><span class="ui-icon ui-icon-arrowthickstop-1-n"></span><%= Resources.Messages.lbl_upload%></a>
        <a href="#" id="<%= this.IDDivFile %>"><span class="ui-icon ui-icon-circle-plus"></span><%= Resources.Messages.lbl_add_file%></a>
    </p>
</div>


<script type="text/javascript">

    var resultItems=[];

    var uploadObj_<%= this.IDDivFile %> = $("#<%= this.IDDivFile %>").uploadFile({
        url: "<%= this.ServerDomain %><%= this.ServerPage %>",
        returnType: "json",
        multiple: true,
        autoSubmit: false,
        allowedTypes: "xml",
        maxFileSize: (1024 * 1024 * 1024) * 2, // max 2gb
        maxFileCount: 1,
        fileName: "<%= this.NameParam %>",
        dragDrop: false,
        dragDropBorder: '2px dotted #656565',
        dragDropBorderHover: '2px dotted #d3d3d3',
        showFileCounter: false,
        showCancel: true,
        showAbort: false,
        showDelete: false,
        showDone: false,
        showProgress: true,
        showError: false,
        showStatusAfterSuccess: false,
        dragDropStr: '',
        deletelStr: '<p class="ui-button ui-widget ui-state-default ui-corner-all"><span class="ui-icon ui-icon-trash"></span>Delete</p>',
        cancelStr: '<p class="ui-button ui-widget ui-state-default ui-corner-all"><span class="ui-icon ui-icon-circle-minus"></span>Cancel</p>',
        multiDragErrorStr: "multi Drag Error",
        extErrorStr: "ext Error",
        sizeErrorStr: "Size Error",
        uploadErrorStr: "Upload Error",
        uploadButtonClass: "ui-button ui-widget ui-state-default ui-corner-all",
        statusbarButtonClass: "ui-widget  ui-widget-content ui-corner-all",
        afterUploadAll: function () {
            _layoutManager.DisableLoadingDialog();

            <% if(this.ReportOnUpload) { %>
                if(resultItems.length >0){
                    var divReportPanel = document.createElement('div');
                    $(divReportPanel).addClass('report-container');

                    $("<ul/>", {
                        "class": "report-list",
                        html: resultItems.join("")
                    }).appendTo($(divReportPanel));

                    $(divReportPanel).dialog({
                        title: "Report",
                        position: { my: "center", at: "center", of: window },
                        dialogClass: "no-close",
                        autoOpen: true,
                        draggable: false,
                        modal: true,
                        width: 500,
                        height:500 ,
                        closeOnEscape: true,
                        buttons: {
                            "Ok": function() {
                                $( this ).dialog( "close" );
                                $(this).remove();
                            }

                        }
                    });
                }
            <% } %>

        },
        onSubmit: function (files, data, xhr){
            _layoutManager.EnableLoadingDialog();
            resultItems=[];
        },
        onSuccess: function (files, data, xhr) {

            _layoutManager.DisableLoadingDialog();
            <% if(this.ReportOnUpload) { %>

                if(data.hasOwnProperty("ERRORS"))
                {
                        var divErrors = document.createElement('div');
                        $(divErrors).addClass('widget ui-widget-content ui-corner-bottom');

                        $(divErrors).append(data.ERRORS);

                        $(divErrors).dialog({
                            title: "ImportError",
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
                else
                    $.each(data, function (i, item) {
                        resultItems.push("<li><p><span>"+item.StructureReference+"</span><br/>"+item.Message+"</p></li>");
                });      
            <% } %>
        },
        onError: function (files, status, errMsg) {
            _layoutManager.DisableLoadingDialog();
        }
    });

    $('#btm_<%= this.IDDivFile %>').button();
    $('#btm_<%= this.IDDivFile %>').click(function () {

        if(uploadObj_<%= this.IDDivFile %>.fileCounter>0) 
            uploadObj_<%= this.IDDivFile %>.startUpload();

    });


</script>