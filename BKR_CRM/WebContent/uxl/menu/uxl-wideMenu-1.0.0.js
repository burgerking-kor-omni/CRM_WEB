/*! 
 * Copyright (c) 2016 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-wideMenu-1.0.0
 * Version 1.0.0
 * Release List
 * 
 * 1.0.0 - 2016-05-02
 *  - WideMenu 초기 개발
 */
uxl.WideMenu = function(target, callback){
	
	target = $(target);

	// 다단에 따른 그리드 조정
	$('.sub-depth-box', target).each(function(){
		var className = 'grid0'+$('.column.depth02', $(this)).size();
		$(this).addClass(className);
	});
	
	// 처음 메뉴 위치 조정
	$('ul.depth01>li:first .sub-depth-box', target).addClass('start-line');

	// 마지막 메뉴 위치 조정
	$('ul.depth01>li:last .sub-depth-box', target).addClass('end-line');
	
	// 2단계메뉴 3단계메뉴가 없을경우 depth-end 클래스 추가
	$('.depth02>ul>li:not(:has(.depth03))', target).addClass('depth-end');
	
	// 메뉴 마우스 이벤트 처리
	$('.wide-menu .t').on('mouseenter', function() {
		$(this).parent().addClass('active').siblings().removeClass('active');
	});
	$('.wide-menu').on('mouseleave', function() {
		$(this).find('li.active').removeClass('active');
	});

	// 메뉴 선택시 처리	
	$('li a', target).bind('click', function(event){
		var menuUrl = $(this).attr('menuUrl');
		if(menuUrl != '') {
			if(uxl.isScreenId(menuUrl)) {
				menuUrl = uxl.getScreenURL(menuUrl);
			}
			menuUrl = uxl.getContextURL(menuUrl);
			menuUrl = uxl.addQueryToUrl(menuUrl, 'menuId', $(this).attr('menuId'));
		}
		
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

	/**
	 * 메뉴 스크롤 셋팅
	 */
	$('.sub-depth-box .sub-depth .column').mCustomScrollbar({
		theme:"minimal-dark"
	});
	
//	$('.sub-depth-box .sub-depth .column').css('max-height', '150px'); widemenu.css에서 직접 컨트롤한다
};
