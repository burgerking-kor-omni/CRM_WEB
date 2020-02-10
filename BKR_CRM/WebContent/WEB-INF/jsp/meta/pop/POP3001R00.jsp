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
 
   - PAGE ID : POP3001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">쿠폰 등록 팝업</h1>
<div class="ub-layout details"><table class="ub-control table normal ">
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
<th id="layout-1_1_1"><label class="ub-control label">쿠폰코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_COUPON_SEL" name="CD_COUPON_SEL"         readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_COUPON_SEL" name="NM_COUPON_SEL"         readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">유효기간</label></th>
<td id="layout-1_1_6"></td>
</tr>
</tbody>
</table>
 
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
<col width="120px"/>
<col width="280px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">쿠폰코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_COUPON" name="CD_COUPON"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_COUPON" name="NM_COUPON"                       style="text-align:left;width:100px;"></td>
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
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave();">
    <a href="#none" title="Save"><span class="ico-save"></span>등록</a>
</span>
<span class="ub-control button bottom icon"     onclick="uxl.close();">
    <a href="#none" title="취소"><span></span>취소</a>
</span>
</div>

<!-- layout-1 End -->
