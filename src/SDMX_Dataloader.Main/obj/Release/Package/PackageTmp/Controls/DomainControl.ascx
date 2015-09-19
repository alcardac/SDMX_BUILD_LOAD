<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DomainControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.ThemeControl" %>

<div id="profile_notifier" class="notifier"></div>

<div class="ui-widget ui-widget-content ui-corner-all ui-panel-control innerContent">

    <div id="jstree_domains"></div>

    <a href="#" id="btm_domain_set"><span class="ui-icon ui-icon-circle-minus"></span>Sett</a>

</div>
            
<link rel="stylesheet" href="jquery/jquery-jstree/themes/default/style.min.css" />
<script type="text/javascript" src="jquery/jquery-jstree/jstree.min.js"></script>
<script type="text/javascript">


    var jstree_theme = $('#jstree_domains').jstree({
        'core': {
            'data': {
                'url': '<%= WSBuilder %>/GetDomains',
                'data': function (node) {
                    return { 'idUser': '<%= this.UserSelected.ID  %>' };
                }
            }
        },
        'checkbox': {
            'keep_selected_style': false
        },
        'plugins': ["wholerow", "checkbox"]
    });

    $('#btm_domain_set').button();
    $('#btm_domain_set').click(function () {

        var checked_obj = jstree_theme.get_checked(false);

        var data={
            'idUser': '<%= this.UserSelected.ID  %>',
            'idDomains': checked_obj
        };
        var _ajaxRequestMan=new AjaxRequestManager({
            baseUrl:"<%= WSBuilder %>",
            method:"SetDomains",
            locale:"<%= ISTAT.ENTITY.TextTypeWrapper.DefaultTwoLetterISO %>"
        },{
            titleLoading: "<%= Resources.Messages.lbl_loading_wait%>",
            messageLoading: "<%= Resources.Messages.msg_loading_wait%>",
        });

        _ajaxRequestMan.SendRequest(
            data,
            function(jsonResult){
                jstree_theme.redraw(true);
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

        return false;
    });
    

</script>