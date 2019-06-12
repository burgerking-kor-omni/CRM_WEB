(function($, uxl) {
	
	/**
	 * @class Context Menu 위젯 클래스<br/>
	 * 
	 * @see uxl-sidemenu-1.0.0.js
	 */
	uxl.ContextMenu = function(id) {
		this.contextMenuId = id;
		
		var container = $('#' + this.contextMenuId ).addClass('contextmenu ui-widget-header');
		
		var contextmenu = $('div:first', container)
		.addClass('contextmenu_menus ui-widget-content')
		.css('z-index', 1)
		.hide();
		
		var button = $('button:first', container)
		.css('padding-left', '4px')
		.toggle(function(event) {
			contextmenu.show()
			.css('top', $(this).position().top + $(this).parent().height())
			.css('left', $(this).position().left);
		}, function() {
			contextmenu.hide();
		}).button({
			icons : {
				primary:'ui-icon-folder-open'
			}
		});

		$('li', contextmenu)
		.addClass('ui-state-defualt')
		.append('<span class="ui-icon ui-icon-newwin"/>')
		.click(function() {
			button.click();
		})
		.hover(function(event) {
			$(this).toggleClass('ui-state-highlight');
		});
		
		this.contextmenu = contextmenu;
	};
	
	uxl.ContextMenu.prototype.select = function(id, selectedCallback) {
		if(uxl.isFunction(selectedCallback)) {
			$('#' + id, this.contextmenu).click(selectedCallback);
		}
		else {
			$('#' + id, this.contextmenu).click();
		}
	};
	
	uxl.ContextMenu.prototype.hide = function(id) {
		$('#' + id, this.contextmenu).hide();
	};
	
	uxl.ContextMenu.prototype.show = function(id) {
		$('#' + id, this.contextmenu).show();
	};

})(jQuery, uxl);