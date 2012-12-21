//------------------ОБЩЕЕ-----------------------//

var LOGGED_IN = false; // если false,  то никто не залогинен
var EDITING = false; // если false, но все можно нажимать, никакой узел не находиться в состоянии редактирования.

var currentNode = {name:'', type:''}; // Имя-идентефикатор текущего открытого узла

/* Идентефикаторы элементов списка в js дереве (li#)
    NE_currentNode - узел - папка
    tie_currentNode - узел - бизнес-требование
    reqs_currentNode - папка с требованиями для узла tie_currentNode
    OR_currentNode - ссылка - требование
    BR_currentNode - ссылка - требование
*/


//выполняем сразу при загрузке страницы:
$(function(){
    //делаем меню красивым
    $('#menu > ul').dropotron({
        mode: 'fade',
        globalOffsetY: 4,
        offsetY: -16
    });
    $('#tabs_content_block').html('');
    //устанавливаем высоту объектов в зависимости от высоты экрана
    $('#page').css('height',$(window).height()-45);
    $('#tabs_content_block').css('height', $(window).height()-129);

    // Проверяем выполнена ли регистрация
    if ($('#login_space a').hasClass('registration') && $('#login_space a').hasClass('curators')) {LoggedIn(true);}
    else{LoggedIn(false);}

/*  Выясняем где мы находимся. Мы можем быть
    1. "/"      - дома, страница инициализации
    "/Product/" - на странице продукта (редактирование и просмотр дерева требований)
    "/Product/catalog" - на странице справочников продукта
    "/Product/statistic" - на странице статистики продукта
*/
    // если это каталог, то выясняем, какой справочник открывать
    if (location.pathname.split('/')[2] == 'catalog'){
        if (location.hash == "#1" || "#2" || "#3" || "#4"){
            changeCatalog(location.hash.substr(1));
        }
    // если это страница статистки
    }else if (location.pathname.split('/')[2] == 'statistic'){
        //TODO: Тут пока никто незнает что делать надо, но делать чего-то надо
    // Если не статистика и не каталог, значит мы в каком-то продукте.
    }else{
        // если hash не пуст. значит нужно открыть какой-то узел или корзину
        if (location.hash.length>2){
            currentNode['name'] = location.pathname.split('/')[1] + location.hash.substr(3);
            // если это корзина, открываем корзину
            if(location.hash.substr(1, 5)=='trash'){
                openTrash();
            // если это (не)функциональное требование, нужно сначала подгрузить все требования для родительского узла в дереве, а затем его открыть
            }else if (location.hash.substr(1, 2)=='OR'){
                $.ajax({
                    type: "POST",
                    url: "/getParentNode/",
                    data: {reqId: currentNode['name'], csrfmiddlewaretoken: '{{ csrf_token }}'},
                    success: function(parentId){
                        //получили parentId - id родительского узла для требования
                        $('body').queue(function () {
                            //раскрываем дерево до родительского узла
                            openTree('BR_' + parentId);
                        });
                        $('body').queue(function () {
                            //раскрываем дерево требования родительского узла
                            openTree('reqs_' + parentId);
                            //открываем требование
                            openTab('OR_' + currentNode['name']);
                            //выделяем открытое требование подсветкой
                            pickNodeInTree($('#OR_' + currentNode['name']));
                            $('body').dequeue();
                        });
                    }
                });
            // если это бизнес-требование,или папка или описание продукта, то просто открываем его для просмотра, location.hash.substr(1, 3) - укажет нам тип (остались: BR, NE или PR)
            }else{
                $('body').queue(function () {
                    //раскрываем дерево до нужного узла
                    openTree(location.hash.substr(1, 2) + '_' + currentNode['name']);
                    //открываем требование
                    openTab(location.hash.substr(1, 2) + '_' + currentNode['name']);
                    //выделяем открытое требование подсветкой
                    pickNodeInTree($('a#'+location.hash.substr(1, 2) + '_' + currentNode['name']));
                    $('body').dequeue();
                });
            }
        }
    }
});

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
                showCreateTieForm( tie_id, 'BR');},
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
        $('.tools_up').hide();
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
    $('input#product_'+ name).attr('checked', true);
    var st = 'http://'+ window.location.host +'/' + name +'/';
    window.location.href = st;
}

//Показать или сткрыть всплывающее окно
function showPopup(bool){
    if(bool){
        $('div.popup, .shadow').show();
    }else{
        $('div.popup').html('');
        $('div.popup, .shadow').hide();
    }
}


//------------------РАСКРЫТИЕ ДЕРЕВА-----------------------//

//Развернуть дерево до нужного узла
function openTree(tab_id){
    if ($('li#'+tab_id).hasClass('req')){
        var liId = tab_id;
        $('li#'+tab_id).removeClass('noReqs');
        $('li#'+tab_id + ' div:first p a.sc').removeClass('close_req').addClass('open_req');
    }else{
        liId = $('#'+tab_id).parent().parent().parent().parent().attr('id');
        pickNodeInTree($('#'+tab_id));
    }
    do
    {
        if ($('li#'+liId).hasClass('cl')){
            $('li#'+liId).removeClass('cl');
            $('li#'+liId + ' div:first p a.sc').removeClass('close_tie').addClass('open_tie');
            pasteRequirements(liId);
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
        if ($('li#' + liId + ' ul li.req ul').html() == '')pasteRequirements(liId);
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
    if (!$('li#' + liId).hasClass('req')){
        $.ajax({
            type: "POST",
            url: "/getRequirements/",
            data: {liId: liId, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                if (html == ''){
                    $('li#' + liId.replace('tie_', 'reqs_')).addClass('noReqs');
                    $('body').dequeue();
                }else{
                    $('li#' + liId.replace('tie_', 'reqs_')).removeClass('noReqs');
                    $('li#' + liId.replace('tie_', 'reqs_') + ' ul').html(html);
                    $('body').dequeue();
                }
            }
        });
    }

}

//Открываем узел при клике по дереву ()
$('a.open_tab.reqs, a.open_tie_in_tab').live('click', function(){
    //если открытая вкладка находится в режиме редактирования
    if (EDITING){
        if (confirm('Несохраненные данные будут потеряны, вы уверены, что хотите покинуть требование?')) {
            // Отменеем режим редактирования, все несохраненные данные потеряны
            cancelEditNode(location.hash.substr(1, 2) + '_' + window.location.pathname.substr(1,2) + location.hash.substr(3));
            // отрываем новый узел
            openTab($(this).attr('id'));
            // Выделяем его в дереве
            pickNodeInTree($(this));
        }
        // если не хотим потерять несохраненные данные ничего не делаем
    }else{
        openTab($(this).attr('id'));
        pickNodeInTree($(this));
    }


});

//Выделить открытый узел в дереве
function pickNodeInTree(a_object){
    $('.treeview p').removeClass('active');
    a_object.parent('p').addClass('active');
    a_object.parent().parent('p').addClass('active');
}

//------------------ОТКРЫТИЕ ВКЛАДОК ДЕРЕВА-----------------------//

//Открываем вкладку по id вкладки
function openTab(object_id){
    var obj = $('a#'+object_id);
    //добавляем блок для содержимого вкладки
    addBlockForTabContent(object_id);
    //добавляем название вкладки
    addTabNameToManageBlock(obj.html());
    //Показать контейнер для содержимого вкладки
    showTabContent(object_id);
    //Получает содержимое и записывает в контейнер
    getNodeContent(object_id);
}

//Добавляем блок для содержимого вкладки
function addBlockForTabContent(block_id){
    if ($('.tabs.tab_'+block_id).length <=0){
        $('#tabs_content_block').append('<div class="tabs tab_'+block_id+'"> </div>');
    }

}

//Добавляем название вкладки
function addTabNameToManageBlock(tab_name){
    $('#tabs_manage_block ul li.active').html(tab_name);
    $('#tabs_manage_block li.active span').remove();
}

//Показать контейнер для содержимого вкладки
function showTabContent(tabId){
    if (tabId != undefined){
        location.hash = tabId.replace('_' + location.pathname.split('/')[1], '');
    }
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.tabs.tab_'+tabId).show();
}

//Получает содержимое узла, или папки, или описание продукта и записывает в контейнер
function getNodeContent(object_id){
    if (object_id.substr(0,2)== 'PR' || object_id.substr(0,2)== 'NE'){
        $.ajax({
            type: "POST",
            url: "/getNodeLessEditable/",
            data: {nodeId: object_id, csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
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
                getFiles(currentNode['name']);
            }
        });
    }
}


//------------------УДАЛЕНИЕ УЗЛОВ ДЕРЕВА-----------------------//

//Всплывающая форма "Вы действительно хотите удалить узел?"
function showDeleteNodePopup(node_id){
    $('.deletion_form .cover_form').attr('id', node_id);
    $('div.popup').html($('.deletion_form').html());
    showPopup(true);
}

//Удалить узел
function DeleteNode(node_id, comment){
    console.log('Удаляем узел: ', node_id, comment);
    if (comment=='Оставьте комметарий'){comment=''}
    $.ajax({
        type: "POST",
        url: "/deleteNode/",
        data: {node: currentNode['name'], comment:comment, csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(href){
            showPopup(false);
            window.location.href = href;
            window.location.reload();
        }
    });
}

//------------------СОЗДАНИЕ УЗЛОВ ДЕРЕВА-----------------------//

//Показать всплывающую форму "Создать новый узел"
function showCreateTieForm(parent_id, type){
    $('.add_node_form .cover_form').attr('id', parent_id);
    $('.cover_form .confirm').attr('id', type);
    $('div.popup').html($('.add_node_form').html());
    if (type == 'OR') {
        $('#add_node_name_text').val('Как называется новое требование?');
    }else if (type == 'NE'){
        $('#add_node_name_text').val('Как называется новая папка?');
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
            data: {parent:parent_id, type:type, name:name, product:$('input[name=product]:checked').val(), csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(href){
                showPopup(false);

                window.location.href = href;
                window.setTimeout(function(){
                    window.location.reload();
                }, 100);
            }
        });
    }
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
                extraPlugins : 'vocabulary',
                toolbar :
                    [
                        { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                        { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt' ] },
                        { name: 'insert', items : [ 'vocabularyButton', 'Table','HorizontalRule','Smiley','SpecialChar','PageBreak'] }, '/',
                        { name: 'styles', items : [ 'Styles','Format' ]},
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
                extraPlugins : 'vocabulary',
                toolbar :
                    [
                        { name: 'basicstyles', items : ['vocabularyButton', 'Bold','Italic' ] },
                        { name: 'links', items : [ 'Link','Unlink','Anchor' ] }
                    ]
            });
    });
}

//При клике на форму для комментария удаляем вспомогательный текст
$('#deletion_comment, #release_description, #change_description').live('click', function(){
    if ( $(this).text() == 'Оставьте комметарий' || $(this).text() == 'Оставьте описание релиза тут' || $(this).text() == 'Оставьте комментарий тут'){
        $(this).text('');
    }
});

//При клике на форму для комментария удаляем вспомогательный текст
$('#add_node_name_text, #add_file_name_text, #add_release_name_text, #add_release_number_text, #add_release_date_text').live('click', function(){
    if ( $(this).val() == 'Как называется новое требование?' || $(this).val() == 'Как называется твой новый файл?'|| $(this).val() == 'Как называется твой новый узел?' || $(this).val() == 'Как называется новая папка?' || $(this).val() == 'Как называется твой релиз?' || $(this).val() == 'Какой номер релиза?' || $(this).val() == 'Год-месяц-день' || $(this).val() == 'Как называется новый релиз?'){
        $(this).val('');
    }

});

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
                    getFiles(currentNode['name']);
                }, 300);
            }
        }
    });
}

//Редактировать папку
function editNodeLessEditable(nodeId){
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

//показать форму добавления нового релиза
function ShowAddReleaseForm(){
    $('div.popup').html($('.add_release_form').html());
    showPopup(true);
}

//Добавление нового релиза
function addRelease(){
//    var product = $('input#product:checked').val();
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
//        console.log(location.pathname.split('/')[1], release_date, release_name, release_description, release_number);
        $.ajax({
            type: "POST",
            url: "/addReleaseToNode/",
            data: {
                product:location.pathname.split('/')[1],
                name:release_name,
                number:release_number,
                date:release_date,
                description:release_description,
                csrfmiddlewaretoken: '{{ csrf_token }}'
            },
            success: function(html){
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
    if ($('#selectStatus').val() == undefined  && $('#selectDeveloper').val() == undefined  && $('#selectTester').val()== undefined && $('#selectSource').val() == undefined && $('#selectRelease').val() == undefined){
       var data = {
           nodeId: nodeId,
           title:$('#nodeTitle').val(),
           status:'None',
           status_comment:desc_com,
           release:'None',
           release_comment:desc_rel,
           developer:'None',
           tester:'None',
           source:'None',
           source_desc: 'None',
           node_desc:CKEDITOR.instances.content_textArea.getData(),
           files: files,
           csrfmiddlewaretoken: '{{ csrf_token }}'
       };
    }else{
        data = {
            nodeId: nodeId,
            title:$('#nodeTitle').val(),
            status:$('#selectStatus').val(),
            status_comment:desc_com,
            release:$('#selectRelease').val(),
            release_comment:desc_rel,
            developer:$('#selectDeveloper').val(),
            tester:$('#selectTester').val(),
            source:$('#selectSource').val(),
            source_desc: CKEDITOR.instances.source_textArea.getData(),
            node_desc:CKEDITOR.instances.content_textArea.getData(),
            files: files,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        }
    }
    $.ajax({
        type: "POST",
        url: "/saveNode/",
        data: data,
        success: function(html){
            $('#tabs_content_block div.tabs.tab_' + nodeId).html(html);
            getFiles(currentNode['name']);
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
    $("#loadingFile").submit(function(){
            setTimeout(function(){
                getFiles($('input#node_id').val());
            }, 500);
        });
}

//Получить все файлы, сохраненные для этого узла
function getFiles(node_id){
    $.ajax({
        type: "POST",
        url: "/getFiles/",
        data: {
            node: node_id,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            $('.node_files').html(html);
            showPopup(false);
        }
    });
}

//удаление файлов из узла
function DeleteFile(path){
    $.ajax({
        type: "POST",
        url: "/deleteFile/",
        data: {
            file_path: path,
            csrfmiddlewaretoken: '{{ csrf_token }}'
        },
        success: function(html){
            getFiles($('input#node_id').val());
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

//TODO:При смене адреса выйти из режима редактирования.
window.onbeforeunload = function() {
    if (EDITING) {
        console.log('Отмена редактирования узла ' +location.hash.substr(1, 2) + '_' + window.location.pathname.substr(1,2) + location.hash.substr(3));
        cancelEditNode(location.hash.substr(1, 2) + '_' + window.location.pathname.substr(1,2) + location.hash.substr(3));
        EDITING = false;
    }
};

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

//------------------КОРЗИНА-----------------------//

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

// При выделении узлов чекбоксами в корзине
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


//------------------Справочники-----------------------//
function openCatalog(adress, id){
    $.ajax({
        type: "POST",
        url: adress,
        data: {product:location.pathname.split('/')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_cat_' + id).html(html);
            if (id == '1') { checkColors(); openPicker(); }
        }
    });
}

function checkColors(){
    $('input.statusCatalog').each(function (){
        if ($(this).val()==''){
            $(this).val($(this).attr('rel'));
            $(this).parent().append($(this).attr('rel'));
        }
    });
}
function changeCatalog(cat_id){
    location.hash = cat_id;
    pickNodeInTree($('a#cat_'+cat_id));
    addBlockForTabContent('cat_' + cat_id);
    addTabNameToManageBlock($('a#cat_'+cat_id).html());
    $('#tabs_content_block div.tabs').hide();
    $('#tabs_content_block div.tabs.tab_cat_'+cat_id).show();
    if (cat_id == 1){
        openCatalog("/getStatusCatalog/", cat_id);
    }else if (cat_id == 2){
        openCatalog("/getSourceCatalog/", cat_id);
    }else if(cat_id == 3){
        openCatalog("/getReleaseCatalog/", cat_id)
    }else if(cat_id == 4){
        openCatalog("/getUsersCatalog/", cat_id)
    }
}

//COLOR PICKER
function openPicker(){
    var f = $.farbtastic('#picker');
    var p = $('#picker').css('opacity', 0.25);
    var selected;
    $('.statusCatalog')
        .each(function () { f.linkTo(this); $(this).css('opacity', 0.75); })
        .focus(function() {
            if (selected) {
                $(selected).css('opacity', 0.75);
            }
            f.linkTo(this);
            p.css('opacity', 1);
            $(selected = this).css('opacity', 1);
        });


}

//Сохранить цвета для статусов
function saveStatusesColors(){
    var st = "";
    $('input.statusCatalog').each(function(){st += $(this).val() + '; '});
    $.ajax({
        type: "POST",
        url: "/saveStatuses/",
        data: {colors: st, product:location.pathname.split('/')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
        success: function(html){
            $('#tabs_content_block div.tabs.tab_cat_1').html(html);
            openPicker();
        }
    });
}

//Добавить источник
function addSource(){
    if ($('#new_source').val() == ''){
        alert('Вы не можете добавить источник без названия.');
    }else{
        $.ajax({
            type: "POST",
            url: "/addSourceCatalog/",
            data: {name: $('#new_source').val(), product:location.pathname.split('/')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                $('#tabs_content_block div.tabs.tab_cat_2').html(html);

            }
        });
    }
}

//Удалить источник
function deleteSource(id){
    if (confirm('Вы уверены, что хотите удалить источник?')){
        $.ajax({
            type: "POST",
            url: "/deleteSourceCatalog/",
            data: {id: id, product:location.pathname.split('/')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                $('#tabs_content_block div.tabs.tab_cat_2').html(html);
            }
        });
    }
}

//Удалить релиз
function deleteRelease(id){
    if (confirm('Вы уверены, что хотите удалить источник?')){
        $.ajax({
            type: "POST",
            url: "/deleteReleaseCatalog/",
            data: {id: id, product:location.pathname.split('/')[1], csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                $('#tabs_content_block div.tabs.tab_cat_3').html(html);
            }
        });
    }
}

//Редактировать релиз
function editRelease(id){
    $('.wideItem.underline.'+ id).html($('.wideItem.hidden.'+ id).html());
}

//Сохранить изменения в Релизе
function saveRelease(id){
    var status;
    if ($('input[name=status_'+id+']').attr('checked')){status=true}else{status=false}
    if ($('input[name=name_'+id+']').val() =='' || $('input[name=number_'+id+']').val()=='' ||  $('input[name=date_'+id+']').val()==''){
        alert ('Поля: название, номер и дата выхода релиза обязательны для заполнения');
    }else{
        $.ajax({
            type: "POST",
            url: "/saveReleaseCatalog/",
            data: {
                id: id,
                name: $('input[name=name_'+id+']').val(),
                number: $('input[name=number_'+id+']').val(),
                date: $('input[name=date_'+id+']').val(),
                status: status,
                description:$('textarea[name=description_'+id+']').val(),
                product:location.pathname.split('/')[1],
                csrfmiddlewaretoken: '{{ csrf_token }}'},
            success: function(html){
                $('#tabs_content_block div.tabs.tab_cat_3').html(html);
            }
        });
    }
}