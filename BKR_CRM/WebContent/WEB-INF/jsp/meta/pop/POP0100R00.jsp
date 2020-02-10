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
 
   - PAGE ID : POP0100R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">매장찾기</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search"     onclick="fnSearch()">
<a href="#none" title="Search">검색</a>
</span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="280px"/>
<col width="120px"/>
<col width="280px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">매장코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="STOR_CD" name="STOR_CD" maxLength="8" metalength="8"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">매장명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="STOR_NM" name="STOR_NM" maxLength="15" metalength="15"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="TEL_NO" name="TEL_NO"      metaformat="phone"                 style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">D/T여부</label></th>
<td id="layout-1_2_8"><select id="YN_FLAG" name="YN_FLAG" class="ub-control select "     style="width:100px;" size="1"></select></td>
<th id="layout-1_2_9"><label class="ub-control label">배달여부</label></th>
<td id="layout-1_2_10"><select id="DLVYN" name="DLVYN" class="ub-control select "     style="width:115px;" size="1"></select></td>
<th id="layout-1_2_11"><label class="ub-control label">킹오더여부</label></th>
<td id="layout-1_2_12"><select id="KORD_YN" name="KORD_YN" class="ub-control select "     style="width:115px;" size="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">매장상태</label></th>
<td id="layout-1_3_14"><select id="CLOSE" name="CLOSE" class="ub-control select "     style="width:115px;" size="1"></select></td>
<th id="layout-1_3_15"><label class="ub-control label">직가맹여부</label></th>
<td id="layout-1_3_16"><select id="DRT_FRCS_TYPE" name="DRT_FRCS_TYPE" class="ub-control select "     style="width:115px;" size="1"></select></td>
<th id="layout-1_3_17"></th>
<td id="layout-1_3_18"></td>
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
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSelect()">
    <a href="#none" title="선택"><span></span>선택</a>
</span>
</div>

<!-- layout-1 End -->
