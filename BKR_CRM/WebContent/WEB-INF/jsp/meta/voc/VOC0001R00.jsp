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
 
   - PAGE ID : VOC0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">VOC 목록</h1>
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
<col width="100px"/>
<col width="300px"/>
<col width="100px"/>
<col width="350px"/>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">VOC 번호</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ID_VOC" name="ID_VOC" maxLength="16" metalength="16"       value="${paramMap.ID_VOC}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">VOC 유형</label></th>
<td id="layout-1_1_4"><select id="CD_VOC_CAUSE_1" name="CD_VOC_CAUSE_1" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_VOC_CAUSE_1}"></select><select id="CD_VOC_CAUSE_2" name="CD_VOC_CAUSE_2" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="${paramMap.CD_VOC_CAUSE_2}"></select></td>
<th id="layout-1_1_5"><label class="ub-control label">회원명</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="NM_MEMBER_SEARCH" name="NM_MEMBER_SEARCH" maxLength="10" metalength="10"       value="${paramMap.NM_MEMBER_SEARCH}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">등록일</label></th>
<td id="layout-1_2_8"><input type=text class="ub-control input-text calendar " id="DT_REG_START" name="DT_REG_START"       metaformat="date" value="${paramMap.DT_REG_START}"                style="text-align:left;width:70px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_REG_END" name="DT_REG_END"       metaformat="date" value="${paramMap.DT_REG_END}"                style="text-align:left;width:70px;"></td>
<th id="layout-1_2_9"><label class="ub-control label">발생매장</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="STOR_NM" name="STOR_NM" maxLength="10" metalength="10"       value="${paramMap.STOR_NM}"                style="text-align:left;width:100px;"><input type=text  class="ub-control input-text " id="NM_STORE" name="NM_STORE"       value="${paramMap.NM_STORE}"  readonly              style="text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="img" name="img"         onclick="fnSearchStore()"><span>@@</span></a><input type=hidden id="ID_STORE" name="ID_STORE"    value="${paramMap.ID_STORE}"></td>
<th id="layout-1_2_11"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="NO_PHONE_SEARCH" name="NO_PHONE_SEARCH"       value="${paramMap.NO_PHONE_SEARCH}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">처리일</label></th>
<td id="layout-1_3_14"><input type=text class="ub-control input-text calendar " id="DT_ACT_START" name="DT_ACT_START"       metaformat="date" value="${paramMap.DT_ACT_START}"                style="text-align:left;width:70px;"><label class="ub-control label">~</label><input type=text class="ub-control input-text calendar " id="DT_ACT_END" name="DT_ACT_END"       metaformat="date" value="${paramMap.DT_ACT_END}"                style="text-align:left;width:70px;"></td>
<th id="layout-1_3_15"><label class="ub-control label">처리자</label></th>
<td id="layout-1_3_16"><input type=text  class="ub-control input-text " id="NM_USER_SEARCH" name="NM_USER_SEARCH" maxLength="10" metalength="10"       value="${paramMap.NM_USER_SEARCH}"                style="text-align:left;width:100px;"><input type=text  class="ub-control input-text " id="NM_USER" name="NM_USER"       value="${paramMap.NM_USER}"  readonly              style="text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="img" name="img"         onclick="fnSearchEmp()"><span>@@</span></a><input type=hidden id="ID_USER" name="ID_USER"    value="${paramMap.ID_USER}"></td>
<th id="layout-1_3_17"><label class="ub-control label">이메일</label></th>
<td id="layout-1_3_18"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL" maxLength="30" metalength="30"       value="${paramMap.DS_EMAIL}"                style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label">제목</label></th>
<td id="layout-1_4_20"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="35" metalength="35"       value="${paramMap.DS_TITLE}"                style="text-align:left;width:230px;"></td>
<th id="layout-1_4_21"><label class="ub-control label">상태</label></th>
<td id="layout-1_4_22"><select id="CD_VOC_STATUS" name="CD_VOC_STATUS" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_VOC_STATUS}"></select></td>
<th id="layout-1_4_23"><label class="ub-control label">처리유형</label></th>
<td id="layout-1_4_24"><select id="CD_ACT_CAUSE" name="CD_ACT_CAUSE" class="ub-control select "     style="width:112px;" size="1"  defaultvalue="${paramMap.CD_ACT_CAUSE}"></select></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_25"><label class="ub-control label">등록 채널</label></th>
<td id="layout-1_5_26" colspan=5><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="01"><label> APP</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="02"><label> WEB</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"    checked value="03"><label> Moblile Web</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="04"><label> Call Center</label></input><input class="ub-control input-checkbox" type="checkbox" id="CD_BIZ_CHNN" name="CD_BIZ_CHNN"     value="05"><label> CRM</label></input></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>
</form>

</div>
<div class="ub-layout button inner" id="excel_layout" name="excel_layout"  style="text-align:right;"><span class="ub-control button inner icon" id="excelBtn">
    <a href="#none" title="엑셀 다운로드"><span class="ico-excel"></span>엑셀 다운로드</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->
