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
 
   - PAGE ID : POP0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label id="searchCnd" name="searchCnd" class="ub-control label"             for="NM_DONG">읍면동</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_DONG" name="NM_DONG"            metaessential="1"             style="ime-mode:active;text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<h3 class="ub-control title">주소입력</h3>
<table class="ub-control table normal ">
<colgroup>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<td id="layout-1_1_1"><input type=text  class="ub-control input-text readonly" id="TOTAL_ZIP" name="TOTAL_ZIP"         readonly              style="text-align:left;width:52px;"><input type=text  class="ub-control input-text readonly" id="TOTAL_ADDR" name="TOTAL_ADDR"                       style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_2">
<td id="layout-1_2_2"><input type=text  class="ub-control input-text " id="TOTAL_ADDR2" name="TOTAL_ADDR2"                         style="ime-mode:active;text-align:left;width:370px;"><input type=hidden id="TP_ZIP" name="TP_ZIP"    value="L"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="confirm">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
