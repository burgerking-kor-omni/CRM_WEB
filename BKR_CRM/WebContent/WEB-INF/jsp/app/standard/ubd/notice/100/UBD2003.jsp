<%--
#*
 *  파 일 명 :  UBD1003.jsp
 *  설    명 :  Board 일반게시판 게시물 상세화면
 *  작 성 자 :  ByeongGiKim
 *  작 성 일 :  2016.11.25
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%
	BoardType boardType = (BoardType)ViewUtil.getResult().getExtendAttribute("boardType");
%>

<script type="text/javascript">
var eventBus = new EventBus({
	events:{
	  	    onLoad   : function(){
			  
		  }
		  , onSearch : function(){
			  
		  }
		  , onDelete : function(){
			  
		  }
	}
});
</script>

<!-- 게시판헤더 -->
<jsp:include page="../base/include/boardHeader.jsp" flush="true">
	<jsp:param name="viewType" value="article"/>
</jsp:include>

<form id="defaultForm" name="defaultForm">
	<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">
	<input type=hidden id="ID_ARTICLE" name="ID_ARTICLE" value="${paramMap.ID_ARTICLE}">
	<input type=hidden id="ID_SUB" name="ID_SUB" value="${paramMap.ID_SUB}">
	
	<jsp:include page="../100/include/articleBody.jsp" flush="true"/>
	
	<jsp:include page="../base/include/boardFileControl.jsp" flush="true">
		<jsp:param name="readOnly" value="true"/>
		<jsp:param name="articleId" value="${paramMap.ID_ARTICLE}"/>
		<jsp:param name="boardId" value="${paramMap.ID_BOARD}"/>
		<jsp:param name="subId" value="${paramMap.ID_SUB}"/>
	</jsp:include>

</form>	

<jsp:include page="../base/include/articleBottomButton.jsp" flush="true"/>

<jsp:include page="../base/include/articleReply.jsp" flush="true"/>

<script type="text/javascript" charset="UTF-8" src="<spring:url value='/page/js/board/fileReply.js'/>"></script>
<script type="text/javascript">

uxl.onLoad(function(){
	eventBus.triggerEvent("onLoad");
});

</script>