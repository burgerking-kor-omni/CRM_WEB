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
 
   - PAGE ID : ANA0009R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">고객속성별 VOC 현황</h1>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search"     onclick="fnSearch()">
<a href="#none" title="Search">검색</a>
</span>
<table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">기간</label></th>
<td id="layout-1_1_2"><select id="DT_START_Y" name="DT_START_Y" class="ub-control select "     style="width:100px;" size="1"></select><select id="DT_START_M" name="DT_START_M" class="ub-control select "     style="width:60px;" size="1"></select><label class="ub-control label"> ~ </label><select id="DT_END_Y" name="DT_END_Y" class="ub-control select "     style="width:100px;" size="1"></select><select id="DT_END_M" name="DT_END_M" class="ub-control select "     style="width:60px;" size="1"  defaultvalue="${paramMap.DT_START_M}"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">채널</label></th>
<td id="layout-1_2_4"><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="01"><label> APP</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="02"><label> WEB</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="03"><label> Moblile Web</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="04"><label> Call Center</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="05"><label> CRM</label></input></td>
</tr>
</tbody>
</table>
 

</div>
</form>
<div class="ub-layout button inner" id="excel_layout" name="excel_layout"  style="text-align:right;"><span class="ub-control button inner icon" id="excelBtn">
    <a href="#none" title="엑셀 다운로드"><span class="ico-excel"></span>엑셀 다운로드</a>
</span>
</div>

<!-- layout-1 End -->
