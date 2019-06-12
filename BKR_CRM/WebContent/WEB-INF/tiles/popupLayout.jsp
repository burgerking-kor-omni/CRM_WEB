<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.data.Result"%>
<%@ page import="com.ubone.framework.data.ServiceMessage"%>
<%@ page import="com.ubone.framework.engine.domain.Screen"%>
<%@ page import="com.ubone.framework.engine.domain.Function"%>
<%@ page import="com.ubone.framework.engine.domain.ScreenLayoutType"%>
<%@ page import="com.ubone.framework.engine.domain.ScreenType"%>
<%@ page import="com.ubone.framework.engine.domain.UserContainer"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.security.token.TokenContainer"%>

<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageMeta.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageHeader.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageCss.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageJs.jsp"/>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>

	<script language="javascript" type="text/javascript">
		var layout_name = "popupLayout";
		
		uxl.onLoad(function() {
			uxl.time('layout onLoad');
			
			var  titleText = $(".pop-contents .ub-control.title:first").text();
			$(".pop-contents .ub-control.title:first").remove();
			$(".pop-header .ub-control.title span").text(titleText);
			$(".pop-tail").append($(".pop-contents .ub-layout.button.bottom"));
			
			 // 팝업 X 버튼 닫기 기능
			uxl.setPopUpClose();

		});
		
    	// complete initilize function
    	uxl.onLoadComplete(function() {
    		uxl.time('layout onLoadComplete');
    	});
    	
    	/**
    	 * 팝업의 경우 X 버튼을 누르면 자동으로 닫히도록 한다.
    	 */
    	uxl.setPopUpClose = function(){
    		$('.ub-control.button.imgBtn.img-popClose').click(function(evnet) {
    			self.close();
    		});
    	};
    	
	</script>
</head>

<body class="ub-page popup ${screen.screenType}" style="margin-top:0;">
	<section class="ub-frame body">
		<!-- begin popupLayout : ${screen.id} -->
		<div class="pop-header">
			<h1 class="ub-control title"><span>title</span></h1>
			<a href="#" class="ub-control button imgBtn img-popClose"><span>close</span></a>
		</div>
		<div class="pop-contents">
			<tiles:insertAttribute name="body"/>
		</div>
		<div class="pop-tail">
		</div>
		<!-- end popupLayout : ${screen.id} -->
	</section>
</body>
</html>