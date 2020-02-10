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
 
   - PAGE ID : POP0096R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">상품 찾기</h1>
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
<col width="300px"/>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">구분</label></th>
<td id="layout-1_1_2"><select id="CD_MENU_TYPE" name="CD_MENU_TYPE" class="ub-control select "     style="width:115px;" size="1"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">상태</label></th>
<td id="layout-1_1_4"><select id="USE_YN" name="USE_YN" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.USE_YN}"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">상품 코드</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="MENU_CD" name="MENU_CD" maxLength="7" metalength="7"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">상품명</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="MENU_NM" name="MENU_NM" maxLength="20" metalength="20"                       style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">카테고리</label></th>
<td id="layout-1_3_10" colspan=3><select id="MENU_CATEGORY_1" name="MENU_CATEGORY_1" class="ub-control select "     style="width:115px;" size="1"></select><select id="MENU_CATEGORY_2" name="MENU_CATEGORY_2" class="ub-control select "     style="width:170px;" size="1"></select><input type=hidden id="MENU_TYPE" name="MENU_TYPE"    value="${paramMap.MENU_TYPE}"><input type=hidden id="MANAGE_TYPE" name="MANAGE_TYPE"    value="${paramMap.MANAGE_TYPE}"></td>
</tr>
</tbody>
</table>
 

</div>
</form>
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
