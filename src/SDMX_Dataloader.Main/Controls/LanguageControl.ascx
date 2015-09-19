<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageControl.ascx.cs" Inherits="SDMX_Dataloader.Main.Controls.LanguageControl" %>


<!-- Menu delle lingue -->
<div class="lang-menu">
    <select>
        <% foreach (System.Globalization.CultureInfo locale in this.AvailableLocale)
            {%>
            <option value="<%= locale.Name%>" <%= (CurrentLocale.Equals(locale)?"selected='selected'":"") %>>
                <%= locale.DisplayName.ToUpper()%></option>
        <% } %>
    </select>
</div>

<script type="text/javascript">

    $(".lang-menu select").selectmenu({
        change: function (event, data) {
            setCulture(data.item.value);
        }
    });
    
    function setCulture(culturename) {

        var arg = { locale: culturename };
        $.ajax({
            type: "POST",
            url: "<%= WSStatic %>/SetLocale",
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify(arg),
            success: function (data) {
                location.reload();
            },
            error: function (xhr, status, error) {

            }
        });
    }
    
</script>