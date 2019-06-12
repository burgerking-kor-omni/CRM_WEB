/*! 
 * Copyright (c) 2016 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-leftMenu-1.0.0
 * Version 1.0.0
 * Release List
 * 
 * 1.0.0 - 2016-10-29
 *  - LeftMenu 초기 개발
 */

/**
 * TopMenu의 정보를 기반으로 LeftMenu를 만들어줍니다. 
 * @param {String} 실제 leftMenu가 생성 될 대상
 * @param {String} option 정의 (현재는 접힘 펼침(ToggleBtn에 대한 옵션만 존재)
 * @param {Function} callback 함수 (미정의)
 * ex)
 * 		var option = {
 * 				isToggleMode : true // 접힘 펼침(ToggleBtn) 사용
 * 		} 
 * 		uxl.leftMenu($(".ub-frame.left"), option, function(event, item){});
 * 
 */
uxl.leftMenu = function(target, option, callback){
	
	 var $target = $(target); // 실제 leftMenu가 생성 될 대상
	 
	 //TopMenu 조회 - 두개의 Top메뉴가 존재하지 않음. (사용가능한 메뉴만 추가로 정의한다.)
	 var $topMenu = $('.ub-layout.menu.wide-menu, .ub-layout.menu.simple');
	 
	 var $activeTopMenu = null; // 선택한 Top영역의 메뉴ID
	 
	 var activeMenuId = null; // 선택한 메뉴ID
	 
	 var lastActiveMenuId = null; // 최근 선택한 메뉴ID
	 
	 var $leftFrame = $('div.ub-frame.middle'); //LeftMenu 추가될  frame div영역
	 
	 var options = {
			 isToggleMode : uxl.isUndefined(option.isToggleMode) ? false : option.isToggleMode
	 };
	 
	 
	 //LeftMenu 로딩시 TopMenu의 클릭 이벤트 바인딩 을 하여, 탭메뉴의 종속성을 제거하기 위함.
	 $topMenu.bind('click', function(event){ //메뉴 영역 클릭시 이벤트 바인딩
		 
		$activeTopMenu = $('li.active', $topMenu); // TopMenu영역중 현재 active상태의 노드 정보
		activeMenuId = $activeTopMenu.children('a').attr('menuid');
		
		//마지막에 선택했던 MenuId와 현재 active한MenuId가 다르고 activeMenuId가 undefined값이 아닐때
		//TopMenu영역을 드래그 한 상태에서 클릭할 때 activeMenuId값이 undefined나옴 
		if(lastActiveMenuId != activeMenuId  && !uxl.isUndefined(activeMenuId)){
			
			$target.empty();//leftMenu 그리기 전 기존에 그려진 leftMenu초기화
			lastActiveMenuId = activeMenuId;
			fnMakeLeftLargeMenu($target, $(this)); //대메뉴 그리기
			fnClickLeftMenu(); //클릭이벤트
			
	     	$('.ub-layout.menu.lnb').mCustomScrollbar({ // leftMenu 스크롤
	    		theme:"minimal-dark"
	    	});
	     	
	     	if(options.isToggleMode==true){
	     		
	     		fnMakeToggleBtn(); // 접힘 펼침 버튼 생성
	     	}else{
	     		$leftFrame.addClass('show-left');
	     	}
		}
		
	 });
	 	 

	 /**
	  *leftMenu 접힘 펼침 btn 생성 함수
	  *
	  *접힘펼침 버튼은 togle-btn클래스 아래노드의 a태그의 backgroud속성으로 css에서 조절 
	  * */
	 function fnMakeToggleBtn(){
		
		 var $toggleFrame = $('div.ub-frame.middle > div.toggle-btn'); // toggle버튼 div영역
		 $toggleFrame.remove(); // toggle버튼을 그리기 전 기존에 그려져있던 버튼 영역을 초기화 시킨다
		
		 var html =   '<div class="toggle-btn">'
			  		 +' <a href="#none">'
			 		 +   '<strong></strong>'
					 +' </a>'
					 +'</div>';			
					
		 $leftFrame.append(html);
		
		 var $toggleBtn = $('.toggle-btn'); // 접힘 펼침 BtnId
		 
		 $toggleBtn.bind('click', function(event){ // 접힘 펼침 버튼 글릭시 이벤트
				
			var showHide = $leftFrame.hasClass('show-left'); //middle영역에 show-left클래스 존재 여부로 leftMenu 접힘 펼침
			    
		    if(showHide){ // ub-frame middle클래스에 show-left 클래스가 존재하면 제거, 아니면 추가
		    	$leftFrame.removeClass('show-left');         
		    }else{
		        $leftFrame.addClass('show-left');
		    }
				
		});
	 }
	
	 /**
	  * 대 메뉴 그리기
	  * @param {document} 대상 메뉴
	  * @param {document} 탑 메뉴
	  * */
	 function fnMakeLeftLargeMenu($target, $source){
    	
		 var selectedMenu = $('li.active', $source); // left menu에서 마우스오버된 메뉴까지 접근
         var menuName = selectedMenu.find('a').attr('menuname'); // 대메뉴 명
       
         var html = '<div class="ub-layout lnb-wrap">'
    	   		  + '  <div class="ub-layout menu lnb">'
                  + '    <div class="tit-wrap">'
                  + '      <h2 class="ub-control title">'+menuName+'</h2>'
                  + '    </div>'
                  + '    <nav class="left-nav">'
                  + '      <ul>'
                  + '      </ul>'
                  + '    </nav>'
                  + '  </div>'
                  + '</div>';
       
          $target.append(html); // left-menu div영역에 대메뉴 영역 append
          
          $target2depth = $('.left-nav>ul', $target);  
          
          fnMakeLeftMediumMenu($target2depth, selectedMenu); //중메뉴 append함수
    }            

     /** 
      * 중 메뉴 그리기 
      * @param {document} 대상 메뉴
      * @param {document} 선택된 대매뉴
      * */
     function fnMakeLeftMediumMenu($target, $source){
     
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
              
              fnMakeLeftSmallMenu($('ul', $newMenu), $this); // 소메뉴 영역 append함수
     	});
     }
       
    /** 
     * 소 메뉴 그리기
     * @param {document} 대상 메뉴
     * @param {document} 중 메뉴
     * */
     function fnMakeLeftSmallMenu($target, $source){
       
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
 	  * LeftMenu show, hide 함수
 	  * */
 	 function fnClickLeftMenu(){
 	 	
 	 	 $('.left-nav > ul > li:has(ul li)').addClass("has-sub"); // 하위메뉴가 존재 할 때 has-sub클래스 추가
	 	 
 	 	 $('.left-nav > ul > li > a').click(function() { // 중메뉴 
	 	 	
	 	 	 var checkElement = $(this).next();
	 	 	 	
	 	 	 $('.left-nav li').removeClass('active'); //left-nav li영역 active클래스 삭제
	 	 	 $(this).closest('li').addClass('active'); //left-nav li영역 active클래스 추가	
	 	 	 	
	 	 	 	
	 	 	 if((checkElement.is('ul')) && (checkElement.is(':visible'))) { // 하위 메뉴 hide
	 	 	 $(this).closest('li').removeClass('active');
	 	 	 checkElement.slideUp('normal');
	 	 	 }
	 	 	 	
	 	  	 if((checkElement.is('ul')) && (!checkElement.is(':visible'))) { //하위 메뉴 show
	 	 	 $('.left-nav ul ul:visible').slideUp('normal');
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
	
	 
};
































