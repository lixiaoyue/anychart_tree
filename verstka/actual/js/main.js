$(function(){
    $('#page').css('height',$(window).height()-95);
    $('#tabs_content_block').css('height', $(window).height()-205);
    tabsWidthDetect();
    showTabContent($('#tabs_manage_block ul li.active').attr('id'));

    //Вспомогательные меню на правую кнопку мыши
    $('span.right_active.tie').contextMenu('popup_tie_menu',{
            bindings: {
                'create_tie': function(t) {
                    console.log('Trigger was '+t.id+'\nAction was Create');
                },
                'delete_tie': function(t) {
                    console.log('Trigger was '+t.id+'\nAction was Delete');
                }
            },
            menuStyle: {
                width: 160
            }
    });
    $('span.right_active.req').contextMenu('popup_req_menu',{
        bindings: {
            'add_req': function(t) {
                console.log('Trigger was '+t.id+'\nAction was Create');
            },
            'delete_all_req': function(t) {
                console.log('Trigger was '+t.id+'\nAction was Delete');
            }
        },
        menuStyle: {
            width: 160
        }
    });
});


//Сворачиваем, разварачиваем деверо
$('a.sc').live('click', function(){
    var liId = $(this).parent().parent().parent().attr('id');
    if ($('li#'+liId).hasClass('cl')){
        $('li#'+liId).removeClass('cl');
        $('li#'+liId + ' div:first p a.sc').removeClass('close_tie').addClass('open_tie');
        if ($('li#'+liId).hasClass('req')){
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

//Открываем новую вкладку из девера
$('a.open_tab').live('click', function(){
    if ($('#tabs_manage_block ul li#tab_' + $(this).attr('id')).length <= 0){
        $('#tabs_manage_block ul li').removeClass('active');
        $('#tabs_manage_block ul').append('<li class="active" id="tab_' + $(this).attr('id') + '" ><a href="#">'+$(this).html()+'</a><div class="closeTab"></div></li>');
        tabsWidthDetect();
    }else{
        $('#tabs_manage_block ul li').removeClass('active');
        $('#tabs_manage_block ul li#tab_' + $(this).attr('id')).addClass('active');
    }
    showTabContent('tab_'+$(this).attr('id'));
});

//Закрыть вкладку и удалить ее содержимое со страницы
$('.closeTab').live('click', function(){
    $('#tabs_content_block div.'+ $(this).parent().attr('id')).remove();
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
