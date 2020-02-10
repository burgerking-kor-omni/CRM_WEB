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
 
   - PAGE ID : POP0012R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">회원 검색</h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
<table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col width="260px"/>
<col width="100px"/>
<col width="260px"/>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">회원명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_MEMBER_SEARCH" name="NM_MEMBER_SEARCH" maxLength="10" metalength="10"       value="${paramMap.NM_MEMBER_SEARCH}"                  style="ime-mode:active;text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">회원이메일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL"       value="${paramMap.DS_EMAIL}"                  style="ime-mode:inactive;text-align:left;width:200px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="NO_PHONE_SEARCH" name="NO_PHONE_SEARCH"       value="${paramMap.NO_PHONE_SEARCH}"                  style="ime-mode:disabled;text-align:left;width:90px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">회원PK</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="ID_MEMBER" name="ID_MEMBER" maxLength="7" metalength="7"       value="${paramMap.ID_MEMBER}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_2_9"><label class="ub-control label">회원등급</label></th>
<td id="layout-1_2_10"><select id="CD_GRADE" name="CD_GRADE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_GRADE}"></select></td>
<th id="layout-1_2_11"><label class="ub-control label">가입사이트</label></th>
<td id="layout-1_2_12"><select id="CD_JOIN_SITE" name="CD_JOIN_SITE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_JOIN_SITE}"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">회원상태</label></th>
<td id="layout-1_3_14"><select id="CD_STATUS" name="CD_STATUS" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_STATUS}"></select></td>
<th id="layout-1_3_15"><label class="ub-control label">가입경로</label></th>
<td id="layout-1_3_16"><select id="CD_JOIN_PATH" name="CD_JOIN_PATH" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_JOIN_PATH}"></select></td>
<th id="layout-1_3_17"><label class="ub-control label"             for="DT_START,DT_END">가입일</label></th>
<td id="layout-1_3_18"><input type=text class="ub-control input-text calendar " id="DT_START" name="DT_START"       metaformat="date" value="${paramMap.DT_START}"     metaessential="1"           style="text-align:left;width:65px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_END" name="DT_END"       metaformat="date" value="${paramMap.DT_END}"     metaessential="1"           style="text-align:left;width:65px;"></td>
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
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="select"     onclick="fnSelect();">
    <a href="#none" title="선택"><span></span>선택</a>
</span>
</div>

<!-- layout-1 End -->
