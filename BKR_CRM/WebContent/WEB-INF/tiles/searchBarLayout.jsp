<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="/jsp/error/errorPage.jsp" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.data.Result"%>
<%@ page import="com.ubone.framework.data.ServiceMessage"%>
<%@ page import="com.ubone.framework.engine.domain.Screen"%>
<%@ page import="com.ubone.framework.engine.domain.Function"%>
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
	<meta charset="UTF-8" />
</head>

<body class="ub-page search-bar ${screen.screenType}">
	<jsp:include page="/WEB-INF/jsp/include/pageToolBar.jsp"></jsp:include>
	<section class="ub-frame body">
<%-- 	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageLocation.jsp"/> --%>
	<div class="ub-layout location"></div>
	<div class="ub-layout condition" style="position: relative;right: 0;border: 3px dotted cyan;z-index: 999;background: white;">
		<span id="search_value">Search Values : </span>
		<span id="select_value">None</span>
		<form id="formSelect" name="formSelect" method="post"></form>
	</div>
		<div class="inner-contents-wrap"> 
			<!-- begin contents area -->
			<tiles:insertAttribute name="body"/>
			<!-- end contents area -->
		</div>
	</section>
</body>
</html>