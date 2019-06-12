
var timeout         = 500;

var closetimer		= 0;
var subclosetimer	= 0;

var ddmenusubitem;
var wizProject = null;  // 프로젝트 마법사
var ddmenuitem;

/**
 * 
 */
uxl.SimpleMenu = function(selector, callback){
	
	// menu 이벤트 핸들러
	function navtabs_open(){
		$('body iframe').blur();
		navtabs_canceltimer();
		navtabs_close();
		ddmenuitem = $(this).find('>.menu-sub-box').show();
	}

	function navtabs_close(){
		if(ddmenuitem){
			ddmenuitem.hide();
		}
	}

	function navtabs_timer(){
		closetimer = window.setTimeout(navtabs_close, timeout);
	}
	
	function navtabs_canceltimer(){	
		if(closetimer) {
			window.clearTimeout(closetimer);
			closetimer = null;
		}
	}
		
	function navtabs_sub_open(){
		navtabs_sub_all_close();		
		$(this).find('>.menu-sub-box').show();
	}
	
	function navtabs_sub_all_close(){
		$(selector).find(".menu-sub-box .menu-sub-box").hide();
	}

	function navtabs_sub_close(){
		$(this).find('>.menu-sub-box').hide();
	}
	
	function _initialize(selector, callback) {
		
		$(selector+">li").bind('mouseover', navtabs_open);
		$(selector+">li").bind('mouseout', navtabs_timer);
//		$(document).bind('click', navtabs_close);
		
		$(selector+" li li").click(function(){
			if($(this).hasClass("on")){
				$(this).removeClass("on");
				navtabs_sub_close.call(this, event);
			}else{
				$(selector+" .menu-sub-item.on").removeClass("on");
				$(this).addClass("on");
				navtabs_sub_open.call(this, event);
			}
		});
		
		if(uxl.isFunction(callback)){
			$(selector + " li:not(:has(.menu-sub-box)) a").bind('click', function(event){
				var menuUrl = $(this).attr('menuUrl');
				if(menuUrl != '') {
					if(uxl.isScreenId(menuUrl)) {
						menuUrl = uxl.getScreenURL(menuUrl);
					}
					menuUrl = uxl.getContextURL(menuUrl);
					menuUrl = uxl.addQueryToUrl(menuUrl, 'menuId', $(this).attr('menuId'));
					
// 멀티뷰에서 이전검색조건내용이 삭제되는 케이스가 발생함 (싱글뷰에서만 아래 로직이 유효함) : 2015-08-11 따로 정리 필요함 
//					menuUrl = uxl.addQueryToUrl(menuUrl, uxl.CONSTANT.KEY.RECOVERY, uxl.CONSTANT.RECOVERYCOMMAND.CLEAR);
				}
				
				navtabs_sub_close.call(this, event);
				navtabs_close();
				callback.call(this
							, event
							, {
								menuId:$(this).attr('menuId'), 
								menuName:$(this).attr('menuName'), 
								menuUrl:menuUrl,
								menuType:$(this).attr('menuType'), 
								menuWidth:$(this).attr('menuWidth'), 
								menuHeight:$(this).attr('menuHeight'), 
								menuTarget:$(this).attr('menuTarget') 
							});
			});
		}else{
			$(selector + " li:not(:has(.menu-sub-box)) a").bind('click', function() {
				
				if($(this).has('.menu-sub-box')){
					return false;
				}
				
				var url = $(this).attr('menuUrl');
				if(url != '') {
					if(uxl.isScreenId(url)) {
						url = uxl.getScreenURL(url);
					}
					url = uxl.getContextURL(url);
					
//	멀티뷰에서 이전검색조건내용이 삭제되는 케이스가 발생함 (싱글뷰에서만 아래 로직이 유효함) : 2015-08-11 따로 정리 필요함
//					url = uxl.addQueryToUrl(url, uxl.CONSTANT.KEY.RECOVERY, uxl.CONSTANT.RECOVERYCOMMAND.CLEAR);
					
					uxl.moveLocation(uxl.getContextURL(url));
				}
				return false;
			});
		}
	}
	
	$(function(){_initialize(selector, callback);});
	
};
