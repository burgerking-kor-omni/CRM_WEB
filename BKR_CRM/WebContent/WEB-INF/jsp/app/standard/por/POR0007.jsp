<%--
 *
 *  설    명 :  사별 Portal Main 화면 (하단 탭영역 삭제)
 *  작 성 자 :  
 *  작 성 일 :  2013-11-27
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
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
	<div class="ub-frame contents">
<!-- 		<div id="tabs" class="ub-control tab-portal tabs-bottom" ></div> -->
     <iframe id = 'bodyiframe' frameBorder="0" scrolling="auto" style="width:100%;margin:0px;padding:0px;border:0px;"></iframe>

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
			
			$('.logout-button a').click(function(){
				if(confirm('로그아웃을 하시겠습니까?')){
					uxl.moveLocation('<spring:url value="/logout.ub" />');
				}
			});
		});
		
		function fnGoMain(){		
			uxl.moveLocation('POR0007');
		}
		
		//비밀번호 변경
		function fnUserChange(){
			uxl.openWindow('POR0002',uxl.getScreenURL('SYS0060'),{ width:350 ,height:250 });
		}
		
		function iframeResize(gap){
			var height = $(window).height() + gap;
			$('#bodyiframe').attr('height',height+'px');
		}
	</script>
</html>