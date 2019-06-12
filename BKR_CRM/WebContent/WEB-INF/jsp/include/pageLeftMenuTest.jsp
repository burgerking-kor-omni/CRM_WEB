<%--
 *  파 일 명 : pageLeftMenu.jsp
 *  설    명 : 좌측메뉴(include페이지)
 *  작 성 자 : 황민국 
 *  작 성 일 : 2016-10-28
 *  버    전 : 1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.web.util.HttpUtils"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@include file="/WEB-INF/jsp/include/pageTagLibs.jsp" %>
<%
	/* String menuType = (String) request.getParameter("menuType"); */
%>

<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/leftMenu.css"/>'/>	

<script type="text/javascript">



 <%-- var menuType = '<%=menuType%>'; --%>
 
 
 /**
  * 0. 로딩 이벤트 방인딩
    init();
     - 마우스오버, 클릭 크게 두가지 경우 (현재 simple-> div style="display:(none,block)"
     		                   / wide -> li class='active')
  * 1. 메뉴의 유형 찾기
    searchMenuType();
  	- simple, wide, etc.....
     - 어느 값으로 어느 시점에 인자값을 넘겨줄지에 대한 고민.
  * 2. 유형별 보정처리
    markupPatch();
  	- depth설정 위치의 기준(1에서 지정한 메뉴의 유형마다 다르다. ex)div, ul, li );
  	- 현재 depth마짐가은 class속성값이 depth-end
  * 3. 메뉴 데이터 가져오기
    getMenuData();
  	- 기존 top영역에 이미 메뉴의 데이터는 존재 id, name으로 좌측메뉴에 표현 실제 이벤트 실행은 상단 메뉴를 클릭했을때의 이벤트 실행
  * 4. 좌측메뉴 생성
  
  * 5. 이벤트 바인딩
  */ 
 
uxl.onLoad(function(){
	
	/* 메뉴영역을 크릭했을때 Event*/
	$("#menu").click(function(event){
		
        fnMakeLeftMenu1(); //대매뉴 그리기
        clickEvent(); //클릭이벤트
        
     	$('.ub-layout.menu.lnb').mCustomScrollbar({
    		theme:"minimal-dark"
    	});
	});  
	

	
});
 	
	/* 대메뉴 그리기 */
 	function fnMakeLeftMenu1(){

  		var selectedMenu = $('#menu li.active a'); // left menu에서 마우스오버된 메뉴까지 접근
  		var subMenus = selectedMenu.parent().find('.depth02 ul li'); // depth02의 부모노드 접근
  		var subMenusCnt = subMenus.length; // 하위메뉴 수
 		var menuName = selectedMenu.attr('menuname'); // 대메뉴 명
 		
 		var html = '<div class="ub-layout lnb-wrap"><div class="ub-layout menu lnb">'
 					+'<div class="tit-wrap"><h2 class="ub-control title">'+menuName+'</h2></div><nav class="left-nav"><ul>'
 					+(subMenusCnt>0 ? fnMakeLeftMenu2() : "")+'</ul></nav></div></div>'; 
 			
 	    document.getElementById("left-menu").innerHTML = html; // left-menu div영역에 삽입
 	}				

 	/* 중 메뉴 그리기 */
 	function fnMakeLeftMenu2(){
 		
  		var selectedMenu = $('#menu li.active a');
 		var subMenus2 = selectedMenu.parent().find('.depth02 ul li');
 		var subMenus2id = selectedMenu.parent().find('.depth02 a');
 		var subMenus2Cnt = subMenus2.length;
 		var html = "";
		
 		for(var i=0; i<subMenus2Cnt; i++){
 			
 			if(subMenus2.eq(i).hasClass("depth-end") || subMenus2[i].childElementCount>1){ // 마지막depth의 메뉴이거나 자식메뉴가 존재할때
 
 				var menuId = subMenus2id.eq(i).attr("menuid"); // 메뉴ID
 				var menuUrl = subMenus2id.eq(i).attr("menuurl"); // URL
 				var menuType = subMenus2id.eq(i).attr("menutype"); // 메뉴 타입(링크, 팝업....)
 				var menuHeight = subMenus2id.eq(i).attr("menuheight"); // 팝업타입시 창 높이
 				var menuWidth = subMenus2id.eq(i).attr("menuwidth"); // 팝업타입시 창 너비
 				var menuName = subMenus2[i].firstElementChild.innerText; // 메뉴명
 				
 				html += '<li><a menuId="'+menuId+'" menuUrl="'+menuUrl+'" menuName="'+menuName+'" menuType="'+menuType+'" menuHeight="'+menuHeight+'" menuWidth="'+menuWidth+'"><strong>'
 	 		 		+subMenus2[i].firstElementChild.innerText+'</strong></a>'
 	 		 		+(subMenus2[i].childElementCount>1 ? fnMakeLeftMenu3(subMenus2id.eq(i).attr("menuid")) : "")+'</li>';	
 			}
	 			
 		}
 		
 		return html;
 	}
 		
 	/* 소 메뉴 그리기 */
 	function fnMakeLeftMenu3(parentMenuId){
 		
  		var selectedMenu = $('#menu li.active a');
 		var subMenus3 = selectedMenu.parent().find('.depth03 ul li');
 		var subMenus3id = selectedMenu.parent().find('.depth03 a');
 		var subMenus3Cnt = subMenus3.length;
 		var html = '<ul>';
 		
 		for(var i=0; i<subMenus3Cnt; i++){
 			
 			if(parentMenuId==subMenus3id.eq(i).attr("parentmenuid")){//중메뉴로부터 전달받은 menuId와 현재 가지고있는 부모메뉴ID가 일치할때
 		 		
 				var menuId = subMenus3id.eq(i).attr("menuid"); // 메뉴ID
 				var menuUrl = subMenus3id.eq(i).attr("menuurl"); // URL
 				var menuName = subMenus3[i].firstElementChild.innerText; // 메뉴 타입(링크, 팝업....)
 				var menuType = subMenus3id.eq(i).attr("menutype"); // 팝업타입시 창 높이
 				var menuHeight = subMenus3id.eq(i).attr("menuheight"); // 팝업타입시 창 너비
 				var menuWidth = subMenus3id.eq(i).attr("menuwidth"); // 메뉴명
 				
 	 			html += '<li><a menuId="'+menuId+'" menuUrl="'+menuUrl+'" menuName="'+menuName+'" menuType="'+menuType+'" menuHeight="'+menuHeight+'" menuWidth="'+menuWidth+'"><strong>'
 	 				+subMenus3[i].firstElementChild.innerText
 	 				+'</strong></a></li>';
 			}
 		}
 		html += '</ul>';
 		
 		return html;
 	}
 	
 	/* 메뉴 show, hide 함수 */
 	function clickEvent(){
 		
    	$('.left-nav > ul > li:has(ul)').addClass("has-sub");
		
		$('.left-nav > ul > li > a').click(function() {
			
			var checkElement = $(this).next();
			
			$('.left-nav li').removeClass('active');
			$(this).closest('li').addClass('active');	
			
			
			if((checkElement.is('ul')) && (checkElement.is(':visible'))) { // 하위 메뉴 hide
			  $(this).closest('li').removeClass('active');
			  checkElement.slideUp('normal');
			}
			
	 		if((checkElement.is('ul')) && (!checkElement.is(':visible'))) { //하위 메뉴 show
			  $('.left-nav ul ul:visible').slideUp('normal');
			  checkElement.slideDown('normal');
			} 
			
			if (checkElement.is('div > ul')) {
	
			  return false;
			} else {
	
			  return true;	
			}		
		 }); 
 	
 	}
 	
 	/* 메뉴 show, hide 함수 */
 	function clickEvent2(value){

    	$('.left-nav > ul > li:has(ul)').addClass("has-sub");
		

			var checkElement = $(value).next();
			
			$('.left-nav li').removeClass('active');
			$(this).closest('li').addClass('active');	
			
			if((checkElement.is('ul')) && (checkElement.is(':visible'))) { // 하위 메뉴 hide
			  $(this).closest('li').removeClass('active');
			  checkElement.slideUp('normal');
			}
			
	 		if((checkElement.is('ul')) && (!checkElement.is(':visible'))) { //하위 메뉴 show
	 			alert("접근");
			  $('.left-nav ul ul:visible').slideUp('normal');
			  checkElement.slideDown('normal');
			} 
			
			if (checkElement.is('div > ul')) {
	
			  return false;
			} else {
	
			  return true;	
			}		
	 	
 	}
 	

 	
</script>



<!--  		<div class="ub-frame left">
			<div class="ub-layout lnb-wrap"> 왼쪽메뉴 전반적인 디자인
				<div class="ub-layout menu lnb"> 왼쪽메뉴 꾸미기
					<div class="tit-wrap">
						<h2 class="ub-control title">대메뉴</h2>	 대메뉴			
					</div>
					<nav class="left-nav">
						<ul>
						   <li class="active"><a href="#"><strong>중메뉴1</strong></a> 중메뉴
							  <ul>
								 <li class="current"><a href="#"><strong>소메뉴1</strong></a></li> 소메뉴
								 <li><a href="#"><strong>소메뉴1</strong></a></li>
								 <li><a href="#"><strong>소메뉴1</strong></a></li>
							  </ul>								 
						   </li>
						   <li><a href="#"><strong>중메뉴2</strong></a>중메뉴
							  <ul>
								 <li><a href="#"><strong>소메뉴2</strong></a></li>
								 <li><a href="#"><strong>소메뉴2</strong></a></li>
							  </ul>
						   </li>
						   <li><a href="#"><strong>중메뉴</strong></a></li>							
						</ul>
					</nav>
										
					<script type="text/javascript">
						$('.ub-layout.menu.lnb').mCustomScrollbar({
							theme:"minimal-dark"
						});
					</script>
				</div>
			</div>		
		</div>	 -->


