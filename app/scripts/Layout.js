var LayoutManager = function (config,labels) { 

    var setting = {
        config: {
        },
        labels: {
            titleLoading:"Please wait...",
            messageLoading:"This may take a few minutes.",
        },
        debug: false
    }
    
    $.extend(setting.config, config);
    $.extend(setting.labels, labels);

    var loadingPanel;

    var select_ds;
    var select_dsd;
    var select_mapping;

    this.ReportSuccess=function (control, msg,append) {
        if(!append) $(control).empty();
        $(control).append('<div class="ui-state-highlight ui-corner-all"><p><span class="ui-icon ui-icon-info"></span>' + msg + '</p></div>');
    }
    this.ReportError = function (control, msg,append) {
        if(!append) $(control).empty();
        $(control).append('<div class="ui-state-error ui-corner-all"><p><span class="ui-icon ui-icon-info"></span>' + msg + '</p></div>');
    }

    this.ConceptSchemeControl = function (cssIdContainer, data,strings,AttachmentLevelDimension, MaxDimm, disasable,limit) {
        var labels={
                cs_lbl_title:"",
                cs_msg_dim_cur:"",
                cs_msg_dim_max:"",
                }

        $.extend(labels, strings);


        var items = [];
        var items_detail = [];
        var enabledString = "";
        var dimmSelect = 0;

        var cssClassDettailItems = 'dettailItem';
        var cssClassContainer = "comp_container";
        var cssClassDettail = "comp_dettail";

        var cssIdDettail = cssIdContainer.substring(1, cssIdContainer.length) + "_comp_dettail";

        if (MaxDimm>0)
            if (data.DIMENSION.length < MaxDimm) { enabledString = "disabled='disabled' checked='checked'"; }
        if (disasable) { enabledString = "disabled='disabled' checked='checked'"; }

        $(cssIdContainer + ' .ds_viewer').empty();
        $(cssIdContainer + ' .ds_input').hide();

        if (data.DIMENSION != null)
            $.each(data.DIMENSION, function (i, item) {
                dimmSelect++;
                var imgSrc = "dimension.png";
                if (item.TimeDimension == true) {
                    imgSrc = "time_" + imgSrc;
                } else if (item.MeasureDimension == true) {
                    imgSrc = "measure_" + imgSrc;
                } else if (item.FrequencyDimension == true) {
                    imgSrc = "freq_" + imgSrc;
                }
                
                var itemName = "";
                var itemID = "";
                if(item.hasOwnProperty("Names")){
                    if (item.Names != undefined)
                        if (item.Names.length>0)
                            itemName = item.Names[0].Value;
                }else{
                    itemName=item;
                }
                if(item.hasOwnProperty("Id")){
                    itemID=item.Id;
                }else{
                    itemID=itemName;
                }

                items.push("<li>" +
                "<p>" +
                "<img src='./img/" + imgSrc + "' alt='dimension'>" +
                "<input type='checkbox' title='" + itemName + "' name='" + itemID + "' id='" + itemID + "' class='chk_dimAvaible dimmChk' onClick='OnDimmCheck(" + '"' + itemID + '"' + "," + MaxDimm + ");' " + enabledString + " />" + itemID      +
                "<span onClick='GetCodelist(" + '"' + itemID + '"' + ",true)' class='ui-icon ui-icon-folder-open'></span>" + "</p>"+
                "</li>");
            });

        if (data.ATTRIBUTE != null)
            $.each(data.ATTRIBUTE, function (i, item) {
                var imgSrc = "attribute.png";
                if (item.Mandatory == true) {
                    enabledString = "disabled='disabled' checked='checked'";
                    imgSrc = "mandatory_" + imgSrc;
                } else {
                    enabledString = "";
                }

                if (disasable) enabledString = "disabled='disabled' checked='checked'";


                var itemName = "";
                var itemID = "";
                if(item.hasOwnProperty("Names")){
                    if (item.Names != undefined)
                        if (item.Names.length>0)
                            itemName = item.Names[0].Value;
                }else{
                    itemName=item;
                }
                if(item.hasOwnProperty("Id")){
                    itemID=item.Id;
                }else{
                    itemID=itemName;
                }

                var htmlItem = "<li>" +
                "<p>" +
                "<img src='./img/" + imgSrc + "' alt='attribute'>" +
                "<input type='checkbox' title='"+itemName+"' name='" + itemID + "' id='" + itemID + "' " + enabledString + " class='chk_attAvaible' />" +itemID ;
                htmlItem += "<span onClick='GetConceptSchemaDettail(" + '"' + cssIdContainer + '","' + itemID + '"' + ")' class='ui-icon ui-icon-info'></span>";

                if (item.IsCodelist) {
                    htmlItem += "<span onClick='GetCodelist(" + '"' + itemID + '"' + ",false)' class='ui-icon ui-icon-folder-open'></span>";
                }
                htmlItem += "</p></li>";
                items.push(htmlItem);

                // Dettail panel
                var htmlItemDettail = "<li class='" + cssClassDettailItems + "' id='dettail_" + itemID + "'>";

                var mandatory = "";
                if (item.Mandatory) mandatory = "(mandatory)";
                htmlItemDettail += "<p><span>ID: </span>" + itemID + " " + mandatory + "</p>";
                htmlItemDettail += "<p><span>Attachment Level: </span>" + item.AttachmentLevel + "</p>";

                var dimReference = "";
                if (item.AttachmentLevel == AttachmentLevelDimension)
                    if (item.DimensionReferences != undefined) {
                        var separatore = "";
                        $.each(item.DimensionReferences, function (i, item) {
                            dimReference += separatore + item;
                            separatore = ", ";
                        });
                    }
                if (dimReference != "")
                    htmlItemDettail += "<p>" + dimReference + "</p>";

                htmlItemDettail += "</li>";
                items_detail.push(htmlItemDettail);


            });

        var divContainer = document.createElement('div');
        $(divContainer).addClass('widget ui-widget-content ui-corner-bottom');
        $(divContainer).addClass(cssClassContainer);

        var divDettail = document.createElement('div');
        $(divDettail).addClass('widget ui-widget-content ui-corner-bottom');
        $(divDettail).attr('ID', cssIdDettail);
        $(divDettail).addClass(cssClassDettail);
        
        // append to list container
        $("<ul/>", {
            "class": "comp-list",
            html: items.join("")
        }).appendTo(divContainer);
        if(limit){
            $(divContainer).append('<p>' + labels.cs_msg_dim_cur + ' <span  id="comp_count">' + dimmSelect + '</span></p>');
            $(divContainer).append('<p><span class="ui-icon ui-icon-info"></span>' + labels.cs_msg_dim_max + ' ' + MaxDimm + '</p>');
        }
        // append to hidden list of dettail
        //$(divDettail).append("<h3 class='ui-widget-header'><%= Resources.Messages.lbl_concept_dettail%></h3>");
        $("<ul/>", {
            "class": "comp-list-dettail",
            html: items_detail.join("")
        }).appendTo(divDettail);
        $(cssIdContainer + ' .ds_viewer').append(divContainer);
        $(cssIdContainer + ' .ds_viewer').append(divDettail);

        $(cssIdContainer + ' .ds_input').hide();
        $('#ds_select .ds_viewer').show();

    }

    this.ShowListMapping=function(idDiv,list,callBack){
        
        $(idDiv).empty();

        if(list!=null){
            var listIndex=0;
            var items=[];
            $.each(list, function (i, item) {
                listIndex++;
                items.push("<li>" +
                "<p class='item-mapping-list'"+
                " title='"+item+"'"+
                " data-index='"+listIndex+"' "+
                " data-item='Cln: " +listIndex+ " : "+item+"'>"+
                "Cln: " +listIndex+ " : "+item+"</p>" +
                "</li>");
            });

            $("<ul/>", {
                "class": "mapping-list",
                html: items.join("")
            }).appendTo(idDiv);
            
            $(idDiv+" .mapping-list").selectable({
                selected: function (event, ui) {
                    $(ui.selected).siblings().removeClass("ui-selected");
                },
                stop: function() {
                    $( ".ui-selected", this ).each(function() {
                        var index = $(idDiv+" ul li").index( this );
                        callBack(( index + 1 ));
                    });
                }
            });

            $('.item-mapping-list').tooltip({
                items: "p",
                content: function() {
                    var element = $( this );
                    if ( element.is( "[title]" ) ) {
                        return "<p><span class='ui-icon ui-icon-lightbulb'></span>"+element.attr( "title" )+"</p>";
                    }
                }
            });

        }
    }
    this.ShowListMappingSdmx=function(idDiv,listDim,listAtt,callBack){
    
        var listIndex=0;
        var items=[];

         $(idDiv).empty();

        if (listDim != null)
            $.each(listDim, function (i, item) {
                listIndex++;
                var imgSrc = "dimension.png";
                if (item.TimeDimension == true) {
                    imgSrc = "time_" + imgSrc;
                } else if (item.MeasureDimension == true) {
                    imgSrc = "measure_" + imgSrc;
                } else if (item.FrequencyDimension == true) {
                    imgSrc = "freq_" + imgSrc;
                }

                items.push("<li>" +
                "<p class='item-mapping-list'"+
                " title='"+item.Names[0].Value+"'"+
                " data-index='"+listIndex+"' "+
                " data-item='"+item.Id+"'>"+
                "<img src='./img/" +imgSrc+"' alt='"+imgSrc+"'/>" +item.Id+ "</p>" +
                "</li>");

            });
        if (listAtt != null)
            $.each(listAtt, function (i, item) {
                listIndex++;
                var imgSrc = "attribute.png";
                if (item.Mandatory == true) {
                    imgSrc = "mandatory_" + imgSrc;
                }

                items.push("<li>" +
                "<p class='item-mapping-list'"+
                " title='"+item.Names[0].Value+"'"+
                " data-mandatory='"+item.Mandatory+"' "+
                " data-index='"+listIndex+"' "+
                " data-item='"+item.Id+"'>"+
                "<img src='./img/" +imgSrc+"' alt='"+imgSrc+"'/>" +item.Id+ "</p>" +
                "</li>");

            });

        items.push("<li>" +
                "<p class='item-mapping-list'"+
                " title='OBS_VALUE'"+
                " data-index='"+(listIndex+1)+"' "+
                " data-item='OBS_VALUE'>"+
                "<img src='./img/dimension.png' alt='OBS_VALUE'/>OBS_VALUE</p>" +
                "</li>");

        $("<ul/>", {
            "class": "mapping-list",
            html: items.join("")
        }).appendTo(idDiv);
        
        $(idDiv).data('itemCount',listIndex+1);

        $(idDiv+" .mapping-list").selectable({
            selected: function (event, ui) {
                $(ui.selected).siblings().removeClass("ui-selected");
            },
                stop: function() {
                    $( ".ui-selected", this ).each(function() {
                        var index = $(idDiv+" ul li").index( this );
                        callBack(( index + 1 ));
                    });
                }
        });

    }
    this.ShowMappingViewer= function(idDiv,list_custom){
    
        if(list_custom!=undefined){    
            var viewer=document.createElement('div');
            $(viewer).addClass("mapping-list");

            var items = [];
            $.each(list_custom, function (key,value){
                items.push("<li><p>"+
                    "<span>Cln: "+value._a+"</span><span class='ui-icon ui-icon-transferthick-e-w'></span><span>"+value._b+"</span>"+
                    "</p></li>");
            });
            $("<ul/>", {
                "class": "list",
                html: items.join("")
            }).appendTo(viewer);

            $(idDiv).empty();
            $(idDiv).append(viewer);
        }
    }
    this.GetMappingViewer= function(list_custom){
    
        if(list_custom!=undefined){    
            var viewer=document.createElement('div');
            $(viewer).addClass("mapping-list");

            var items = [];
            $.each(list_custom, function (key,value){
                items.push("<li><p>"+
                    "<span>"+value._c+"</span><span class='ui-icon ui-icon-transferthick-e-w'></span><span>"+value._b+"</span>"+
                    "</p></li>");
            });
            $("<ul/>", {
                "class": "list",
                html: items.join("")
            }).appendTo(viewer);

            return viewer;
        }
    }
    
    this.ShowCodelistPopUp = function (codelsit,list) {
        if (list != null) {

            var divCodelist = document.createElement('div');
            $(divCodelist).addClass('widget ui-widget-content ui-corner-bottom');

            $("<p/>", {
                "class": "code-list-name",
                html: "<span class='fieldLabel'>"+codelsit+ "</span>"
            }).appendTo(divCodelist);
                            
            var items = [];
            $.each(list, function (i, item) {
                var itemName = "";
                if (item.Names != undefined)
                    if (item.Names.length > 0)
                        itemName = item.Names[0].Value;
                     
                items.push("<li>" +
                    "<p>" +
                    "<span class='fieldLabel'>" + item.Id + "</span>" +
                        itemName +
                    "</p>" +
                    "</li>");
            });

            $("<ul/>", {
                "class": "code-list",
                html: items.join("")
            }).appendTo(divCodelist);

            $(divCodelist).dialog({
                title: "Codelist",
                position: { my: "center", at: "center", of: window },
                //dialogClass: "no-close",
                autoOpen: false,
                draggable: false,
                modal: true,
                width: 320,
                height: 500,
                closeOnEscape: true
            });
            $(divCodelist).dialog("open");
        }
    }

    this.ShowCubeDetailsPopUp = function (cubeDetails) {
        if (cubeDetails == null) 
            return;

        var divCubeDetails = document.createElement('div');
        $(divCubeDetails).addClass('widget ui-widget-content ui-corner-bottom');

        var lblRecord;

        if(cubeDetails._CUBE_RECORD_COUNT_ > CubeMaxRowCount)
            lblRecord = lbl_record_count + CubeMaxRowCount +" "+ lbl_of +" "+ cubeDetails._CUBE_RECORD_COUNT_;
        else
            lblRecord = lbl_record_count + cubeDetails._CUBE_RECORD_COUNT_;

        $("<p/>", {
            "class": "code-list-name",
            html: "<span class='fieldLabel'>"+lbl_ds_code +": "+ cubeDetails._CUBE_NAME_ + "</span>" +
            "<span class='fieldLabel' style='float:right'>"+ lblRecord + "</span>"
        }).appendTo(divCubeDetails);

        var table=document.createElement('table');
        $(table).addClass('datatable');

        var rowData=document.createElement('tr');
        
        $.each(cubeDetails, function (columnName, item) {

        if(columnName != "_CUBE_NAME_" && columnName != "_CUBE_RECORD_COUNT_")
            {
                var td=document.createElement('td');

                items=[];
                items.push("<li class='fieldLabel'>"+ columnName +"</li>");
                $.each(item, function (j,value){
                    items.push("<li>"+value+"</li>");
                });

                $("<ul/>", {
                    "class": "list",
                    html: items.join("")
                }).appendTo(td);
                $(rowData).append(td);
            }
        });

        $(table).append(rowData);
        $(divCubeDetails).append(table);

        $(divCubeDetails).dialog({
            title: "CubeDetails",
            position: { my: "center", at: "center", of: window },
            //dialogClass: "no-close",
            autoOpen: false,
            draggable: false,
            modal: true,
            width: 820,
            height: 500,
            closeOnEscape: true
        });
        $(divCubeDetails).dialog("open");
        
    }


    this.ShowConceptSchematPopUp = function (cssIdContainer, dimmId) {
        $('.dettailItem').hide();
        var cssIdDettail = '#' + cssIdContainer.substring(1, cssIdContainer.length) + "_comp_dettail";
        
        $(cssIdDettail).dialog({
            position: { my: "center", at: "center", of: window },
            autoOpen: false,
            draggable: true,
            closeOnEscape: false
        });
        $(cssIdDettail).dialog("open");

        var idDettail = '#dettail_' + dimmId;
        //alert(idDettail);
        $(idDettail).show();
    }

    this.EnableLoadingDialog = function () {
        
        var divLoadingPanel = document.createElement('div');
        $(divLoadingPanel).addClass('widget ui-widget-content ui-corner-bottom');
        $(divLoadingPanel).attr('ID', 'loadingDialog');
        $(divLoadingPanel).attr('Title', setting.labels.titleLoading);
        var items = [];

        items.push("<p>" + setting.labels.messageLoading + "</p>");
        items.push('<img src="./img/AjaxLoading.gif" alt="Loading..."/>');

        $(divLoadingPanel).append(items);

        $(divLoadingPanel).dialog({
            title: setting.labels.titleLoading,
            position: { my: "center", at: "center", of: window },
            dialogClass: "no-close",
            autoOpen: true,
            draggable: false,
            modal: true,
            width: 320,
            //height: 160,
            closeOnEscape: false
        });
        $(divLoadingPanel).dialog("open");

        //alert("open loading");
    }
    this.DisableLoadingDialog= function(){
        //alert("on close loading");
        var isOpen = $('#loadingDialog').dialog( "isOpen" );
        //alert("isOpen "+isOpen);
        if(isOpen==true){
            $('#loadingDialog').dialog().dialog("destroy");
            //alert("close loading");
        }
    }

    this.GetPreview= function(list){
       
        var table=document.createElement('table');
        $(table).addClass('datatable');
        var rowData=document.createElement('tr');

        $.each(list, function (i, item) {

            var td=document.createElement('td');

            items=[];
            items.push("<li class='fieldLabel'>"+i+"</li>");
            $.each(item, function (j,value){
                items.push("<li>"+value+"</li>");
            });

            $("<ul/>", {
                "class": "list",
                html: items.join("")
            }).appendTo(td);
            $(rowData).append(td);

        });
        
        $(table).append(rowData);

        return table;
    }
    this.ShowListPreview= function(div,list){
       
        var table=document.createElement('table');
        $(table).addClass('datatable');
        var rowData=document.createElement('tr');


        $.each(list, function (i, item) {

            var td=document.createElement('td');

            items=[];
            items.push("<li class='fieldLabel'>"+i+"</li>");
            $.each(item, function (j,value){
                items.push("<li>"+value+"</li>");
            });

            $("<ul/>", {
                "class": "list",
                html: items.join("")
            }).appendTo(td);
            $(rowData).append(td);

        });
        $(div+' .datatable').remove();
        $(table).append(rowData);
        $(div).append(table);
    }
    this.GetReportQuery=function(strings,report){
        var labels={
            lbl_user:"Operation execute by:",
            lbl_insert_type:"Insert mode:",
            lbl_record_count:"Record count:", 
            lbl_time_execute:"Time execute:",
            lbl_file_source:"File Source:",
            lbl_record_i_count:"Record already exist count:",
            lbl_record_o_count:"Record update with ovverride count:",
            lbl_errors_occurred:"The following errors occurred during insertion:",
            lbl_emailto:"A email has been send to address:",
            lbl_end:"Finish",        
            lbl_scarted_file:"Scarted File:"
            }

        $.extend(labels, strings);

        var divReportPanel = document.createElement('div');

        var items=[];
        items.push("<p><span class='fieldLabel'>"+labels.lbl_user+"</span> "+report.username+ "</p>");
        items.push("<p><span class='fieldLabel'>"+labels.lbl_file_source+"</span> "+report.filesource+"</p>");
        //items.push("<p><span class='fieldLabel'>"+labels.lbl_insert_type+"</span> "+report.typeImport+ "</p>");
        
        if(report.recordCount != undefined)
        {
            items.push("<p><span class='fieldLabel'>"+labels.lbl_record_count+"</span> "+report.recordCount+' / '+report.recordTargetCount+ "</p>");
            //items.push("<p><span class='fieldLabel'>"+labels.lbl_record_i_count+"</span> "+report.recordIgnoreCount+' / '+report.recordTargetCount+ "</p>");
        }

        if(report.lbl_record_o_count != undefined && report.recordOverrideCount != undefined)
        {
            items.push("<p><span class='fieldLabel'>"+labels.lbl_record_o_count+"</span> "+report.recordOverrideCount+' / '+report.recordTargetCount+ "</p>");
        }
        items.push("<p><span class='fieldLabel'>"+labels.lbl_time_execute+"</span> "+report.timeExecute+ "</p>");
        
        if(report.emailToReport!="")
            items.push("<p>"+labels.lbl_emailto+" "+report.emailToReport+ "</p>");


        if(report.scartedFilePath!=undefined && report.scartedFilePath!="")
        {
            items.push("<p><span class='fieldLabel'>"+labels.lbl_scarted_file+"</span> <a href='http://"+ report.scartedFilePath + "'>download</a></p>");
        }
        

        $(divReportPanel).append(items);

        var hasError=false;

        if(report.hasOwnProperty('rowfail') && report.rowfail.length>0){

            hasError=true;

            var divErrorPanel = document.createElement('div');
            $(divErrorPanel).addClass('report-container');

            $(divErrorPanel).append("<p>"+labels.lbl_errors_occurred+"</p>");

            var errorItems = [];
            $.each(report.rowfail, function (i, item) {
                errorItems.push("<li><p>" + item + "</p></li>");
            });
            $("<ul/>", {
                "class": "report-list",
                html: errorItems.join("")
            }).appendTo($(divErrorPanel));
            
            $(divReportPanel).append(divErrorPanel);

           
        }
         
        return divReportPanel;
        
    }
    this.ShowReportQuery=function(strings,report){

        var labels={
            lbl_user:"Operation execute by:",
            lbl_insert_type:"Insert mode:",
            lbl_record_count:"Record count:",
            lbl_record_i_count:"Record already exist count:",
            lbl_record_o_count:"Record update with ovverride count:",
            lbl_time_execute:"Time execute:",
            lbl_errors_occurred:"The following errors occurred during insertion:",
            lbl_emailto:"A email has been send to address:",
            lbl_end:"Finish"        
        }

        $.extend(labels, strings);

        var divReportPanel = document.createElement('div');
        $(divReportPanel).addClass('widget ui-widget-content ui-corner-bottom');
        $(divReportPanel).attr('ID', 'reportDialog');
        $(divReportPanel).attr('Title', "Report");

        var items=[];
        items.push("<p><span class='fieldLabel'>"+labels.lbl_user+"</span> "+report.username+ "</p>");
        //items.push("<p><span class='fieldLabel'>"+labels.lbl_insert_type+"</span> "+report.typeImport+ "</p>");
        items.push("<p><span class='fieldLabel'>"+labels.lbl_record_count+"</span> "+report.recordCount+' / '+report.recordTargetCount+ "</p>");
        //items.push("<p><span class='fieldLabel'>"+labels.lbl_record_i_count+"</span> "+report.recordIgnoreCount+' / '+report.recordTargetCount+ "</p>");
        items.push("<p><span class='fieldLabel'>"+labels.lbl_record_o_count+"</span> "+report.recordOverrideCount+' / '+report.recordTargetCount+ "</p>");
        items.push("<p><span class='fieldLabel'>"+labels.lbl_time_execute+"</span> "+report.timeExecute+ "</p>");
        $(divReportPanel).append(items);

        var hasError=false;

        if(report.hasOwnProperty('rowfail') && report.rowfail.length>0){

            hasError=true;

            var divErrorPanel = document.createElement('div');
            $(divErrorPanel).addClass('report-container');

            $(divErrorPanel).append("<p>"+labels.lbl_errors_occurred+"</p>");

            var errorItems = [];
            $.each(report.rowfail, function (i, item) {
                errorItems.push("<li><p>" + item + "</p></li>");
            });
            $("<ul/>", {
                "class": "report-list",
                html: errorItems.join("")
            }).appendTo($(divErrorPanel));

            $(divReportPanel).append(divErrorPanel);

        }
        
        var items=[];
        if(report.emailToReport!="")
            items.push("<p>"+labels.lbl_emailto+" "+report.emailToReport+ "</p>");
        $(divReportPanel).append(items);
        var btm_finish=labels.lbl_end;
        var btm_continue=labels.lbl_continue;
        $(divReportPanel).dialog({
            title: "Report",
            position: { my: "center", at: "center", of: window },
            dialogClass: "no-close",
            autoOpen: true,
            draggable: false,
            modal: true,
            width: 450,
            height: (hasError==true)?500:200,
            closeOnEscape: true,
            buttons: {
                "Finish": function() {
                    $( this ).dialog( "close" );
                    location.reload();
                }
            }
        });
        $(divReportPanel).dialog("open");


    }

}
