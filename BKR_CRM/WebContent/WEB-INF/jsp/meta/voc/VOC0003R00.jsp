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
 
   - PAGE ID : VOC0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">클레임 목록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="registBtn">
    <a href="#none" title="Register"><span class="ico-register"></span>신규 등록</a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="12%"/>
<col />
<col width="12%"/>
<col />
<col width="12%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">회원명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_CUST_SEARCH" name="NM_CUST_SEARCH"       value="${paramMap.NM_CUST_SEARCH}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">회원이메일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL"       value="${paramMap.DS_EMAIL}"                style="text-align:left;width:215px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="NO_PHONE_SEARCH" name="NO_PHONE_SEARCH"       value="${paramMap.NO_PHONE_SEARCH}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">채널구분</label></th>
<td id="layout-1_2_8"><select id="CD_CHNN" name="CD_CHNN" class="ub-control select "     style="width:112px;" size="1"  defaultvalue="${paramMap.CD_CHNN}"></select></td>
<th id="layout-1_2_9"><label class="ub-control label">등록일자</label></th>
<td id="layout-1_2_10"><input type=text class="ub-control input-text calendar " id="DT_REG_START" name="DT_REG_START"       metaformat="date" value="${paramMap.DT_REG_START}"                style="text-align:left;width:75px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_REG_END" name="DT_REG_END"       metaformat="date" value="${paramMap.DT_REG_END}"                style="text-align:left;width:75px;"></td>
<th id="layout-1_2_11"><label class="ub-control label">처리일자</label></th>
<td id="layout-1_2_12"><input type=text class="ub-control input-text calendar " id="DT_ACT_START" name="DT_ACT_START"       metaformat="date" value="${paramMap.DT_ACT_START}"                style="text-align:left;width:75px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_ACT_END" name="DT_ACT_END"       metaformat="date" value="${paramMap.DT_ACT_END}"                style="text-align:left;width:75px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">처리상태</label></th>
<td id="layout-1_3_14"><select id="CD_STATUS" name="CD_STATUS" class="ub-control select "     style="width:112px;" size="1"  defaultvalue="${paramMap.CD_STATUS}"></select></td>
<th id="layout-1_3_15"><label class="ub-control label">VOC유형</label></th>
<td id="layout-1_3_16"><select id="CD_VOC_CAUSE" name="CD_VOC_CAUSE" class="ub-control select "     style="width:112px;" size="1"  defaultvalue="${paramMap.CD_VOC_CAUSE}"></select></td>
<th id="layout-1_3_17"><label class="ub-control label">처리유형</label></th>
<td id="layout-1_3_18"><select id="CD_ACT_CAUSE" name="CD_ACT_CAUSE" class="ub-control select "     style="width:112px;" size="1"  defaultvalue="${paramMap.CD_ACT_CAUSE}"></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label">제목</label></th>
<td id="layout-1_4_20" colspan=5><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"                       style="text-align:left;width:250px;"></td>
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
