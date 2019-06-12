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
 
   - PAGE ID : CUS0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">고객 목록</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="12%"/>
<col width="38%"/>
<col width="12%"/>
<col width="38%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">고객명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_CUST" name="NM_CUST"       value="${paramMap.NM_CUST}"                  style="ime-mode:inactive;text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="ID_PHONE" name="ID_PHONE"       value="${paramMap.ID_PHONE}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">고객 ID</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="ID_CUST" name="ID_CUST"       value="${paramMap.ID_CUST}"                  style="ime-mode:inactive;text-align:left;width:100px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">고객등급</label></th>
<td id="layout-1_2_8"><select id="CD_GRADE" name="CD_GRADE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_GRADE}"></select></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
</form>

</div>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon">
    <a href="#none" title="엑셀 다운로드"><span class="ico-excel"></span>엑셀 다운로드</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->
