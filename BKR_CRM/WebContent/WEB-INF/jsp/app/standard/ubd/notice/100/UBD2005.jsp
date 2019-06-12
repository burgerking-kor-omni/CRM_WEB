<%--
#*
 *  파 일 명 :  UBD2005.jsp
 *  설    명 :  Board 일반게시판 답변글 등록화면
 *  작 성 자 :  ByeongGiKim
 *  작 성 일 :  2017-02-28
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.standard.ubboard.common.domain.Board"%>
<%@page import="com.ubone.framework.data.DataList"%>
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
		  , onRegist : function(){
			  	
		  }
	}
});
</script>

<jsp:include page="../base/include/boardHeader.jsp" flush="true">
	<jsp:param name="viewType" value="register"/>
</jsp:include>

<form id="defaultForm" name="defaultForm">
	<input type=hidden id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}">
	<input type=hidden id="ID_PARENT_ARTICLE" name="ID_PARENT_ARTICLE" value="${paramMap.ID_ARTICLE}">
	<input type=hidden id="ID_SUB" name="ID_SUB" value="${paramMap.ID_SUB}">

	<jsp:include page="../100/include/answerRegisterBody.jsp" flush="true"/>
		
	<jsp:include page="../base/include/boardFileControl.jsp" flush="true">
		<jsp:param name="readOnly" value="false"/>
		<jsp:param name="articleId" value=""/>
		<jsp:param name="boardId" value=""/>
		<jsp:param name="subId" value=""/>
	</jsp:include>
	
</form>

<jsp:include page="../base/include/answerRegisterBottomButton.jsp" flush="true"/>

<script type="text/javascript">

uxl.onLoad(function(){
	
	eventBus.triggerEvent("onLoad");
	
});

</script>