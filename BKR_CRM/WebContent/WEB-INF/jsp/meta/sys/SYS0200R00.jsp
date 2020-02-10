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
 
   - PAGE ID : SYS0200R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">고객정보 조회로그</h1>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search" id="btnSearch">
<a href="#none" title="Search">검색</a>
</span>
<table class="ub-control table normal ">
<colgroup>
<col width="10%"/>
<col width="40%"/>
<col width="10%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">조회일자</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_VIEW_START" name="DT_VIEW_START"       metaformat="date" value="${paramMap.DT_START}"                style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_VIEW_END" name="DT_VIEW_END"       metaformat="date" value="${paramMap.DT_END}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">화면명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"                       style="text-align:left;width:106px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">ID</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="USER_ID" name="USER_ID"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">이름</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM"                       style="text-align:left;width:106px;"></td>
</tr>
</tbody>
</table>
 

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->
