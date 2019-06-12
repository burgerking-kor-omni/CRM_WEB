/*! 
 * Copyright (c) 2016 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-sideMenu-1.0.0
 * Version 1.0.0
 * Release List
 * 
 * 1.0.0 - 2017-03-30
 *  - sideMenu 초기 개발
 */

/**
 * TopMenu의 정보를 기반으로 subMenu를 만들어줍니다. 
 * @param {String} 실제 subMenu가 생성 될 대상
 * @param {String} option 정의 (현재는 접힘 펼침(ToggleBtn에 대한 옵션만 존재)
 * @param {Function} callback 함수 (미정의)
 */
uxl.sideMenu = function(target, option, callback){
	
	 var $target = $(target); // 실제 subMenu가 생성 될 대상
	 
	 //TopMenu 조회 - 두개의 Top메뉴가 존재하지 않음. (사용가능한 메뉴만 추가로 정의한다.)
	 var $topMenu = $('.ub-layout.menu.wide-menu, .ub-layout.menu.simple');
	 
	 var $activeTopMenu = null; // 선택한 Top영역의 메뉴ID
	 
	 var activeMenuId = null; // 선택한 메뉴ID
	 
	 var lastActiveMenuId = null; // 최근 선택한 메뉴ID
	 
	 var $sideFrame = $('div.ub-frame.middle'); //subMenu 추가될  frame div영역
	 
	 var options = {
			 isLargeMenu : uxl.isUndefined(option.isLargeMenu) ? true : option.isLargeMenu
	 };
	 
	 //SubMenu 로딩시 TopMenu의 클릭 이벤트 바인딩 을 하여, 탭메뉴의 종속성을 제거하기 위함.
	 $topMenu.bind('click', function(event){ //메뉴 영역 클릭시 이벤트 바인딩
		 
		$activeTopMenu = $('li.active', $topMenu); // TopMenu영역중 현재 active상태의 노드 정보
		activeMenuId = $activeTopMenu.children('a').attr('menuid');
		
		//마지막에 선택했던 MenuId와 현재 active한MenuId가 다르고 activeMenuId가 undefined값이 아닐때
		//TopMenu영역을 드래그 한 상태에서 클릭할 때 activeMenuId값이 undefined나옴 
		if(lastActiveMenuId != activeMenuId  && !uxl.isUndefined(activeMenuId)){
			
			$target.empty();//subMenu 그리기 전 기존에 그려진 subMenu초기화
			lastActiveMenuId = activeMenuId;
			fnMakeSideLargeMenu($target, $(this)); //대메뉴 그리기
			init(); // 초기세팅
			fnClickSideMenu(); //클릭이벤트
	     	$('.ub-layout.menu.lnb').mCustomScrollbar({ // subMenu 스크롤
	    		theme:"minimal-dark"
	    	});
		}
		
	 });
	 
	
	 /**
	  * 대 메뉴 그리기
	  * @param {document} 대상 메뉴
	  * @param {document} 탑 메뉴
	  * */
	 function fnMakeSideLargeMenu($target, $source){
    	
		 var selectedMenu = $('li.active', $source); // subMenu에서 마우스오버된 메뉴까지 접근
         var menuName = selectedMenu.find('a').attr('menuname'); // 대메뉴 명
       
         var html = '<div class="ub-layout snb-wrap">'
        	 	  + ' <div class="ub-layout menu-wrap">'
        	 	  + '  <div class="ub-layout menu snb">'
    	 if(options.isLargeMenu){
    	   	 html = html  + '    <div class="tit-wrap">'
		                  + '      <h2 class="ub-control title">'+menuName+'</h2>'
		                  + '    </div>' 
         }
         	 html = html  + '    <nav class="side-nav">'
		                  + '      <ul>'
		                  + '      </ul>'
		                  + '    </nav>'
		                  + '  </div>'
		                  + ' </div>';
         	 			  + '</div>';
       
          $target.append(html); // side-menu div영역에 대메뉴 영역 append
          
          $target2depth = $('.side-nav>ul', $target);  
          
          fnMakeSubMediumMenu($target2depth, selectedMenu); //중메뉴 append함수
    }            

     /** 
      * 중 메뉴 그리기 
      * @param {document} 대상 메뉴
      * @param {document} 선택된 대매뉴
      * */
     function fnMakeSubMediumMenu($target, $source){
     
    	 var menuList = $source.find('.depth02 ul li').filter(function(index){return $(this).closest('.depth03').length == 0}); // 2depth에 해당하는 메뉴 리스트
     	 var html = "";
     
     	 $(menuList).each(function(index){
     		 
     		 var $this = $(this);
     	     var $topMenu = $('a', this);
     	     
             var menuId = $topMenu.attr("menuid"); // 메뉴ID
             var menuUrl = $topMenu.attr("menuurl"); // URL
             var menuType = $topMenu.attr("menutype"); // 메뉴 타입(링크, 팝업....)
             var menuHeight = $topMenu.attr("menuheight"); // 팝업타입시 창 높이
             var menuWidth = $topMenu.attr("menuwidth"); // 팝업타입시 창 너비
             var menuName = $topMenu.attr("menuname"); // 메뉴명
              
             html = '<li><a menuId="'+menuId+'" menuUrl="'+menuUrl+'" menuName="'+menuName+'" menuType="'+menuType+'" menuHeight="'+menuHeight+'" menuWidth="'+menuWidth+'"><strong>'
                  +menuName+'</strong></a><ul></ul></li>';
     
             var $newMenu = $(html);
             $target.append($newMenu);
     
             if(menuUrl!=""){ //해당 메뉴에 URL이 존재 할 때 클릭이벤트 실행
             	
            	$newMenu.click(function(){
                 	// Mouse Out시 Active 클래스가 삭제되므로, Click시에 강제로 Active 클래스를 추가한다.
                 	$activeTopMenu.removeClass('active').addClass('active');
                 	$topMenu.click();
                 	//정상적으로 click이벤트를 발생시킨뒤 topMenu영역의 li클래스에 active값을 제거한다.
                 	$activeTopMenu.removeClass('active');
                });
          }
              
              fnMakeSubSmallMenu($('ul', $newMenu), $this); // 소메뉴 영역 append함수
     	});
     }
       
    /** 
     * 소 메뉴 그리기
     * @param {document} 대상 메뉴
     * @param {document} 중 메뉴
     * */
     function fnMakeSubSmallMenu($target, $source){
       
    	 var menuList = $('.depth03 ul li', $source); // 3depth에 해당하는 메뉴 리스트
    	 var html = "";
       
    	 $(menuList).each(function(index){
    	   
    		 var $this = $(this); 
    		 var $topMenu = $('a', this); 
             
    		 var menuId = $topMenu.attr("menuid"); // 메뉴ID
    		 var menuUrl = $topMenu.attr("menuurl"); // URL
    		 var menuName = $topMenu.attr("menuname"); // 메뉴 타입(링크, 팝업....)
    		 var menuType = $topMenu.attr("menutype"); // 팝업타입시 창 높이
    		 var menuHeight = $topMenu.attr("menuheight"); // 팝업타입시 창 너비
    		 var menuWidth = $topMenu.attr("menuwidth"); // 메뉴명
               
             html = '<li><a menuId="'+menuId+'" menuUrl="'+menuUrl+'" menuName="'+menuName+'" menuType="'+menuType+'" menuHeight="'+menuHeight+'" menuWidth="'+menuWidth+'"><strong>'
                  +menuName+'</strong></a></li>';
             
             var $newMenu = $(html);
             $target.append($newMenu);
             
             if(menuUrl!=""){ //해당 메뉴에 URL이 존재 할 때 클릭이벤트 실행
            	
            	 $newMenu.click(function(event){
                	 // Mouse Out시 Active 클래스가 삭제되므로, Click시에 강제로 Active 클래스를 추가한다.
            		 $activeTopMenu.removeClass('active').addClass('active');
                	 $topMenu.click();
               	 	 //정상적으로 click이벤트를 발생시킨뒤 topMenu영역의 li클래스에 active값을 제거한다.
                	 $activeTopMenu.removeClass('active');
                });
             }
            
        });
    	
    	if(menuList.size() == 0){ //소메뉴가 없을 때 해당 <ul>태그 영역 삭제
    		$target.remove();
    	}
     }
 	 	
 	 /* 
 	  * SubMenu show, hide 함수
 	  * */
 	 function fnClickSideMenu(){
 	 	
 	 	 $('.side-nav > ul > li:has(ul li)').addClass("has-sub"); // 하위메뉴가 존재 할 때 has-sub클래스 추가
	 	 
 	 	 $('.side-nav > ul > li > a').click(function() { // 중메뉴 
	 	 	
	 	 	 var checkElement = $(this).next();
	 	 	 	
	 	 	 $('.side-nav li').removeClass('active'); //side-nav li영역 active클래스 삭제
	 	 	 $(this).closest('li').addClass('active'); //side-nav li영역 active클래스 추가	
	 	 	 	
	 	 	 	
	 	 	 if((checkElement.is('ul')) && (checkElement.is(':visible'))) { // 하위 메뉴 hide
	 	 	 $(this).closest('li').removeClass('active');
	 	 	 checkElement.slideUp('normal');
	 	 	 }
	 	 	 	
	 	  	 if((checkElement.is('ul')) && (!checkElement.is(':visible'))) { //하위 메뉴 show
	 	 	 $('.side-nav ul ul:visible').slideUp('normal');
	 	 	 checkElement.slideDown('normal');
	 	  	 } 
	 			
	 	}); 

 	 }
 
 	 /*
 	  * TopMenu가 SimpleMenu일때 마우스 이벤트 처리
 	  */
	 $('.simple li').on('click', function() { // 메뉴li 클릭시 active클래스 추가
		 $(this).addClass('active').siblings().removeClass('active');
	 });
	 $('.simple').on('mouseleave', function() { // 메뉴영역에서 마우스 포커스 아웃시 active클래스 삭제
	 	 $(this).find('li.active').removeClass('active');
	 });
	 /*
 	  * TopMenu가 SimpleMenu일때 depthClass 추가( ex) depth01, depth02, depth03 ) => wideMenu기준으로 맞췄다(수정 예저 
 	  */
	 $('.simple').find('ul.ub-control.menu.dropdown').addClass('depth01');
	 $('.simple').find('ul.ub-control.menu.dropdown').find('div.menu-sub-box').addClass('depth02');
	 $('.simple').find('ul.ub-control.menu.dropdown').find('li.menu-sub-item').find('div.menu-sub-box').addClass('depth03');
	
	 /*초기 세팅 함수*/
	 function init(){
		 
		 if(!$sideFrame.children().hasClass('toggle-btn')){
			 /*처음 로딩 시 좌측영역show 그 이후 제어는 POR파일에서 제어*/
			 $sideFrame.addClass('show-side'); 
		 }
	 }
	 
};




































