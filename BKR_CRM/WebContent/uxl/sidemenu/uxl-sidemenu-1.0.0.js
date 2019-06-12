(function($, uxl) {
	
	/**
	 * @class Side Menu 위젯 클래스<br/>
	 * 
	 * @see uxl-sidemenu-1.0.0.js
	 */
	uxl.SideMenu = function(id) {
		this.sideMenuId = id;
		this.menu = $('#' + this.sideMenuId).addClass('sidemenu ui-widget-content');
		
		var clicked = null;
		$('li', this.menu)
		.addClass('ui-state-default ui-corner-all')
		.append('<span class="ui-icon ui-icon-triangle-1-e"/>')
		.hover(function(event) {
			$(this).toggleClass('ui-state-hover');
		})
		.click(function(event) {
			if(clicked !=null) {
				$('.ui-icon', clicked).remove();
				$(clicked).removeClass('ui-state-active').append('<span class="ui-icon ui-icon-triangle-1-e"/>');
			}
			$('.ui-icon', this).remove();
			$(this).addClass('ui-state-active').append('<span class="ui-icon ui-icon-triangle-1-s"/>');
			clicked = this;
		});
	};
	
	uxl.SideMenu.prototype.select = function(id, selectedCallback, selectOnBinded) {
		if(uxl.isFunction(selectedCallback)) {
			$('#' + id, this.menu).click(selectedCallback);
			if(selectOnBinded) {
				$('#' + id, this.menu).click();
			}
		}
		else {
			$('#' + id, this.menu).click();
		}
	};
	
	uxl.SideMenu.prototype.hide = function(id) {
		$('#' + id, this.menu).hide();
	};
	
	uxl.SideMenu.prototype.show = function(id) {
		$('#' + id, this.menu).show('fast');
	};

})(jQuery, uxl);