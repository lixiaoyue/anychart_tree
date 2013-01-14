CKEDITOR.plugins.add( 'vocabulary',
    {
        init: function( editor )
        {
            editor.addCommand( 'vocabularyDialog', new CKEDITOR.dialogCommand( 'vocabularyDialog' ) );

            editor.ui.addButton( 'vocabularyButton',
                {
                    label: 'Link to vocabulary',
                    command: 'vocabularyDialog',
                    icon: this.path + 'images/logo.gif'
                } );
        }


    } );
var select_element_id;
CKEDITOR.dialog.add( 'vocabularyDialog', function ( editor )
{
    return {
        title : 'Описание термина',
        minWidth : 400,
        minHeight : 200,
        contents :
            [
                {
                    id : 'tab1',
                    label : 'Выбрать термин',
                    elements :
                        [
                            {
                                type : 'select',
                                id : 'item',
                                items : [ ['Select Term',0] ],
                                onLoad : function(element) {
                                    select_element_id = '#' + this.getInputElement().$.id;
                                    $.ajax({
                                        type: "POST",
                                        url: "/getTerms/",
                                        data: {
                                        product : location.pathname.split('/')[1],
                                        csrfmiddlewaretoken: '{{ csrf_token }}'},
                                        success: function(html){
                                            var list = [];
                                            for (var option in html.split('!#')){
                                                if (html.split('!#')[option] != ''){
                                                    list.push([html.split('!#')[option].split('&#')[0], html.split('!#')[option].split('&#')[1]])
                                                }
                                            }
                                            if (list.length > 0){
                                                $.each(list, function(index, item) {
                                                    $(select_element_id).get(0).options[$(select_element_id).get(0).options.length] = new Option(item[0], item[1]);
                                                });
                                            }
                                        }
                                    });
                                }
                            }
                        ]
                },
                {
                id : 'tab2',
                label : 'Добавить новый термин',
                elements :
                    [
                        {
                            type : 'text',
                            id : 'term',
                            label : 'Термин'
                        },
                        {
                            type : 'textarea',
                            id : 'desc',
                            label : 'Определение'
                        }
                    ]
            }
            ],
        onOk : function()
        {
            //сохранить новый термин в бд и вставить ссылку со всплывающей подсказкой или просто вставить ссылку
            if (this.getValueOf( 'tab2', 'term' ) != '' && this.getValueOf( 'tab2', 'desc' ) != ''){
                var term = this.getValueOf( 'tab2', 'term'),
                    term_desc = this.getValueOf( 'tab2', 'desc' );
                // Отправляем новый термин и описание. возвращаем id сохраненного термина
                $.ajax({
                    type: "POST",
                    url: "/saveTerm/",
                    data: {
                        product : location.pathname.split('/')[1],
                        term_name: term,
                        term_decs: term_desc,
                        csrfmiddlewaretoken: '{{ csrf_token }}'},
                    success: function(term_id){
                        setLink(term_id, term, term_desc);
                        $(select_element_id +' option').eq(1).before($("<option></option>").val(term_id).html(term));
                    }
                });

            }else if (this.getValueOf( 'tab1', 'item' ) != 0){
                var term_id = this.getValueOf( 'tab1', 'item');
                //Отправляем id термина, получаем его описание
                $.ajax({
                    type: "POST",
                    url: "/getTermById/",
                    data: {
                        term_id: term_id,
                        csrfmiddlewaretoken: '{{ csrf_token }}'},
                    success: function(html){
                        setLink(term_id, html.split('#!')[0], html.split('#!')[1]);
                    }
                });
            }else{
                alert('No term chosen or added');
            }

            // Добавить в текст ссылку на термин, вставить скрытое описание
            function setLink(id, title, desc){
                var link = editor.document.createElement( 'a');
                link.setAttribute('id', id);
                var href = '/'+ location.pathname.split('/')[1] + '/dictionary/#' + title.replace(' ', '_');
                link.setAttribute('href', href );
                link.setAttribute('class', 'tip');
                link.setAttribute('target', '_blank');
                link.setHtml(title + '<span class="hidden">&nbsp;</span>');
                editor.insertElement(link);
            }
        }
    };
});

// Add a new option to a SELECT object (combo or list).
function addOption( combo, optionText, optionValue, documentObject, index )
{
    combo = getSelect( combo );
    var oOption;
    if ( documentObject )
        oOption = documentObject.createElement( "OPTION" );
    else
        oOption = document.createElement( "OPTION" );

    if ( combo && oOption && oOption.getName() == 'option' )
    {
        if ( CKEDITOR.env.ie ) {
            if ( !isNaN( parseInt( index, 10) ) )
                combo.$.options.add( oOption.$, index );
            else
                combo.$.options.add( oOption.$ );

            oOption.$.innerHTML = optionText.length > 0 ? optionText : '';
            oOption.$.value     = optionValue;
        }
        else
        {
            if ( index !== null && index < combo.getChildCount() )
                combo.getChild( index < 0 ? 0 : index ).insertBeforeMe( oOption );
            else
                combo.append( oOption );

            oOption.setText( optionText.length > 0 ? optionText : '' );
            oOption.setValue( optionValue );
        }
    }
    else
        return false;

    return oOption;
}
// Remove all selected options from a SELECT object.
function removeSelectedOptions( combo )
{
    combo = getSelect( combo );

    // Save the selected index
    var iSelectedIndex = getSelectedIndex( combo );

    // Remove all selected options.
    for ( var i = combo.getChildren().count() - 1 ; i >= 0 ; i-- )
    {
        if ( combo.getChild( i ).$.selected )
            combo.getChild( i ).remove();
    }

    // Reset the selection based on the original selected index.
    setSelectedIndex( combo, iSelectedIndex );
}
function getSelect( obj )
{
    if ( obj && obj.domId && obj.getInputElement().$ )				// Dialog element.
        return  obj.getInputElement();
    else if ( obj && obj.$ )
        return obj;
    return false;
}