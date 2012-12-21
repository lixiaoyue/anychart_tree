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
                                items : [ ['--- Select an Exam---',0] ],
                                onLoad : function(element) {
                                    var element_id = '#' + this.getInputElement().$.id;
                                    $.each(getValue(), function(index, item) {
                                        $(element_id).get(0).options[$(element_id).get(0).options.length] = new Option(item[0], item[1]);
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
                            label : 'Термин',
                            validate : CKEDITOR.dialog.validate.notEmpty( "Term field cannot be empty" )
                        },
                        {
                            type : 'textarea',
                            id : 'desc',
                            label : 'Определение',
                            validate : CKEDITOR.dialog.validate.notEmpty( "Explanation field cannot be empty" )
                        }
                    ]
            }
            ],
        onOk : function()
        {
            //TODO: сохранить новый термин в бд и вставить ссылку со всплывающей подсказкой
//            var dialog = this;
//            var abbr = editor.document.createElement( 'abbr' );
//            abbr.setAttribute( 'title', dialog.getValueOf( 'tab2', 'desc' ) );
//            abbr.setText( dialog.getValueOf( 'tab2', 'term' ) );
//            editor.insertElement( abbr );
        }
    };
});

function getValue(){
    //TODO: сделать запрос в бд и сформировать список терминов уже существующих для этого продукта
    return [
        [ 'Слово первое', 1],
        [ 'Слово второе', 2 ],
        [ 'Слово пятьдесят девятое', 3 ]
    ]
}

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