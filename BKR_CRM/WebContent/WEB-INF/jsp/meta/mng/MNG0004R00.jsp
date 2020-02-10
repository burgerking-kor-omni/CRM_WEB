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
 
   - PAGE ID : MNG0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">스템프 적립혜택</h1>
<div class="ub-layout floatBox" id="collectInfo" name="collectInfo"><div class="ub-layout rightBox"   style="width:49%;"><h2 class="ub-control title">적립혜택(스탬프 10개)</h2>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon"     onclick="fnPopup('10')">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
<span class="ub-control button inner icon"     onclick="fnDelList('list_cnt10')">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_cnt10" name="list_cnt10"></table> 
	
</div>
</div>
<div class="ub-layout leftBox"   style="width:49%;"><h2 class="ub-control title">적립혜택(스탬프 5개)</h2>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon"     onclick="fnPopup('5')">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
<span class="ub-control button inner icon"     onclick="fnDelList('list_cnt5')">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_cnt5" name="list_cnt5"></table> 
	
</div>
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave()">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
