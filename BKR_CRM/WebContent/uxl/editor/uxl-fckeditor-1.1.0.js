(function($, uxl) {

	uxl.editorOptions = {};
	
	uxl.Editor = function(element, options) {
		
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		
		var initOptions = {
			  customConfig: '/uxl/editor/config/defaultConfig.js'
		};
		
		if('readonly' == $Editor.attr('readOnly')){
			initOptions.readOnly = true;
		}		
		
		initOptions = $.extend(initOptions, options);
		
		CKEDITOR.replace( $Editor.attr('id') , initOptions );
		
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		editor.setData($Editor.text());
		
		return editor;
	};
	
	
	/**
	 * Append Html 
	 */
	uxl.Editor.InsertHTML = function(element ,value){
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		
		if ( editor.mode == 'wysiwyg' )
		{
			editor.insertHtml( value );
			
		} else{
			alert( 'You must be in WYSIWYG mode!' );
		}
	};
	
	uxl.Editor.setReadOnly = function(element ,boleanValue){
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		editor.setReadOnly(boleanValue);	
	};
	
	uxl.Editor.getReadOnly = function(element){
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		return editor.readOnly;
	};
	
	/**
	 * Append Data 
	 */
	uxl.Editor.setData = function(element ,value){
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		editor.setData(value);
	};
	
	/**
	 * Append Html 
	 */
	uxl.Editor.getData = function(element){
		var $Editor = uxl.isString(element)? $('#'+element) : element;
		
		var editor = CKEDITOR.instances[$Editor.attr('id')];
		return editor.getData();
	};
	
	
})(jQuery, uxl);


