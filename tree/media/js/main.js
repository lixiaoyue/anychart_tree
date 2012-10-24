//------------------ОБЩЕЕ-----------------------//

var LOGGED_IN = false; // если false,  то никто не залогинен
var EDITING = false; // если false, но все можно нажимать, никакой узел не находиться в состоянии редактирования.

//выполняем сразу при загрузке страницы:
$(function(){
    //делаем меню красивым
    $('#menu > ul').dropotron({
        mode: 'fade',
        globalOffsetY: 6,
        offsetY: -15
    });

    //устанавливаем высоту объектов в зависимости от высоты экрана
    $('#page').css('height',$(window).height()-45);
    $('#tabs_content_block').css('height', $(window).height()-160);

    //проверяем выполнена ли регистрация
    if ($('ul.registration').hasClass('true')) {LOGGED_IN = true}

    //если регистрация не выполнена делаем невозможным выбор режима редактирования
    if (!LOGGED_IN){
        $('input[name=mode]:checked').val('view');
        $('input[name=mode]').attr('disabled',true);
    }

    //Показываем вкладку которая в hash
    if (location.hash.length>2){
        var tab_id = location.hash.substr(5);
        var req_data = location.hash.substr(1);
        if (req_data.substr(0, 3)=='tie'){
            var tieId = req_data.split(':')[0];
            var reqId = req_data.split(':')[1];
            $('body').queue(function () {
                pasteRequirements('req_' + tieId);
            });
            $('body').queue(function () {
                openTree('description_' + tieId);
                openTree('req_' + tieId);
                openTab(reqId);
                pickNodeInTree($('#'+reqId));
                $('body').dequeue();
            });
        }else if( tab_id.substr(0, 15)=='description_tie'){
            openTab(tab_id);
            openTree(tab_id);
        }
    }

    var tie_id; //идентификатор узла, по которому щелкнули правой кнопкой мыши
    //Вспомогательные меню на правую кнопку мыши
    $('span.right_active.tie').contextMenu('popup_tie_menu',{
        onContextMenu: function(e) {
            if ($(e.target).parent().parent().parent('li').length > 0){
                tie_id = $(e.target).parent().parent().parent('li').attr('id').replace('tree_tie_','');
            }else{
                tie_id = $(e.target).attr('id').replace('description_tie_','');
            }
            return true;
        },bindings: {'create_tie': function() {
            showCreateTieForm(tie_id, 'BR');}
        },
        menuStyle: {width: 160},
        itemHoverStyle: {backgroundColor:'none', border:'none'}
    });
    $('span.right_active.req').contextMenu('popup_req_menu',{
        onContextMenu: function(e) {
            tie_id = $(e.target).parent().parent().parent().attr('id').replace('req_tie_','');
            return true;
        },bindings: {'add_req': function() {
            showCreateTieForm(tie_id, 'OR');}
        },
        menuStyle: {width: 160},
        itemHoverStyle: {backgroundColor:'none', border:'none'}
    });
});

//Реакция на ресайз окна
window.onresize = function (){
    $('#page').css('height',$(window).height()-45);
    $('#tabs_content_block').css('height', $(window).height()-160);
//    tabsWidthDetect();
};


//------------------ДЕРЕВО-----------------------//

//Развернуть дерево до нужного узла
function openTree(tab_id){
    if ($('li#'+tab_id).hasClass('req')){
        var liId = tab_id;
        $('li#req_'+tab_id + ' div:first p a.sc').removeClass('close_req').addClass('open_req');
    }else{
        liId = $('#'+tab_id).parent().parent().parent().parent().attr('id');
        pickNodeInTree($('#'+tab_id));
    }
    do
    {
        if ($('li#'+liId).hasClass('cl')){
            $('li#'+liId).removeClass('cl');
            $('li#'+liId + ' div:first p a.sc').removeClass('close_tie').addClass('open_tie');
        }
        liId = $('li#'+liId).parent().parent().attr('id')
    }
    while (liId);
}

//Сворачиваем, разварачиваем деверо
$('a.sc, span.req, span.folder').live('click', function(){
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
            $('body').dequeue();
        }
    });
}

//Открываем вкладку при клике по дереву
$('a.open_tab.reqs, a.open_tie_in_tab').live('click', function(){
    if (EDITING){
        console.log('Отмена редактирования узла ' + location.hash.substr(1).replace('req_','').replace('tab_description_tie_',''));
        cancelEditNode(location.hash.substr(1).replace('req_','').replace('tab_description_tie_',''));
    }
    openTab($(this).attr('id'));
    pickNodeInTree($(this));

});

//Выделить открытый узел в дереве
function pickNodeInTree(a_object){
    $('.treeview p').removeClass('active');
    a_object.parent('p').addClass('active');
    a_object.parent().parent('p').addClass('active');
}

//------------------ОТКРЫТИЕ ВКЛАДОК-----------------------//

//Открываем вкладку по id вкладки и по типу (reqs, open_tie_in_tab)
function openTab(object_id){
    var obj = $('a#'+object_id);
    addBlockForTabContent(object_id);
    addTabNameToManageBlock(obj.html());
    showTabContent('tab_'+ object_id);
    getNodeContent(object_id);
}

//получаем данные по узлу
function getNodeContent(object_id){
    $.ajax({
        type: "POST",
        url: "/getNode/",
        data: {nodeId: object_id, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_'+object_id).html(html);
        }
    });
}

//добавляем блок для содержимого вкладки
function addBlockForTabContent(block_id){
    if ($('.tabs.tab_'+block_id).length <=0){
        $('#tabs_content_block').append('<div class="tabs tab_'+block_id+'"> </div>');
    }

}

//добавляем название вкладки
function addTabNameToManageBlock(tab_name){
    $('#tabs_manage_block ul li.active').html(tab_name);
    $('#tabs_manage_block li.active span').remove();
}

//Показать содержимое вкладки
function showTabContent(tabId){
    if (tabId != undefined){
        if (tabId.substr(0, 7)=='tab_req'){
            var reqId = tabId.replace('tab_', '');
            var tieId = $('#'+reqId).parent().parent().parent().parent().parent().attr('id').replace('req_', '');
            location.hash = tieId + ':' + reqId;
        }else{
            location.hash = tabId;
        }
    }
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.'+tabId).show();
}


//------------------РЕДАКТИРОВАНИЕ УЗЛОВ ДЕРЕВА-----------------------//

//Создаем редакторы из текстовых полей на странице
function makeEditors(tab){
    $("#tabs_content_block div.tabs.tab_" + tab + " textarea.big_text").each(function(n, obj) {
        var fck = new FCKeditor(obj.id) ;
        fck.ToolbarSet = 'AnyChartTree';
        fck.BasePath = "/media/fckeditor/" ;
        fck.Width = '100%';
        fck.Height = '500';
        fck.ReplaceTextarea() ;
    });
    $("#tabs_content_block div.tabs.tab_" + tab + " textarea.small_text").each(function(n, obj) {
        var fck = new FCKeditor(obj.id) ;
        fck.ToolbarSet = 'AnyChartTree';
        fck.BasePath = "/media/fckeditor/" ;
        fck.Width = '100%';
        fck.Height = '200';
        fck.ReplaceTextarea() ;
    });
}

//При клике на форму для комментария удаляем вспомогательный текст
$('#deletion_comment, #release_description, #change_description').live('click', function(){
    $(this).text('');
});

//При клике на форму для комментария удаляем вспомогательный текст
$('#add_node_name_text, #add_file_name_text, #add_release_name_text, #add_release_number_text, #add_release_date_text').live('click', function(){
    $(this).val('');
});

//Показать или сткрыть всплывающее окно
function showPopup(bool){
    if(bool){
        $('div.popup, .shadow').show();
    }else{
        $('div.popup').html('');
        $('div.popup, .shadow').hide();
    }
}

//Всплывающая форма "Вы действительно хотите удалить узел?"
function showDeleteNodePopup(node_id){
      $('.deletion_form .cover_form').attr('id', node_id);
      $('div.popup').html($('.deletion_form').html());
      showPopup(true);
}

//Удалить узел
function DeleteNode(node_id, comment){
    if (comment=='Оставьте комметарий'){comment=''}
    $.ajax({
        type: "POST",
        url: "/deleteNode/",
        data: {node: node_id, comment:comment, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(href){
            showPopup(false);
            window.location.href = href;
            window.location.reload();
        }
    });
}

//Показать всплывающую форму "Создать новый узел"
function showCreateTieForm(parent_id, type){
    $('.add_node_form .cover_form').attr('id', parent_id);
    $('.cover_form .confirm.button').attr('id', type);
    $('div.popup').html($('.add_node_form').html());
    showPopup(true);
}

//Создать новый узел
function CreateTie(parent_id, type, name){
    if (name=='Как называется твой новый узел?'){
        alert('Извините, но вы не можете создать узел без имени.')
    }else{
        $.ajax({
        type: "POST",
        url: "/addNode/",
        data: {parent:parent_id, type:type, name:name, product:$('input#product:checked').val(), csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(href){
            showPopup(false);
            console.log('LOG is ' + href);
            window.location.href = href;
            window.setTimeout(function(){
                    window.location.reload();
                }, 100
            );
        }
    });
    }
}

//Получить идентикатор ссылки в дереве по id узла
function getNodeId(id){
    if ($('#tabs_content_block div.tabs.tab_description_tie_'+id).length > 0){
        var nodeId = 'description_tie_'+id;
    }else{
        nodeId = 'req_'+id;
    }
    return nodeId;
}

//Редактировать узел
function editNode(nodeId){
    $.ajax({
        type: "POST",
        url: "/editNode/",
        data: {nodeId: nodeId, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + getNodeId(nodeId)).html(html);
            window.setTimeout(function(){makeEditors(getNodeId(nodeId));}, 300);
            if ($('.table').hasClass('editable')){EDITING = true;}
        }
    });
}

//Отменить редактирование
function cancelEditNode(nodeId){
    if (EDITING){
        $.ajax({
            type: "POST",
            url: "/cancelEditNode/",
            data: {nodeId: nodeId, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(){
                EDITING = false;
                window.location.reload();
            }
        });
    }
}

//При смене адреса выйти из режима редактирования.
window.onbeforeunload = function() {
    if (EDITING) {
        console.log('Отмена редактирования узла ' + location.hash.substr(1).replace('req_','').replace('tab_description_tie_',''));
        cancelEditNode(location.hash.substr(1).replace('req_','').replace('tab_description_tie_',''));
        EDITING = false;
    }
};

//показать форму добавления нового релиза
function ShowAddReleaseForm(){
    $('div.popup').html($('.add_release_form').html());
    showPopup(true);
}

//Добавление нового релиза
function addRelease(){
    var product = $('input#product:checked').val();
    var release_name = $('input#add_release_name_text').val();
    var release_number = $('input#add_release_number_text').val();
    var release_date = $('input#add_release_date_text').val();
    var release_description = $('textarea#release_description').val();

    if(release_description == 'Оставьте описание релиза тут'){
        release_description = '';
    }

    if (release_name == 'Как называется твой релиз?'){
        alert('Извините, но вы не можете создать узел без имени.')
    }else if(release_number == 'Какой номер релиза?'){
        alert('Извините, но вы не можете создать релиз без номера.')
    }else if(release_date == 'Год-месяц-день'){
        alert('Извините, но вы не можете создать релиз без даты выпуска.')
    }else{
        $.ajax({
            type: "POST",
            url: "/addReleaseToNode/",
            data: {
                product:product,
                name:release_name,
                number:release_number,
                date:release_date,
                description:release_description,
                csrfmiddlewaretoken: '{{ csrf_token }}'
            },
            success: function(html){
                showPopup(false);
                $('#selectRelease option').attr('selected', false);
                $('#selectRelease').append(html);
            }
        });
    }
}

//Уточнить почему меняется статус или релиз
function AskWhy(item){
    $('.ask_why .cover_form').attr('id', item);
    $('div.popup').html($('.ask_why').html());
    showPopup(true);
}

//Записать в скрытом виде комментарий по смене статуса или релиза
function addComment(item, comment){
    $('#'+item+'_comment').text(comment);
    showPopup(false);
}

//Сохранить отредактированый узел и показать его же с новыми данными
function saveNode(nodeId){
    var files = [];
    $('.node_files a').each(function(){
        files.push($(this).attr('id'));
    });
    $.ajax({
        type: "POST",
        url: "/saveNode/",
        data: {
            nodeId: nodeId,
            title:$('#nodeTitle').val(),
            status:$('#selectStatus').val(),
            status_comment:$('#status_comment').val(),
            release:$('#selectRelease').val(),
            release_comment:$('#release_comment').val(),
            developer:$('#selectDeveloper').val(),
            tester:$('#selectTester').val(),
            source:$('#selectSource').val(),
            source_desc:$("#source_textArea___Frame").contents().find('#xEditingArea iframe').contents().find('html body').html(),
            node_desc:$("#content_textArea___Frame").contents().find('#xEditingArea iframe').contents().find('html body').html(),
            files: files,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + getNodeId(nodeId)).html(html);
            EDITING = false;
        }
    });
}

//TODO:показать форму добавления нового файла
function ShowAddfileForm(){
    $('div.popup').html($('.add_file_form').html());
    showPopup(true);
}

function SaveFile(){
    $.ajax({
        type: "POST",
        url: "/addFileToNode/",
        data: {
            nodeId: $('input#node_id').val(),
            file_name: $('input#add_file_name_text').val(),
            file:$('input#id_file').val().getAsBinary(),
            enctype: 'multipart/form-data',
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            console.log(html);
            showPopup(false);
        }
    });
}

// TODO: Посмотреть историю узла
function viewNodeHistory(nodeId){
    console.log(nodeId);
}

////TODO: Определяем ширину вкладок
//function tabsWidthDetect(){
//    $('#tabs_manage_block ul li').css('width', (parseInt($('#tabs_manage_block ul').css('width')) - 1)/$('#tabs_manage_block ul li').length - 20);
//}


