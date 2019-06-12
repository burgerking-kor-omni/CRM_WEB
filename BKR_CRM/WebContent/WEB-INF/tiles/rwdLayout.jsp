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
	<jsp:include flush="true" page="/WEB-INF/jsp/include/rwd/pageMeta.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/rwd/pageHeader.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/rwd/pageCss.jsp"/>
	<jsp:include flush="true" page="/WEB-INF/jsp/include/rwd/pageJs.jsp"/>
	
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
</head>

<body class="ub-page rwd ${screen.screenType }">
	<section class="ub-frame body">
		<!-- begin rwdLayout : ${screen.id} -->
		<tiles:insertAttribute name="body"/>
		<!-- end rwdLayout : ${screen.id} -->
	</section>
</body>
</html>