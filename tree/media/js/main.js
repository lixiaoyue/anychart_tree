var MODE_EDITION = false;
var LOGGED_IN = false;

$(function(){
    $('#menu > ul').dropotron({
        mode: 'fade',
        globalOffsetY: 11,
        offsetY: -15
    });
    $('#page').css('height',$(window).height()-95);
    $('#tabs_content_block').css('height', $(window).height()-205);
    if ($('ul.registration').hasClass('true')) {LOGGED_IN = true}
    if (!LOGGED_IN){
        $('input[name=mode]:checked').val('view');
        $('input[name=mode]').attr('disabled',true)
    }
    if ($('input[name=mode]:checked').val() == 'edit') {MODE_EDITION = true}
    switch_mode(MODE_EDITION);
    tabsWidthDetect();
    showTabContent($('#tabs_manage_block ul li.active').attr('id'));
});

//Включить, выключить режим просмотра
function switch_mode(is_editable){
    if (is_editable){
        $('.treeview span.add, .treeview span.edit, .treeview span.delete').show();
    }else{
        $('.treeview span.add, .treeview span.edit, .treeview span.delete').hide();
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
    if ($('li#'+liId).hasClass('cl')){
        $('li#'+liId).removeClass('cl');
        $('li#'+liId + ' div:first p a.sc').removeClass('close_tie').addClass('open_tie');
        if ($('li#'+liId).hasClass('req')){
            if ($('li#' + liId + ' ul').html() == '')pasteRequirements(liId);
            $('li#'+liId + ' div:first p a.sc').removeClass('close_req').addClass('open_req');
        }
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

//Ресайз окна
window.onresize = function (){
    $('#page').css('height',$(window).height()-112);
    $('#tabs_content_block').css('height', $(window).height()-225);
    tabsWidthDetect();
};

//Resizing detection
function tabsWidthDetect(){
    $('#tabs_manage_block ul li').css('width', (parseInt($('#tabs_manage_block ul').css('width')) - 1)/$('#tabs_manage_block ul li').length - 20);
}

//При клике по вкладке показать содержимое вкладки
$('#tabs_manage_block ul li a').live('click', function(){
    $('#tabs_manage_block ul li').removeClass('active');
    $(this).parent().addClass('active');
    showTabContent($(this).parent().attr('id'));
});

//Показать содержимое вкладки
function showTabContent(tabId){
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.'+tabId).show();
}

//Открываем вкладку при клике по дереву
$('a.open_tab.reqs, a.open_tie_in_tab, a.open_tab.info').live('click', function(){
    if ($('#tabs_manage_block ul li#tab_' + $(this).attr('id')).length <= 0){
        $('#tabs_manage_block ul li').removeClass('active');
        if ($(this).hasClass('info')){
            $('#tabs_manage_block ul').append('<li class="active" id="tab_' + $(this).attr('id') + '" ><a href="#">'+$(this).html()+'</a><div class="closeTab info"></div></li>');
        }else{
            $('#tabs_manage_block ul').append('<li class="active" id="tab_' + $(this).attr('id') + '" ><a href="#">'+$(this).html()+'</a><div class="closeTab"></div></li>');
            $('#tabs_content_block').append('<div class="tabs tab_'+$(this).attr('id')+'"> </div>');
            if($(this).hasClass('reqs')){
                showRequirementInTab($(this).attr('id'));
            }else{
                showNodeInTab($(this).attr('id'));
            }
        }
        tabsWidthDetect();
    }else{
        $('#tabs_manage_block ul li').removeClass('active');
        $('#tabs_manage_block ul li#tab_' + $(this).attr('id')).addClass('active');
    }
    showTabContent('tab_'+$(this).attr('id'));
});

//получить содержимое бизнес-требования и вставить в таб
function showNodeInTab(id_node){
    $.ajax({
        type: "POST",
        url: "/getNodeDescription/",
        data: {nodeId: id_node, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_'+id_node).html(html);
            $("#tabs_content_block div.tabs.tab_" + id_node + " textarea").each(function(n, obj) {
                fck = new FCKeditor(obj.id) ;
                fck.ToolbarSet = 'AnyChartTree';
                fck.BasePath = "/media/fckeditor/" ;
                fck.ReplaceTextarea() ;
                fck.Width = '100%';
                fck.Height = '300';
            });
        }
    });
}

//получить содержимое требования и вставить в таб
function showRequirementInTab(id_req){
    $.ajax({
        type: "POST",
        url: "/getRequirementDescription/",
        data: {reqId: id_req, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
           $('#tabs_content_block div.tabs.tab_'+id_req).html(html);
            $("textarea").each(function(n, obj) {
                fck = new FCKeditor(obj.id) ;
                fck.ToolbarSet = 'AnyChartTree';
                fck.BasePath = "/media/fckeditor/" ;
                fck.Width = '100%';
                fck.Height = '500';
                fck.ReplaceTextarea();
            });
        }
    });
}

//Закрыть вкладку и удалить ее содержимое со страницы
$('.closeTab').live('click', function(){
    if (!$(this).hasClass('info')){$('#tabs_content_block div.'+ $(this).parent().attr('id')).remove();}
    if ($(this).parent().hasClass('active') && $(this).parent().next().length > 0){
        $('#tabs_manage_block ul li').removeClass('active');
        $(this).parent().next().addClass('active');
        showTabContent($(this).parent().next().attr('id'));
    }else if($(this).parent().hasClass('active') && $(this).parent().prev().length > 0){
        $('#tabs_manage_block ul li').removeClass('active');
        $(this).parent().prev().addClass('active');
        showTabContent($(this).parent().prev().attr('id'));
    }else if (!$(this).parent().hasClass('active')){
        showTabContent($('#tabs_manage_block ul li.active').attr('id'));
    }
    $(this).parent().remove();
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

