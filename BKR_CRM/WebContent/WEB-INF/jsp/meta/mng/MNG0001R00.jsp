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
 
   - PAGE ID : MNG0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">스탬프 목록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="registBtn">
    <a href="#none" title="Register"><span class="ico-register"></span>이벤트 등록</a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search"     onclick="fnSearch();">
<a href="#none" title="Search">검색</a>
</span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col width="360px"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">적용기간</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_START" name="DT_START"       metaformat="date" value="${paramMap.DT_START}"                style="text-align:left;width:75px;"><label class="ub-control label"      style="width:100px;"    metaformat="date"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_END" name="DT_END"       metaformat="date" value="${paramMap.DT_END}"                style="text-align:left;width:75px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">사용여부</label></th>
<td id="layout-1_1_4"><select id="FG_USE" name="FG_USE" class="ub-control select "     style="width:120px;" size="1"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">제목</label></th>
<td id="layout-1_2_6" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="50" metalength="50"       value="${paramMap.DS_TITLE}"                  style="ime-mode:active;text-align:left;width:250px;"></td>
</tr>
</tbody>
</table>
 
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->
