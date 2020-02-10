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
 
   - PAGE ID : INF0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">FAQ - 목록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="save">
    <a href="#none" title="Register"><span class="ico-register"></span>신규등록</a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">카테고리</label></th>
<td id="layout-1_1_2"><select id="CD_COMP" name="CD_COMP" class="ub-control select "     style="width:60px;" size="1"  defaultvalue="${paramMap.CD_COMP}"></select><select id="CD_BRAND" name="CD_BRAND" class="ub-control select "     style="width:90px;" size="1"  defaultvalue="${paramMap.CD_BRAND}"></select><select id="CD_SUB_BRAND" name="CD_SUB_BRAND" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="${paramMap.CD_SUB_BRAND}"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">등록일자</label></th>
<td id="layout-1_1_4"><input type=text class="ub-control input-text calendar " id="DT_REG_START" name="DT_REG_START"                        style="text-align:left;width:100px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_REG_END" name="DT_REG_END"                        style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">제목+내용</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="${paramMap.DS_TITLE}"                style="text-align:left;width:280px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">등록자</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="NM_REG_EMP" name="NM_REG_EMP"       value="${paramMap.NM_REG_EMP}"  readonly              style="text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="empSearch" name="empSearch"><span>@@</span></a><input type=hidden id="ID_REG_EMP" name="ID_REG_EMP"    value="${paramMap.ID_REG_EMP}"></td>
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

<!-- layout-1 End -->
