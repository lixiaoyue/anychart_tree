
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
    //TODO: Показать вкладку которая в hash
//    if (location.hash.length>2){
//        var _xmlFileName = location.hash.substr(1);
//    }
    //устанавливаем высоту объектов в зависимости от высоты экрана
    $('#page').css('height',$(window).height()-95);
    $('#tabs_content_block').css('height', $(window).height()-205);
    //проверяем выполнена ли регистрация
    if ($('ul.registration').hasClass('true')) {LOGGED_IN = true}
    //если регистрация не выполнена делаем невозможным выбор режима редастирования
    if (!LOGGED_IN){
        $('input[name=mode]:checked').val('view');
        $('input[name=mode]').attr('disabled',true)
    }
    //проверяем какой выбран режим - просмотра или редастирования,
    if ($('input[name=mode]:checked').val() == 'edit') {MODE_EDITION = true}
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
    if ($('#tabs_manage_block ul li#tab_' + $(this).attr('id')).length <= 0){
        $('#tabs_manage_block ul li').removeClass('active');
        //при клике на информационныю ссылку
        if ($(this).hasClass('info')){
            $('#tabs_manage_block ul').append('<li class="active" id="tab_' + $(this).attr('id') + '" ><a>'+$(this).html()+'</a><div class="closeTab info"></div></li>');
        //при клике на остальные ссылки
        }else{
            //добавляем элемент вкладки
            $('#tabs_manage_block ul').append('<li class="active" id="tab_' + $(this).attr('id') + '" ><a>'+$(this).html()+'</a><div class="closeTab"></div></li>');
            $('#tabs_content_block').append('<div class="tabs tab_'+$(this).attr('id')+'"> </div>');
            //если открываем требование
            if($(this).hasClass('reqs')){
                showRequirementInTab($(this).attr('id'));
            //если открываем узел, т.е. бизнес-требование
            }else if($(this).hasClass('open_tie_in_tab')){
                showNodeInTab($(this).attr('id'));
            //если открываем статус
            }else{
                var parent = $(this).parent().parent().parent().parent().parent();
                var name = parent.children('div').children('p').children('span').children('a.open_tie_in_tab').html();
                $('#tabs_manage_block ul li#tab_'+$(this).attr('id')+' a').html(name + ': status');
                showNodeStatusInTab(parent.attr('id'));
            }
        }
        //Определяем ширину вкладок
        tabsWidthDetect();
    }else{
        $('#tabs_manage_block ul li').removeClass('active');
        $('#tabs_manage_block ul li#tab_' + $(this).attr('id')).addClass('active');
    }
    //показываем содержимое в активной вкладе
    showTabContent('tab_'+$(this).attr('id'));
});

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

//TODO: добавить новое требование

