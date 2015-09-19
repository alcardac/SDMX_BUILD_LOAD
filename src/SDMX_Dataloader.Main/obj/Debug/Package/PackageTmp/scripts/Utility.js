function ResolveUrl(url) {
    if (url.indexOf("~/") == 0) {
        url = baseUrl + url.substring(2);
    }
    return url;
}

/* 
Main Ajax request class
*/
var AjaxRequestManager = function (config,labels) {

    var time=null;

    var ajaxRequest = {
        config: {
            baseUrl: window.location.protocol + "//" + window.location.host,
            method: "",
            locale: "en",
            contentType: "application/json; charset=utf-8",
            processData: false,
            dataType: "json",
            cache: false,
            dataConvert:true,
            dataFilter:true
        },
        events: {
            ajaxStart: AjaxClientStart,
            ajaxEnd: AjaxClientEnd,
            ajaxSucces: AjaxClientSucces,
            ajaxError: AjaxClientError,
        },
        debug:false
    }

    $.extend(ajaxRequest.config, config);

    this.SendRequest = function (data, callBack, callBackError, callBackPreLoad, callBackPreEnd) {
        
        ajaxRequest.events.ajaxStart(callBackPreLoad);

        if(ajaxRequest.config.dataConvert)
            if(data!=null)
                data=JSON.stringify(data);

        var filter=null;
        if(ajaxRequest.config.dataFilter)
            filter=function (data) {
                if(data!=""){
                    var jsonResult = eval('(' + data + ')');
                    if (jsonResult.hasOwnProperty('d'))
                        return jsonResult.d;
                    else
                        return jsonResult; 
                }
            };

        $.ajax({
            type: "POST",
            url: ajaxRequest.config.baseUrl+"/"+ajaxRequest.config.method,
            cache:  ajaxRequest.config.cache,
            contentType: ajaxRequest.config.contentType,
            dataType:  ajaxRequest.config.dataType,
            data: data,

            dataFilter: filter,

            success: function (jsonResult) {

                if(jsonResult== null){

                    ajaxRequest.events.ajaxError("ERRORS", callBackError);
                    ajaxRequest.events.ajaxEnd(callBackPreEnd);

                } else {
                
                    if (jsonResult.hasOwnProperty('ERRORS')) {

                        if (ajaxRequest.debug)
                            console.log(jsonResult.error);

                        ajaxRequest.events.ajaxError(jsonResult.error, callBackError);
                        ajaxRequest.events.ajaxEnd(callBackPreEnd);

                    } else if (jsonResult.hasOwnProperty('SESSIONEXPIRED')) {

                        if (ajaxRequest.debug)
                            console.log("Session Expired");

                        // Session Expiried
                        var popupSessionExp=document.createElement('div');

    
                        $(popupSessionExp).append('<p>The session has expired.</p>');
                        $(popupSessionExp).append('<p>Please login again to the site.</p>');

                        $(popupSessionExp).dialog({
                        title: "Session Abandon",
                        dialogClass: "no-close",
                        position: { my: "center", at: "center", of: window },
                        resizable: false,
                        width:240,
                        height:180,
                        modal: true,
                        autoOpen: true,
                        draggable: false,
                        closeOnEscape: false,
                        buttons: {
                            "OK": function() {
                            
                                $( this ).dialog( "close" );
                                location.reload();
                            }
                        }
                        });


                    }else {

                        if (ajaxRequest.debug)
                            console.log(jsonResult);
                        
                        ajaxRequest.events.ajaxSucces(jsonResult, callBack);
                        ajaxRequest.events.ajaxEnd(callBackPreEnd);
                    }
                }
            },
            error: function (xhr, status, error) {

                if (ajaxRequest.debug) console.log(error);

                ajaxRequest.events.ajaxError(error, callBackError);
                ajaxRequest.events.ajaxEnd(callBackPreEnd);
            }
        });

    }

    function AjaxClientStart(callBack) {

        var d = new Date();
        time= d.getTime();

        callBack();
    }
    function AjaxClientEnd(callBack) {
    
        var d = new Date();
        time= d.getTime()-time;
        
        callBack(time);
        
    }
    function AjaxClientSucces(data, callBack) {
        callBack(data);
    }
    function AjaxClientError(msg, callBackError) {
        callBackError(msg);
    }

}
