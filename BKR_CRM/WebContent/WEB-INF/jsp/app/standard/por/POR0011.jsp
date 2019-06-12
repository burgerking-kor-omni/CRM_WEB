<%--
 *  파 일 명 : POR0011.jsp
 *  설    명 : 좌측메뉴 + Wide메뉴 프레임 페이지
 *  작 성 자 : 황민국 
 *  작 성 일 : 2016-10-28
 *  버    전 : 1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
--%>
<%@page import="org.springframework.web.servlet.i18n.SessionLocaleResolver"%>
<%@page import="com.ubone.standard.login.domain.VocUser"%>
<%@page import="com.ubone.framework.util.hotlink.HotLink"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageMeta.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageHeader.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageCss.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageJs.jsp"/>
	
	<!-- Tab 사용 -->
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
	
	<!-- Menu Css/Js -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/wideMenu.css"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/menu/uxl-wideMenu-1.0.0.js" />'></script>
	<!-- Side Menu Css/Js -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/sideMenu-1.0.0.css?version=20170417"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/menu/uxl-sideMenu-1.0.0.js" />'></script>

	<!-- Scroll Plugin -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/ext/scroll/css/jquery.mCustomScrollbar.css"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/ext/scroll/jquery.mCustomScrollbar.min.js" />'></script>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
	<!--[if IE]> <script src="<spring:url value='/page/js/html5.js'/>"></script> <![endif]-->
	
</head>
<body class="ub-page portal-main" style="overflow-y: hidden;">
	<div class="ub-frame top">
		<div class="ub-layout header">
			<h1><a href="javascript:fnGoMain();"><img src="../page/images/common/img_h1_logo.png" alt="ubone 로고" /></a></h1>
				
			<div class="gnb-util">
				<div class="gnb-util-inner">
					<span class="login-user"><em>${user.name}</em>님 환영합니다</span>
					<span class="pw-button"><a href="javascript:fnUserChange();"><ub:message code="label.common.gnb.pass.change" text="패스워드변경"/></a></span>
<c:choose>
	<c:when test="${CURR_LANG_CD == 'en'}">
					<span class="lang-cd"><a href="javascript:uxl.changeLocale('ko')">한글</a></span>
	</c:when>
	<c:otherwise>
					<span class="lang-cd"><a href="javascript:uxl.changeLocale('en')">English</a></span>
	</c:otherwise>
</c:choose>					
					<span class="logout-button"><a href="#"><ub:message code="label.common.gnb.logout" text="로그아웃"/></a></span>
				</div>
			</div>
			<jsp:include page="/WEB-INF/jsp/include/pageMenuWide.jsp" flush="true"></jsp:include>
		</div>
	</div>

	<div class="ub-frame middle">
	
		<!-- 방향결정 -->
		<div class="ub-frame left">
			<!-- 메뉴 -->
			<div class="ub-frame side-menu">
			</div>
		</div>
		
		<div class="ub-frame contents">
			<div id="tabs" class="ub-control tab-portal tabs-bottom"></div>
		</div>
		
	</div>
	
	
</body>
<script type="text/javascript">
		var tab;
		uxl.onLoad(function(){
			tab = new uxl.Tabs('tabs'
								, {height:'300px'
								, iframeScroll:true
								, tabPosition:'bottom'
								, overMaxTabs:'remove-first'
								, tabLock:true
								, tabSortable:true
								}
			);
									
<%
	User user = UserUtil.getLoginUser();
	
	if(user.getSsoInfo() != null){
		HotLink hotLink = (HotLink)user.getSsoInfo().get(ConstantHolder.KEY_PARAMETER_HOTLINK);
		if(hotLink != null){
%>
				// 초기 탭 로딩.
				tab.add('<%=hotLink.getMenuId() %>', '<%=hotLink.getLinkUrl() %>', '<%=hotLink.getMenuName() %>', true);
<%
		}else{	
%>				
				// 초기 탭 로딩.
				tab.add('ROOT', uxl.getScreenURL('POR0003'), 'VOC메인', true);
				//				tab.add('ROOT', 'about:blank', 'BaseWeb', true);
<%
		}
		user.getSsoInfo().remove(ConstantHolder.KEY_PARAMETER_HOTLINK);
	}
%>
			$(window).resize(function(){
				tab.resize(-6);
			}).trigger('resize');
			
			//드롭다운 메뉴 동작 설정
			uxl.WideMenu("#menu", function(event, item){
				// 팝업유형 인경우
				if(item.menuType == 'P'){
					if(uxl.isNotEmpty(item.menuUrl)){
						uxl.openWindow(item.menuTarget, item.menuUrl, { width:item.menuWidth ,height:item.menuHeight, scrollbars:'no' });		
					}					
				}
				// 링크유형은 페이지 전환
				else if(item.menuType == 'L'){
					if(uxl.isNotEmpty(item.menuUrl)){
						uxl.moveLocation(item.menuUrl);
					}					
				}
				// 나머지는 Tab에 추가
				else{
					if(uxl.isNotEmpty(item.menuUrl)){
						tab.add(item.menuId, item.menuUrl, item.menuName, true);
					}
					$(window).resize();
				}
			});
	
			/* sub메뉴 선언
			*  1) isLargeMenu -> TopMenu 클릭 시 해당 대매뉴 표시 여부
			*/
			uxl.sideMenu($(".ub-frame.side-menu"), {isLargeMenu:true}, function(event, item){});
			
			/* Top메뉴 클릭시 접힘, 펼침 버튼 생성 */ 
 			$('#menu').click(function(){

 				 var $subFrame = $('div.ub-frame.middle'); //LeftMenu 추가될  frame div영역
 				 
 				 if(!$subFrame.children().hasClass('toggle-btn')){ //toggle-btn이 존재 하지 않을 때
 					fnMakeToggleBtn();	 
 				 }
			}); 

			$('.logout-button a').click(function(){
				if(confirm(uxl.getMessage('message.common.login.logout.confirm'))){
					uxl.moveLocation('<spring:url value="/logout.ub" />');
				}
			});
		});
		
		function fnGoMain(){		
			uxl.reload();
		}

		//비밀번호 변경
		function fnUserChange(){
			uxl.openWindow('POR0002',uxl.getScreenURL('SYS0060'),{ width:350 ,height:250 });
		}
		
		 /**
		  *leftMenu 접힘 펼침 btn 생성 함수
		  *
		  *접힘펼침 버튼은 togle-btn클래스 아래노드의 a태그의 backgroud속성으로 css에서 조절 
		  * */
		 function fnMakeToggleBtn(){
			 
			var $sideFrame = $('div.ub-frame.middle'); //LeftMenu 추가될  frame div영역
			var $toggleFrame = $('div.ub-frame.middle > div.toggle-btn'); // toggle버튼 div영역
		 		 
			var html =   '<div class="toggle-btn">'
					 +' <a href="#none">'
					 +   '<strong></strong>'
				 +' </a>'
				 +'</div>';			
				
			 $sideFrame.append(html);	 
			 
			 var $toggleBtn = $('.toggle-btn'); // 접힘 펼침 BtnId
			 
			 $toggleBtn.bind('click', function(event){ // 접힘 펼침 버튼 글릭시 이벤트
	
				var showHide = $sideFrame.hasClass('show-side'); //middle영역에 show-left클래스 존재 여부로 leftMenu 접힘 펼침
				    
			    if(showHide){ // ub-frame middle클래스에 show-left 클래스가 존재하면 제거, 아니면 추가
			    	$sideFrame.removeClass('show-side');         
			    }else{
			        $sideFrame.addClass('show-side');
			    }
			});
		 }
		
	</script>
</html>
