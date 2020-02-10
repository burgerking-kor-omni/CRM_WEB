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
 
   - PAGE ID : POP0090R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">쿠폰 순서 설정</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">쿠폰 대상</label></th>
<td id="layout-1_1_2"><select id="CD_COUPON_OBJ" name="CD_COUPON_OBJ" class="ub-control select "     style="width:115px;" size="1"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DT_EXPIRY_START_ORDER">유효 기간</label></th>
<td id="layout-1_2_4"><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_START_ORDER" name="DT_EXPIRY_START_ORDER"       metaformat="date"      metaessential="1"           style="text-align:left;width:75px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_END_ORDER" name="DT_EXPIRY_END_ORDER"       metaformat="date"                 style="text-align:left;width:75px;"></td>
</tr>
</tbody>
</table>
 
</form>
<span class="ub-control button search"     onclick="fnSearch()">
<a href="#none" title="Search">검색</a>
</span>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave()">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
<span class="ub-control button bottom icon"     onclick="self.close()">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>

<!-- layout-1 End -->
