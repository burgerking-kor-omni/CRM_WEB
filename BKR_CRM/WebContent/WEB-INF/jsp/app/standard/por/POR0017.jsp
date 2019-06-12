<%--
 *  파 일 명 : POR0017.jsp
 *  설    명 : 좌측메뉴 + Simple 메뉴 프레임 페이지
 *  작 성 자 : 황민국 
 *  작 성 일 : 2016-10-28
 *  버    전 : 1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
--%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.ubone.framework.util.hotlink.HotLink"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%
	String pwFlag = StringUtils.defaultString(request.getParameter("pwChange"), "");
	String pwLimitDay = StringUtils.defaultString(request.getParameter("pwLimitDay"), "");
	String errorMessage = "";

	if("require".equals(pwFlag)){
		errorMessage = "비밀번호 사용기간이 "+pwLimitDay+"일 남았습니다.\n비밀번호를 변경하여 주세요.";
	}

%>
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
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/simpleMenu.css"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/menu/uxl-simpleMenu-1.1.1.js" />'></script>
	<!-- Side Menu Css/Js -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/sideMenu-1.0.0.css?version=20170417"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/menu/uxl-sideMenu-1.0.0.js" />'></script>
	<!-- Scroll Plugin -->
	<link rel="stylesheet" type="text/css" href="../../uxl/ext/scroll/css/jquery.mCustomScrollbar.css"/>
	<script type="text/javascript" charset="UTF-8" src="../../uxl/ext/scroll/jquery.mCustomScrollbar.min.js" /></script>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
	<!--[if IE]> <script src="<spring:url value='/page/js/html5.js'/>"></script> <![endif]-->

	
</head>
<body class="ub-page portal-main" style="overflow-y: hidden;">
	<div id="errorMessage" style="display:none;"><%=errorMessage %></div>
	<div class="ub-frame top">
		<h1><a href="javascript:fnGoMain();"><img src="../page/images/common/img_h1_logo.png" alt="ubone 로고" /></a></h1>
			
		<div class="gnb-util">
			<span class="login-user"><em>${user.name}</em>님 환영합니다</span>
			<span class="pw-button"><a href="javascript:fnUserChange();">비밀번호변경</a></span>
			<span class="logout-button"><a href="#">Logout</a></span>			
		</div>

		<jsp:include page="/WEB-INF/jsp/include/pageMenu.jsp"></jsp:include>
		
	</div>

	<div class="ub-frame middle">
			
		<!-- 방향결정 -->
		<div class="ub-frame left">
			<!-- 메뉴 -->
			<div class="ub-frame side-menu">
			</div>
		</div>
		
		<div class="ub-frame contents">
	<!-- 		<div id="tabs" class="ub-control tab-portal tabs-bottom" ></div> -->
	     	<iframe id = 'bodyiframe' frameBorder="0" scrolling="auto" style="width:100%;margin:0px;padding:0px;border:0px;"></iframe>
		</div>
	</div>
	
	<!-- 	footer 영역 -->
	<div class="main-footer">
		<p class="copyright">Copyright (c) 2014 UB-ONE CO. LTD. all rights reserved.</p> 
	</div>
</body>

<script type="text/javascript">
		uxl.onLoadComplete(function() {
			
			var message = $('#errorMessage').text();
			if(uxl.isNotEmpty(message)){
					uxl.showMessage(message);
			}

		});

		uxl.onLoad(function(){

  			$(window).resize(function(){
  				iframeResize(-112);
  			}).trigger('resize');
			
  			
			//드롭다운 메뉴 동작 설정
			uxl.SimpleMenu("#menu", function(event, item){
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
						$('#bodyiframe').attr('src',item.menuUrl);
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
			
			/* left영역이 제어됨과 동시에 contents영역 자동 resize */
			$('div.ub-frame.middle').addClass('move');
			
			
			$('.logout-button a').click(function(){
				if(confirm('로그아웃을 하시겠습니까?')){
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
		
		function iframeResize(gap){
			var height = $(window).height() + gap;
			$('#bodyiframe').attr('height',height+'px');
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

