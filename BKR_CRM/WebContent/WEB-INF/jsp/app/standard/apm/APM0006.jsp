<%--
#*
 *  파 일 명 :  APM0015.jsp
 *  설    명 :  서비스 상세 Main Tab Control [팝업용]
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
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
 
   - PAGE ID : APM0015R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">서비스 상세</h1>

<input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="svcTab" name="svcTab" class="ub-control tab"></div>

<!-- layout-1 End -->


<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">
var tab;
var serviceQueryTab;
uxl.onLoad(function(){
	var svcId = $("#SERVICE_ID").val();
	
	//tab 컨트롤
	tab= new uxl.Tabs('svcTab', {showOnAdded:false});
	tab.add('APM0008', uxl.getScreenURL('APM0008') + '?SERVICE_ID=' + svcId, '서비스 상세', false);
	tab.add('APM0009', uxl.getScreenURL('APM0009') + '?SERVICE_ID=' + svcId, '서비스 코드', false);
	tab.add('APM0024', uxl.getScreenURL('APM0024') + '?SERVICE_ID=' + svcId, '데이터 변환', false);
//	tab.add('APM0025', uxl.getScreenURL('APM0025') + '?SERVICE_ID=' + svcId, '데이터 변환', false);
	tab.add('APM0010', uxl.getScreenURL('APM0010') + '?SERVICE_ID=' + svcId, '에러 로그', false);
	tab.add('APM0032', uxl.getScreenURL('APM0032') + '?SERVICE_ID=' + svcId, '서비스 쿼리', false);
	
	// 서비스쿼리탭 숨김처리
	serviceQueryTab = $("li[aria-controls='"+tab.id_prifix+"APM0032']");
	serviceQueryTab.hide();
	
});	
	
</script>