<%--
 *
 *  설    명 :  사별 Portal Main 화면
 *  작 성 자 :  
 *  작 성 일 :  2013-05-18
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
--%>
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
	<link rel="stylesheet" type="text/css" href='<spring:url value="/uxl/menu/css/simpleMenu.css"/>'/>
	<script type="text/javascript" charset="UTF-8" src='<spring:url value="/uxl/menu/uxl-simpleMenu-1.1.1.js" />'></script>
	
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
					<span class="pw-button"><a href="javascript:fnUserChange();">비밀번호변경</a></span>
					<span class="logout-button"><a href="#">LOGOUT</a></span>
				</div>
			</div>
			<jsp:include page="/WEB-INF/jsp/include/pageMenu.jsp"></jsp:include>
		</div>
	</div>
	<div class="ub-frame contents">
		<div id="tabs" class="ub-control tab-portal tabs-bottom" ></div>
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
				tab.add('ROOT', '/screen/POR0003.ub', 'VOC메인', true);
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
						tab.add(item.menuId, item.menuUrl, item.menuName, true);
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
			uxl.reload();
		}

		//비밀번호 변경
		function fnUserChange(){
			uxl.openWindow('POR0002',uxl.getScreenURL('SYS0060'),{ width:350 ,height:250 });
		}
	</script>
</html>