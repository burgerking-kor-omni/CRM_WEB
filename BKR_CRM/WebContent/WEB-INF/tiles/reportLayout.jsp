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
	
	<!-- report Css -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/page/css/report.css"/>'/>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>

	<script language="javascript" type="text/javascript">
		var layout_name = "reportLayout";
		
		uxl.onLoad(function() {
			uxl.time('layout onLoad');
		});
		
    	// complete initilize function
    	uxl.onLoadComplete(function() {
    		uxl.time('layout onLoadComplete');
    	});
</script>
</head>

<body class="ub-page reportPop ${screen.screenType}">
	<section class="ub-frame body">
		<!-- begin reportLayout : ${screen.id} -->
		<tiles:insertAttribute name="body"/>
		<!-- end reportLayout : ${screen.id} -->
	</section>
</body>
</html>