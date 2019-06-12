<%@page import="com.ubone.standard.ubboard.common.domain.BoardScreenInfomation"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
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
	
	<link rel="stylesheet" type="text/css" href='<spring:url value="/page/css/board.css"/>'/>

	<!-- 페이지 기본 구성 JS 포함 -->
	<jsp:include flush="true" page="/WEB-INF/jsp/include/pageJs.jsp"/>
	
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/ckeditor/ckeditor.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/board/dndFile.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/board/boardCommon.js'/>"></script>
	<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/event/eventBus.js'/>"></script>
	
	<!-- Print-Prview -->
	<%-- <link rel="stylesheet" type="text/css" href='<spring:url value="/page/js/print/css/print-preview.css"/>'/> --%>
	<%-- <script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/print/jquery.print-preview.js'/>"></script> --%>
<%	     
	Parameter parameter = ViewUtil.getParameter();

	String boardType = parameter.getValue("boardType");
	
	BoardScreenInfomation boardScreenInfo = null;
	if(boardType != null && !"".equals(boardType)){
		boardScreenInfo = BoardScreenInfomation.valueOfName(boardType);
	}
%>
	<script>
		var _BOARD_LIST_PAGE = '<%=boardScreenInfo.getListScreenId()%>';
		var _BOARD_REGIST_PAGE = '<%=boardScreenInfo.getRegistScreenId()%>';
		var _BOARD_DETAIL_PAGE = '<%=boardScreenInfo.getDetailScreenId()%>';
		var _BOARD_MODIFY_PAGE = '<%=boardScreenInfo.getModifyScreenId()%>';
		var _BOARD_ANSWER_REGIST_PAGE = '<%=boardScreenInfo.getAnswerRegistScreenId()%>';
		var _BOARD_ANSWER_MODIFY_PAGE = '<%=boardScreenInfo.getAnswerModifyScreenId()%>';
		var _BOARD_RECOVERY_PAGENUM = 1;
		var _IMAGE_SERVER_URL = '<%=ConfigHolder.get("suhyang.image.server.url")%>';
	</script>
<%
	//검색이력 저장여부에 따른 파라미터 처리
	Screen screen = ViewUtil.getScreen();
	if(screen.getScreenType().equals(ScreenType.list)){
		String pageNumber = StringUtils.defaultIfEmpty(parameter.getValue(ConstantHolder.KEY_PAGE_NUMBER), "1");
		String recoveryCommand = StringUtils.defaultString(request.getParameter(ConstantHolder.KEY_SEARCH_RECOVERY_COMMAND), "");
		
		if("recovery".equals(recoveryCommand)){
%>
	<script>	
		_BOARD_RECOVERY_PAGENUM = <%=pageNumber%>;
	</script>
<%
		}
	}
%>
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
</head>

<body class="ub-page board ${screen.screenType}">
	<section class="ub-frame body">
<%-- 		<jsp:include flush="true" page="/WEB-INF/jsp/include/pageLocation.jsp"/> --%>
		<div class="ub-layout location"></div>
		<div class="inner-contents-wrap"> 
			<!-- begin contents area -->
			<tiles:insertAttribute name="body"/>
			<!-- end contents area -->
		</div>
	</section>
</body>
</html>