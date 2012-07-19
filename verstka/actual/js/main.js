$(function(){
    $('#page').css('height',$(window).height()-95);
    $('#tabs_content_block').css('height', $(window).height()-205);
    tabsWidthDetect();
    showTabContent($('#tabs_manage_block ul li.active').attr('id'));
});

$('#tabs_manage_block ul li a').live('click', function(){
    $('#tabs_manage_block ul li').removeClass('active');
    $(this).parent().addClass('active');
    showTabContent($(this).parent().attr('id'));
});
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
window.onresize = function (){
    $('#page').css('height',$(window).height()-112);
    $('#tabs_content_block').css('height', $(window).height()-225);
    tabsWidthDetect();
};

function tabsWidthDetect(){
    $('#tabs_manage_block ul li').css('width', (parseInt($('#tabs_manage_block ul').css('width')) - 1)/$('#tabs_manage_block ul li').length - 12);
}
function showTabContent(tabId){
    $('#tabs_content_block div').hide();
    $('#tabs_content_block div.'+tabId).show();
}