<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ubqone.com/tags" prefix="ub" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP1002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">주문 목록</h1>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<form id="searchForm" name="searchForm"><input type=hidden id="ID_MEMBER" name="ID_MEMBER"    value="${paramMap.ID_MEMBER}">
<input type=hidden id="MENU_CD" name="MENU_CD"    value="${paramMap.MENU_CD}">
<input type=hidden id="STOR_CD" name="STOR_CD"    value="${paramMap.STOR_CD}">
<input type=hidden id="ORDER_CHN" name="ORDER_CHN"    value="${paramMap.ORDER_CHN}">
<input type=hidden id="CD_PAY_WAY" name="CD_PAY_WAY"    value="${paramMap.CD_PAY_WAY}">
<input type=hidden id="CHL_CD" name="CHL_CD"    value="${paramMap.CHL_CD}">
<input type=hidden id="PAYMENT_TYPE" name="PAYMENT_TYPE"    value="${paramMap.PAYMENT_TYPE}">
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="self.close()">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>

<!-- layout-1 End -->