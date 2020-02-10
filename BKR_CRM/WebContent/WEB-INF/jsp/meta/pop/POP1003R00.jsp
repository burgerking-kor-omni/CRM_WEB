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
 
   - PAGE ID : POP1003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">쿠폰등록 팝업</h1>
<div class="ub-layout "><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="90px"/>
<col width="50px"/>
<col width="90px"/>
<col width="150px"/>
<col width="90px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">쿠폰코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_COUPON" name="CD_COUPON"         readonly              style="text-align:left;width:50px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_COUPON" name="NM_COUPON"         readonly              style="text-align:left;width:150px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">유효기간</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="DT_EXPIRY_START" name="DT_EXPIRY_START"         readonly              style="text-align:left;width:70px;"><label class="ub-control label"> ~ </label><input type=text  class="ub-control input-text " id="DT_EXPIRY_END" name="DT_EXPIRY_END"         readonly              style="text-align:left;width:70px;"><span class="ub-control button inner icon"     onclick="fnSave();">    <a href="#none" title="등록"><span></span>등록</a></span></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="CD_MEMBER_GRADE" name="CD_MEMBER_GRADE"    value="${paramMap.CD_MEMBER_GRADE}">
</form>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<span class="ub-control button search" id="searchBtn">
<a href="#none" title="Search">검색</a>
</span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="90px"/>
<col width="50px"/>
<col width="90px"/>
<col width="280px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">쿠폰코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_COUPON_SEARCH" name="CD_COUPON_SEARCH" maxLength="20" metalength="20"                       style="text-align:left;width:50px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_COUPON_SEARCH" name="NM_COUPON_SEARCH" maxLength="50" metalength="50"                       style="text-align:left;width:150px;"></td>
<th id="layout-1_1_5"></th>
<td id="layout-1_1_6"></td>
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
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="self.close();">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>

<!-- layout-1 End -->
