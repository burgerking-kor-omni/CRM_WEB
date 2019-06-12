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
	<!-- Main Css -->
	<link rel="stylesheet" type="text/css" href='<spring:url value="/page/css/main.css"/>'/>
	<title><%=ConfigHolder.APPLICATION_NAME%></title>
	<meta charset="UTF-8" />
	<!--[if IE]> <script src="<spring:url value='/page/js/html5.js'/>"></script> <![endif]-->	
</head>
<body class="ub-page main">
	<section class="no-index">
		<h2>
			<img src="../page/images/main/txt_logo.png" alt="유비원" />
		</h2>
	</section>	
</body>
</html>