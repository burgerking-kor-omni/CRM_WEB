<%--
#*
 *  파 일 명 :  SYS0304.jsp
 *  설    명 :  게시판관리 상세 Main Tab Control
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.05.12
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0304R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 관리 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<input type=hidden id="ID_BOARD" name="ID_BOARD"    value="${paramMap.ID_BOARD}">
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tab" name="tab" class="ub-control tab"></div>

<!-- layout-1 End -->


<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">
var tab;
uxl.onLoad(function(){
	var boardId = $("#ID_BOARD").val();
	
	//tab 컨트롤
	tab= new uxl.Tabs('tab');
	tab.add('SYS0305', uxl.getScreenURL('SYS0305') + '?ID_BOARD=' + boardId, '기본정보', false);
	tab.add('SYS0306', uxl.getScreenURL('SYS0306') + '?ID_BOARD=' + boardId, '유형정보', false);
	tab.add('SYS0307', uxl.getScreenURL('SYS0307') + '?ID_BOARD=' + boardId, '관리자설정', false);
// 	tab.add('SYS0308', uxl.getScreenURL('SYS0308') + '?ID_BOARD=' + boardId, '권한설정', false);

	$("#listBtn").click(function() {
		uxl.returnToList('SYS0301');
	});
});	
	
</script>