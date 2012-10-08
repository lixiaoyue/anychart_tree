
var MODE_EDITION = false; // по умолчанию, выбран режим просмотра
var LOGGED_IN = false; // если false,  то никто не залогинен

//функция, выполняемая сразу при загрузке страницы
$(function(){
    //делаем меню красивым
    $('#menu > ul').dropotron({
        mode: 'fade',
        globalOffsetY: 11,
        offsetY: -15
    });
    //Показываем вкладку которая в hash
    if (location.hash.length>2){
        var tab_id = location.hash.substr(5);
        if (tab_id.substr(0, 3)=='req'){
            openTab('reqs', tab_id);
        }else if(tab_id.substr(0, 15)=='description_tie'){
            openTab('open_tie_in_tab', tab_id);
        }else if (tab_id.substr(0, 16)=='notification_tie'){
            openTab('status', tab_id);
        }else{
            openTab('info', tab_id);
        }
    }
    //устанавливаем высоту объектов в зависимости от высоты экрана
    $('#page').css('height',$(window).height()-95);
    $('#tabs_content_block').css('height', $(window).height()-205);
    //проверяем выполнена ли регистрация
    if ($('ul.registration').hasClass('true')) {LOGGED_IN = true}
    //если регистрация не выполнена делаем невозможным выбор режима редактирования
    if (!LOGGED_IN){
        $('input[name=mode]:checked').val('view');
        $('input[name=mode]').attr('disabled',true);
    //если регистрация выполнена, включаем режим редактирования
    }
    //менеям интерфейс в соответствии с режимом
    switch_mode(MODE_EDITION);
    //определяем ширину вкладок
    tabsWidthDetect();
    //показываем содержимое активной вкладки
    showTabContent($('#tabs_manage_block ul li.active').attr('id'));
});

//Включить, выключить режим просмотра
function switch_mode(is_editable){
    if (is_editable){
        $('.treeview span.add, .treeview span.edit, .treeview span.delete').show();
        $('.table.read').hide();
        $('.table.edit').show();
    }else{
        $('.treeview span.add, .treeview span.edit, .treeview span.delete').hide();
        $('.table.read').show();
        $('.table.edit').hide();
    }
}

//Обработка выбора режима просмотра в меню (радио-баттон)
$('input[name=mode]').live('change', function() {
    if($('input[name=mode]:checked').val()=='view'){MODE_EDITION = false}else{MODE_EDITION = true}
    switch_mode(MODE_EDITION);
});

//Сворачиваем, разварачиваем деверо
$('a.sc').live('click', function(){
    var liId = $(this).parent().parent().parent().attr('id');
    //если узел свернут, разварачиваем
    if ($('li#'+liId).hasClass('cl')){
        $('li#'+liId).removeClass('cl');
        $('li#'+liId + ' div:first p a.sc').removeClass('close_tie').addClass('open_tie');
        //если это папка с требованиями
        if ($('li#'+liId).hasClass('req')){
            //если требования не подгружены, получаем требования для узла по id узла
            if ($('li#' + liId + ' ul').html() == '')pasteRequirements(liId);
            $('li#'+liId + ' div:first p a.sc').removeClass('close_req').addClass('open_req');
        }
    //если узел развернут, сворачиваем
    }else{
        $('li#'+liId).addClass('cl');
        $('li#'+liId + ' div:first p a.sc').removeClass('open_tie').addClass('close_tie');
        if ($('li#'+liId).hasClass('req')){
            $('li#'+liId + ' div:first p a.sc').removeClass('open_req').addClass('close_req');
        }
    }
});

//Получить список требований для узла
function pasteRequirements(liId){
    $.ajax({
        type: "POST",
        url: "/getRequirements/",
        data: {liId: liId, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('li#' + liId + ' ul').html(html);
        }
    });
}

//Реакция на ресайз окна
window.onresize = function (){
    $('#page').css('height',$(window).height()-112);
    $('#tabs_content_block').css('height', $(window).height()-225);
    //Определяем ширину вкладок
    tabsWidthDetect();
};

//Определяем ширину вкладок
function tabsWidthDetect(){
    $('#tabs_manage_block ul li').css('width', (parseInt($('#tabs_manage_block ul').css('width')) - 1)/$('#tabs_manage_block ul li').length - 20);
}

//При клике по вкладке
$('#tabs_manage_block ul li a').live('click', function(){
    $('#tabs_manage_block ul li').removeClass('active');
    $(this).parent().addClass('active');
    //Показваем содержимое вкладки
    showTabContent($(this).parent().attr('id'));
});

//Показать содержимое вкладки
function showTabContent(tabId){
    if (tabId != undefined){location.hash = tabId;}
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.'+tabId).show();
}

//Открываем вкладку при клике по дереву
$('a.open_tab.reqs, a.open_tie_in_tab, a.open_tab.info, a.open_tab.status').live('click', function(){
    if($(this).hasClass('reqs')){var type = 'reqs'}
    else if($(this).hasClass('open_tie_in_tab')){type = 'open_tie_in_tab'}
    else if($(this).hasClass('info')){type = 'info'}
    else {type = 'status'}
    openTab(type, $(this).attr('id'));
});

//добавляем название вкладки
function addTabNameToManageBlock(id, tab_name, closeClass){
    $('#tabs_manage_block ul').append('<li class="active" id="tab_' + id + '" ><a>'+tab_name+'</a><div class="closeTab' + closeClass + '"></div></li>');
}
//добавляем блок для содержимого вкладки
function addBlockForTabContent(block_id){
    $('#tabs_content_block').append('<div class="tabs tab_'+block_id+'"> </div>');
}
//переключаем активню вкладку
function turnOnActiveTab (tab_id){
    $('#tabs_manage_block ul li').removeClass('active');
    $('#tabs_manage_block ul li#tab_' + tab_id).addClass('active');
}
//Открываем вкладку по id вкладки и по типу (reqs, open_tie_in_tab, info, status)
function openTab(type, object_id){
    var obj = $('a#'+object_id);
    console.log('id = ' + object_id, obj);
    if ($('#tabs_manage_block ul li#tab_' + object_id).length <= 0){
        $('#tabs_manage_block ul li').removeClass('active');
        //при клике на информационныю ссылку
        if (type == 'info'){
            //добавляем название вкладки
            addTabNameToManageBlock(object_id, obj.html(),' info');
            //при клике на остальные ссылки
        }else{
            //добавляем название вкладки
            console.log(object_id, obj, obj.html());
            addTabNameToManageBlock(object_id, obj.html(),'');
            addBlockForTabContent(object_id);
            //если открываем требование
            if(type =='reqs'){
                showRequirementInTab(object_id);
                //если открываем узел, т.е. бизнес-требование
            }else if(type = 'open_tie_in_tab'){
                showNodeInTab(object_id);
                //если открываем статус
            }else{
                var parent = obj.parent().parent().parent().parent().parent();
                var name = parent.children('div').children('p').children('span').children('a.open_tie_in_tab').html();
                $('#tabs_manage_block ul li#tab_'+object_id+' a').html(name + ': status');
                showNodeStatusInTab(parent.attr('id'));
            }
        }
        //Определяем ширину вкладок
        tabsWidthDetect();
    }else{
        //включа активню вкладку
        turnOnActiveTab(object_id);
    }
    //показываем содержимое в активной вкладе
    showTabContent('tab_'+ object_id);
}

//получить статус бизнес-требования и вставить в Tab
function showNodeStatusInTab(node_id){
    console.log(node_id);
    switch_mode(MODE_EDITION);
}

//получить содержимое бизнес-требования и вставить его описание в таб
function showNodeInTab(id_node){
    $.ajax({
        type: "POST",
        url: "/getNodeDescription/",
        data: {nodeId: id_node, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_'+id_node).html(html);
            makeEditors(id_node);
            switch_mode(MODE_EDITION);

        }
    });
}

//получить содержимое требования по id и вставить его описание в таб
function showRequirementInTab(id_req){
    $.ajax({
        traditional:true,
        type: "POST",
        url: "/getRequirementDescription/",
        data: {reqId: id_req, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
           $('#tabs_content_block div.tabs.tab_'+id_req).html(html);
            makeEditors(id_req);
            switch_mode(MODE_EDITION);
        }
    });
}

//Создаем редакторы из текстовых полей на странице
function makeEditors(ib_tab){
    $("#tabs_content_block div.tabs.tab_" + ib_tab + " textarea.big_text").each(function(n, obj) {
        fck = new FCKeditor(obj.id) ;
        fck.ToolbarSet = 'AnyChartTree';
        fck.BasePath = "/media/fckeditor/" ;
        fck.Width = '100%';
        fck.Height = '500';
        fck.ReplaceTextarea() ;
    });
    $("#tabs_content_block div.tabs.tab_" + ib_tab + " textarea.small_text").each(function(n, obj) {
        fck = new FCKeditor(obj.id) ;
        fck.ToolbarSet = 'Basic';
        fck.BasePath = "/media/fckeditor/" ;
        fck.Width = '100%';
        fck.Height = '200';
        fck.ReplaceTextarea() ;
    });
}

//Закрыть вкладку и удалить ее содержимое со страницы
$('.closeTab').live('click', function(){
    //удаляем содержимое вкладки, только если это не общая информационная вкладка
    if (!$(this).hasClass('info')){$('#tabs_content_block div.'+ $(this).parent().attr('id')).remove();}
    else{$('#tabs_content_block div.'+ $(this).parent().attr('id')).hide();}
    location.hash = '';
    //если есть следующая вкладка, то при закрытии текущей, она станет активной
    if ($(this).parent().hasClass('active') && $(this).parent().next().length > 0){
        $('#tabs_manage_block ul li').removeClass('active');
        $(this).parent().next().addClass('active');
        //Показываем содежмое активной вкладки
        showTabContent($(this).parent().next().attr('id'));
    //если нет следующей, но есть предыдущая вкладка, то при закрытии текущей, она станет активной
    }else if($(this).parent().hasClass('active') && $(this).parent().prev().length > 0){
        $('#tabs_manage_block ul li').removeClass('active');
        $(this).parent().prev().addClass('active');
        //Показываем содежмое активной вкладки
        showTabContent($(this).parent().prev().attr('id'));
    //если удаляем не активную вкладку, то активная остается активной.
    }else if (!$(this).parent().hasClass('active')){
        //Показываем содежмое активной вкладки
        showTabContent($('#tabs_manage_block ul li.active').attr('id'));
    }
    $(this).parent().remove();
    //Определяем ширину вкладок
    tabsWidthDetect();
});

//Зачеркивание замечаний
$('ul.notification_list li input[type=checkbox]').live('click', function(){
    if ($(this).attr('checked')){
        $(this).parent().removeClass('active').addClass('done');
        $(this).parent().children('span.note_status').show();
    }else{
        $(this).parent().removeClass('done').addClass('active');
        $(this).parent().children('span.note_status').hide();
    }
});

$('span.add').live('click', function(){
    $.ajax({
        type: "POST",
        url: "/showAddNodeForm/",
        data: {csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#hidden_block').html(html);
            var node_id = $('#hidden_block div#name_redaction input[type=text]').attr('id');
            node_id = node_id.replace('node_name_', 'description_tie_');
            addTabNameToManageBlock(node_id, 'new requirement', '');
            addBlockForTabContent(node_id);
            $('#tabs_content_block div.tabs.tab_'+ node_id).html(html);
            makeEditors(node_id);
            tabsWidthDetect();
        }
    });
});

$('span.add.node').live('click', function(){
    if (confirm("Вы действительно хотите создать бизнес требование?")) {
        var parent_id = $(this).prev().children('a').attr('id');
        console.log(parent_id);
        showFormToAddNode(parent_id);
        function showFormToAddNode(id_parent_node){
            $.ajax({
                type: "POST",
                url: "/showAddNodeForm/",
                data: {parentId: id_parent_node, csrfmiddlewaretoken: '{{ csrf_token }}'},
                success: function(html){
                    $('#hidden_block').html(html);
                    var node_id = $('#hidden_block div#name_redaction input[type=text]').attr('id');
                    node_id = node_id.replace('node_name_', 'description_tie_');
                    addTabNameToManageBlock(node_id, $('#' + id_parent_node).html() + ': new', '');
                    addBlockForTabContent(node_id);
                    $('#tabs_content_block div.tabs.tab_'+ node_id).html(html);
                    makeEditors(node_id);
                    tabsWidthDetect();
                }
            });
        }
    }
});

$('span.delete.node').live('click', function(){
    if (confirm("Вы действительно хотите удалить бизнес требование?")) {
        var select_node = $(this).prevAll()[2].firstChild.id;
        select_node = select_node.split('_')[2];
        $.ajax({
            type: "POST",
            url: "/deleteNode/",
            data: {node: select_node, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){ }
        });
    }
});

$('span.delete.req').live('click', function(){
    if (confirm("Вы действительно хотите удалить требование?")) {
        var parent = $(this).offsetParent();
        var req_id = parent.find('a').attr('id').split('_')[1];
    //    console.log($(this).parents('li:first').attr('id'));
        var node_id = $(this).parents('li.req').attr('id');
        node_id = node_id.split('_')[2];
        $.ajax({
            type: "POST",
            url: "/deleteRequirement/",
            data: {req: req_id, node: node_id, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){ }
        });
    }
});

$('span.add.req').live('click', function(){
    if (confirm("Вы действительно хотите создать новое требование?")) {
        var parent_id = $(this).parents('li:first').attr('id');
        showFormToAddReq(parent_id);
        function showFormToAddReq(id_parent_node){
            $.ajax({
                type: "POST",
                url: "/showAddReqForm/",
                data: {parentId: id_parent_node, csrfmiddlewaretoken: '{{ csrf_token }}'},
                success: function(html){
                    $('#hidden_block').html(html);
                    console.log($('#hidden_block').html(html));
                    var req_id = $('#hidden_block div#name_redaction input[type=text]').attr('id');
                    req_id = req_id.replace('req_name_', 'description_tie_');
                    addTabNameToManageBlock(req_id, $('#' + id_parent_node).html() + ': new', '');
                    addBlockForTabContent(req_id);
                    $('#tabs_content_block div.tabs.tab_'+ req_id).html(html);
                    makeEditors(req_id);
                    tabsWidthDetect();
                }
            });
        }
    }
});

$('#cancel').live('click', function(){
    var node_id = $('#hidden_block div#name_redaction input[type=text]').attr('id').split('_')[2];
    $.ajax({
        type: "POST",
        url: "/deleteNode/",
        data: {node: node_id, csrfmiddlewaretoken: '{{ csrf_token }}'}
});
});

$('#add_data').live('click', function(){
    $.datepicker.setDefaults({ dateFormat: 'dd.mm.yy'});
    $("#add_data").datepicker();
});

$('#add_file_button').live('click', function(){
    $('div.popup div.popupContent').html($('#form_to_upload_files').html());
    showPopup(true);
});

$('#add_file_in_node').live('click', function(){
    $('div.popup div.popupContent').html($('#form_to_upload_files_in_node').html());
    showPopup(true);
});

function showPopup(bool){
    if(bool){
        $('div.popupContent, div.popup, .shadow').show();
    }else{
        $('div.popupContent').html('');
        $('div.popup.popupContent, div.popup, .shadow').hide();
    }
}