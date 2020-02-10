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
 
   - PAGE ID : ANA0015R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">지역별 VOC 불만 현황</h1>
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
<th id="layout-1_1_1"><label class="ub-control label"             for="DT_START,DT_END">기간</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_START" name="DT_START"       metaformat="date" value="${paramMap.DT_START}"     metaessential="1"           style="text-align:left;width:70px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_END" name="DT_END"       metaformat="date" value="${paramMap.DT_END}"     metaessential="1"           style="text-align:left;width:70px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">채널</label></th>
<td id="layout-1_2_4"><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="01"><label> APP</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="02"><label> WEB</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="03"><label> Moblile Web</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="04"><label> Call Center</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="05"><label> CRM</label></input></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">분류</label></th>
<td id="layout-1_3_6"><input class="ub-control input-checkbox" type="checkbox" id="CD_DIVISION" name="CD_DIVISION"    checked value="01"><label> S분류</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_DIVISION" name="CD_DIVISION"    checked value="02"><label> 1분류</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_DIVISION" name="CD_DIVISION"    checked value="03"><label> 2분류</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_DIVISION" name="CD_DIVISION"    checked value="04"><label> 3분류</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_DIVISION" name="CD_DIVISION"    checked value="05"><label> 기타</label></input></td>
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
