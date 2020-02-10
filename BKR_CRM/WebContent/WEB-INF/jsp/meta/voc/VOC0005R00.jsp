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
 
   - PAGE ID : VOC0005R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">이메일 발송 대상 관리</h1>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:54%;"><div class="ub-layout search" id="searchLayout" name="searchLayout">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="13%"/>
<col width="31%"/>
<col width="13%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">이름</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_TARGET_SEARCH" name="NM_TARGET_SEARCH" maxLength="30" metalength="30"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">이메일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DS_EMAIL_SEARCH" name="DS_EMAIL_SEARCH" maxLength="100" metalength="100"                       style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</form>
<span class="ub-control button search" id="searchBtn">
<a href="#none" title="Search">검색</a>
</span>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
</div>
<div class="ub-layout rightBox"   style="width:45%;"><h2 class="ub-control title">상세 기본정보</h2>
<div class="ub-layout details" id="detailLayout" name="detailLayout"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="12%"/>
<col width="28%"/>
<col width="15%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="NM_TARGET">이름</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_TARGET" name="NM_TARGET" maxLength="30" metalength="30"            metaessential="1"           style="text-align:left;width:100px;"><input type=hidden id="ID_TARGET" name="ID_TARGET"></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="DS_EMAIL">이메일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:140px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label id="NM_TARGET" name="NM_TARGET" class="ub-control label"      style="width:100px;">설명</label></th>
<td id="layout-1_2_6" colspan=3><textarea class="ub-control textarea " id="DS_TARGET" name="DS_TARGET"  metalength="500"      style="width:370px;" rows="4"                  rows="4"></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label class="ub-control label">등록일</label></th>
<td id="layout-1_3_8"><input type=text  class="ub-control input-text " id="DT_REG" name="DT_REG"         readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_3_9"><label class="ub-control label">등록자</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="NM_REG_USER" name="NM_REG_USER"         readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_11"><label class="ub-control label">수정일</label></th>
<td id="layout-1_4_12"><input type=text  class="ub-control input-text " id="DT_UPT" name="DT_UPT"         readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_4_13"><label class="ub-control label">수정자</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="NM_UPT_USER" name="NM_UPT_USER"         readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<h2 class="ub-control title">유형 별 상세정보</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="detailList" name="detailList"></table> 
	
</div>
<div class="ub-layout button bottom" id="bottomLayout" name="bottomLayout"><span class="ub-control button bottom icon" id="saveBtn">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
<span class="ub-control button bottom icon" id="deleteBtn">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>
</div>
</div>
<div class="ub-layout button top"><span class="ub-control button inner icon" id="registBtn">
    <a href="#none" title="등록"><span></span>등록</a>
</span>
</div>

<!-- layout-1 End -->
