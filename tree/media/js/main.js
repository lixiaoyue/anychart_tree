//------------------ОБЩЕЕ-----------------------//

var LOGGED_IN = false; // если false,  то никто не залогинен
var EDITING = false; // если false, но все можно нажимать, никакой узел не находиться в состоянии редактирования.

//выполняем сразу при загрузке страницы:
$(function(){
    //делаем меню красивым
    $('#menu > ul').dropotron({
        mode: 'fade',
        globalOffsetY: 5,
        offsetY: -15
    });
    $('#tabs_content_block').html('');
    //устанавливаем высоту объектов в зависимости от высоты экрана
    $('#page').css('height',$(window).height()-45);
    $('#tabs_content_block').css('height', $(window).height()-129);

    // Проверяем выполнена ли регистрация
    if ($('#login_space a').hasClass('registration')) {LoggedIn(true);}
    else{LoggedIn(false);}

    // Показываем вкладку которая в hash
    if (location.hash.length>2){
        var req_data = location.hash.substr(1);
        if (req_data.substr(0, 2)=='OR'){
            var tieId = '';
            $.ajax({
                type: "POST",
                url: "/getParentNode/",
                data: {reqId: window.location.pathname.substr(1,2) + req_data.substr(2), csrfmiddlewaretoken: '{{ csrf_token }}'},
                success: function(html){
                    tieId = html;
                    $('body').queue(function () {
                        pasteRequirements('reqs_' + tieId);
                    });
                    $('body').queue(function () {
                        openTree('BR_' + tieId);
                        openTree('reqs_' + tieId);
                        openTab('OR_' + window.location.pathname.substr(1,2) + req_data.substr(2));
                        pickNodeInTree($('#'+req_data));
                        $('body').dequeue();
                    });
                }
            });
       }else if(req_data.substr(0, 5)=='trash'){
            openTrash();
        }else{
            console.log('Открываем: ' + window.location.pathname.substr(1,2) + req_data.substr(2));
            $('body').queue(function () {
                openTab(req_data.substr(0,2) + '_' + window.location.pathname.substr(1,2) + req_data.substr(2));
                openTree(req_data.substr(0,2) + '_' + window.location.pathname.substr(1,2) + req_data.substr(2));
                pickNodeInTree($('a#'+req_data));
                $('body').dequeue();
            });
        }
    }
});

// Получить родительский узел для требования
function getParentNode(reqId){
//    console.log('req - ' + reqId);
    return answer;
}

// Включить. выключить режим авторизованного пользователя.
function LoggedIn(flag){
    LOGGED_IN = flag;
    if (flag){
        // показать инструменты редактирования
        $('.tools').show();
        //Вспомогательные меню на правую кнопку мыши
        var tie_id; //идентификатор узла, по которому щелкнули правой кнопкой мыши
        // создать новый узел
        $('span.right_active.tie').contextMenu('popup_tie_menu',{
            onContextMenu: function(e) {
                if ($(e.target).parent().attr('id') != undefined){
                    if ($(e.target).parent().attr('id').substr(0,2) == 'PR'){
                        tie_id = 'None'
                    }
                }else{
                    if ($(e.target).parent().parent().parent('li').length > 0){
                        tie_id = $(e.target).parent().parent().parent('li').attr('id');
                    }else{
                        tie_id = $(e.target).attr('id');
                    }
                }
                return true;
            },bindings: {
                'create_tie': function() {
                showCreateTieForm(tie_id, 'BR');},
                'create_folder': function() {
                showCreateTieForm(tie_id, 'NE');}
            },
            menuStyle: {width: 170, cursor:'pointer' },
            itemHoverStyle: {backgroundColor:'#ccc', border:'1px solid white', margin:'0', padding:'3px'}
        });
        // создать новое требование
        $('span.right_active.req').contextMenu('popup_req_menu',{
            onContextMenu: function(e) {
                tie_id = $(e.target).parent().parent().parent().attr('id').replace('req_tie_','');
                return true;
            },bindings: {'add_req': function() {
                showCreateTieForm(tie_id, 'OR');}
            },
            menuStyle: {width: 180, cursor:'pointer' },
            itemHoverStyle: {backgroundColor:'#ccc', border:'1px solid white', margin:'0', padding:'3px'}
        });
        $('#basket').removeClass('hidden').show();
    }else{
        // скрыть инструменты редактирования
        $('.tools').hide();
        $('#basket').addClass('hidden');
    }
}

//Реакция на ресайз окна
window.onresize = function (){
    $('#page').css('height',$(window).height()-45);
    $('#tabs_content_block').css('height', $(window).height()-129);
//    tabsWidthDetect();
};

//Меняем продукт
function changeProduct(name){
    window.location = '/' + name;
}

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
        cancelEditNode(location.hash.substr(1));
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

//Открываем вкладку по id вкладки
function openTab(object_id){
    var obj = $('a#'+object_id);
    addBlockForTabContent(object_id);
    addTabNameToManageBlock(obj.html());
    showTabContent(object_id);
    getNodeContent(object_id);
}

//получаем данные по узлу
function getNodeContent(object_id){
    if (object_id.substr(0,2)== 'PR' || object_id.substr(0,2)== 'NE'){
        $.ajax({
            type: "POST",
            url: "/getNodeLessEditable/",
            data: {nodeId: object_id, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                console.log(html, $('#tabs_content_block div.tabs.tab_'+object_id));
                $('#tabs_content_block div.tabs.tab_'+object_id).html(html);
                if (!LOGGED_IN) LoggedIn(false);
            }
        });
    }else{
        $.ajax({
            type: "POST",
            url: "/getNode/",
            data: {nodeId: object_id.split('_')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                $('#tabs_content_block div.tabs.tab_'+object_id).html(html);
                if (!LOGGED_IN) LoggedIn(false);
            }
        });
    }
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
        console.log('Change location :'+ tabId );
        location.hash = tabId.replace('_' + window.location.pathname.substr(1,2), '');
    }
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.tabs.tab_'+tabId).show();
}


//------------------РЕДАКТИРОВАНИЕ УЗЛОВ ДЕРЕВА-----------------------//

//Создаем редакторы из текстовых полей на странице
function makeEditors(tab){
    $("#tabs_content_block div.tabs.tab_" + tab + " textarea.big_text").each(function(n, obj) {
        var editor = CKEDITOR.instances[obj.id];
        if (editor) { editor.destroy(true); }
        CKEDITOR.replace(obj.id,
            {
                filebrowserBrowseUrl : '/ckeditor/browse/',
                filebrowserUploadUrl : '/ckeditor/browse/',

                toolbar :
                    [
                        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                        { name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'
                            ] }, '/',
                        { name: 'styles', items : [ 'Styles','Format' ] },
                        { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
                        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote' ] },
                        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
                        { name: 'tools', items : [ 'Maximize','-','About' ] }
                    ]
            });
    });
    $("#tabs_content_block div.tabs.tab_" + tab + " textarea.small_text").each(function(n, obj) {
        var editor = CKEDITOR.instances[obj.id];
        if (editor) { editor.destroy(true); }
        CKEDITOR.replace(obj.id,
            {
//                skin : 'office2003',
                height : '40',
                toolbar :
                    [
                        { name: 'basicstyles', items : [ 'Bold','Italic' ] },
                        { name: 'links', items : [ 'Link','Unlink','Anchor' ] }
                    ]
            });
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
    console.log(node_id);
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
    console.log(parent_id);
    $('.add_node_form .cover_form').attr('id', parent_id);
    $('.cover_form .confirm.button').attr('id', type);
    $('div.popup').html($('.add_node_form').html());
    if (type == 'OR') {
        console.log(type);
        $('#add_node_name_text').val('Как называется новое требование?');
    }
    showPopup(true);
}

//Создать новый узел
function CreateTie(parent_id, type, name){
    if (name=='Как называется твой новый узел?' || name.trim() == ''){
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
                }, 100);
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
            $('#tabs_content_block div.tabs.tab_' + nodeId).html(html);

            if ($('.table').hasClass('editable')){
                EDITING = true;
                window.setTimeout(function(){
                    makeEditors(nodeId);
                }, 300);
            }
        }
    });
}

//Редактировать папку
function editNodeLessEditable(nodeId){
    console.log(nodeId);
    $.ajax({
        type: "POST",
        url: "/editNodeLessEditable/",
        data: {nodeId: nodeId, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + nodeId).html(html);

            if ($('.table').hasClass('editable')){
                EDITING = true;
                window.setTimeout(function(){
                    makeEditors(nodeId);
                }, 300);
            }
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
    if (release_name == 'Как называется твой релиз?' || release_name.trim() == '' ){
        alert('Извините, но вы не можете создать узел без имени.')
    }else if(release_number == 'Какой номер релиза?' || release_name.trim() == ''){
        alert('Извините, но вы не можете создать релиз без номера.')
    }else if(release_date == 'Год-месяц-день'|| release_date.trim() == ''){
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
                console.log(html);
                if (html.substr(0,7) == '<option'){
                    showPopup(false);
                    $('#selectRelease option').attr('selected', false);
                    $('#selectRelease').append(html);
                }else{
                    $('input#add_release_date_text').addClass('mistake');
                    alert('Введите корректную дату. Формат даты должен быть: год-месяц-день. Например: 2011-08-23.');
                }

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
    console.log(comment);
    $('#'+item+'_comment').text(comment);
    showPopup(false);
}

//Сохранить отредактированый узел и показать его же с новыми данными
function saveNode(nodeId){
    var files = [];
    $('.node_files a').each(function(){
        files.push($(this).attr('id'));
    });
    if ($('#release_comment').val() == 'Оставьте комментарий тут'){ var desc_rel =''}else{
        desc_rel = $('#release_comment').val();
    }
    if ($('#status_comment').val() == 'Оставьте комментарий тут'){ var desc_com =''}else{
        desc_com = $('#status_comment').val();
    }
    $.ajax({
        type: "POST",
        url: "/saveNode/",
        data: {
            nodeId: nodeId,
            title:$('#nodeTitle').val(),
            status:$('#selectStatus').val(),
            status_comment:desc_com,
            release:$('#selectRelease').val(),
            release_comment:desc_rel,
            developer:$('#selectDeveloper').val(),
            tester:$('#selectTester').val(),
            source:$('#selectSource').val(),
            source_desc:CKEDITOR.instances.source_textArea.getData(),
            node_desc:CKEDITOR.instances.content_textArea.getData(),
            files: files,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + nodeId).html(html);
            EDITING = false;
        }
    });
}

//показать форму добавления нового файла
function ShowAddfileForm(){
    $('div.popup').html($('.add_file_form').html());
    showPopup(true);
}

//добавить новый файл к узлу
function SaveFile(){
    $("#loadingFile").submit(
        function(){
            setTimeout(function(){
                $.ajax({
                    type: "POST",
                    url: "/getFiles/",
                    data: {
                        node: $('input#node_id').val(),
                        csrfmiddlewaretoken: '{{ csrf_token }}'
                    },
                    success: function(html){
                        $('.node_files').html(html);
                        showPopup(false);
                    }
                });
            }, 500);
        });
}

//удаление файлов из узла
$('.file span.delete').live('click', function(){
    DeleteFile($(this).attr('id').replace('file_',''))
});
function DeleteFile(file_id){
    $.ajax({
        type: "POST",
        url: "/deleteFile/",
        data: {
            file_id: file_id,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            $('span#file_'+file_id).parent().remove();
            console.log(html);
        }
    });
}

// Посмотреть историю узла
function viewNodeHistory(nodeId){
    $.ajax({
        type: "POST",
        url: "/getNodeHistory/",
        data: {nodeId: nodeId, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + nodeId).html(html);
        }
    });
}

// Открыть корзину
function openTrash(){
    location.hash = 'trash';
    pickNodeInTree($('a.trash'));
    addBlockForTabContent('trash');
    $('#tabs_manage_block ul li.active').html('Корзина');
    $.ajax({
        type: "POST",
        url: "/openTrash/",
        data: {csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs').hide();
            $('#tabs_content_block div.tabs.tab_trash').html(html);
            $('#tabs_content_block div.tabs.tab_trash').show();

        }
    });
}

// При выделении узлов чекбоксами
function checkTrash(){
    if ($('input[type=checkbox]:checked').length > 0){
        $('.panel li.repair').removeClass('disable').addClass('active');
        $('.panel li.repair').attr('onclick','restoreTrash()');
    }else{
        $('.panel li.repair').removeClass('active').addClass('disable');
        $('.panel li.repair').attr('onclick','');
    }
}

// Восстанавливаем выделенное из корзины
function restoreTrash(){
    var nodes = '';
    $('input[type=checkbox]:checked').each(function(){
        nodes += $(this).attr('id').replace('node_', '') + '; ';
    });
    $.ajax({
        type: "POST",
        url: "/restoreTrash/",
        data: {nodes: nodes , csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            if (html == 'ok'){window.location.reload();}
        }
    });
}



