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
 
   - PAGE ID : CUP0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">쿠폰 마스터 관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="registBtn">
    <a href="#none"><span class="ico-register"></span>쿠폰등록</a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><span class="ub-control button search"     onclick="fnSearch()">
<a href="#none" title="Search">검색</a>
</span>
<table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="480px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">유효 기간</label></th>
<td id="layout-1_1_2"><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_START" name="DT_EXPIRY_START"       metaformat="date" value="${paramMap.DT_EXPIRY_START}"                style="text-align:left;width:75px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_END" name="DT_EXPIRY_END"       metaformat="date" value="${paramMap.DT_EXPIRY_END}"                style="text-align:left;width:75px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">등록일</label></th>
<td id="layout-1_1_4"><input type=text class="ub-control input-text calendar " id="DT_START_REG" name="DT_START_REG"       metaformat="date" value="${paramMap.DT_START_REG}"                style="text-align:left;width:75px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_END_REG" name="DT_END_REG"       metaformat="date" value="${paramMap.DT_END_REG}"                style="text-align:left;width:75px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">쿠폰 대상</label></th>
<td id="layout-1_2_6"><select id="CD_COUPON_OBJ" name="CD_COUPON_OBJ" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_COUPON_OBJ}"></select></td>
<th id="layout-1_2_7"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="NM_COUPON" name="NM_COUPON" maxLength="40" metalength="40"       value="${paramMap.NM_COUPON}"                style="text-align:left;width:250px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">쿠폰 상태</label></th>
<td id="layout-1_3_10"><select id="CD_CUP_STATUS" name="CD_CUP_STATUS" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_CUP_STATUS}"></select><input type=hidden id="SEARCH_YN" name="SEARCH_YN"    value="${paramMap.SEARCH_YN}"></td>
<td id="layout-1_3_11"></td>
<td id="layout-1_3_12"></td>
</tr>
</tbody>
</table>
 
</form>

</div>
<div class="ub-layout button inner"><span class="ub-control button inner icon"     onclick="fnPopupOrder()">
    <a href="#none" title="쿠폰 순서 설정"><span></span>쿠폰 순서 설정</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->
