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
 
   - PAGE ID : POP0092R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">다우에서 핀 발행</h1>
<h2 class="ub-control title">쿠폰 정보</h2>
<div class="ub-layout "><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">쿠폰 대상</label></th>
<td id="layout-1_1_2"><label id="CD_COUPON_OBJ" name="CD_COUPON_OBJ" class="ub-control label">기본레이블</label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">쿠폰명</label></th>
<td id="layout-1_2_4"><label id="NM_COUPON" name="NM_COUPON" class="ub-control label">기본레이블</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">유효 기간</label></th>
<td id="layout-1_3_6"><label id="DT_EXPIRY" name="DT_EXPIRY" class="ub-control label">기본레이블</label></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">쿠폰 상태</label></th>
<td id="layout-1_4_8"><label id="CD_STATUS" name="CD_STATUS" class="ub-control label">기본레이블</label></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label">발행 상태</label></th>
<td id="layout-1_5_10"><label id="TXT_STATUS" name="TXT_STATUS" class="ub-control label">기본 레이블</label></td>
</tr>
</tbody>
</table>
 
</div>
<label id="TXT_LABEL" name="TXT_LABEL" class="ub-control label">기본 레이블</label>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnPublish()">
    <a href="#none" title="발행"><span></span>발행</a>
</span>
<span class="ub-control button bottom icon"     onclick="self.close()">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>
<form id="searchForm" name="searchForm"><input type=hidden id="CD_COUPON" name="CD_COUPON"    value="${paramMap.CD_COUPON}">
<input type=hidden id="CNT_PIN" name="CNT_PIN"    value="${paramMap.CNT_PIN}">
<input type=hidden id="NO_REQ" name="NO_REQ"    value="${paramMap.NO_REQ}">
<input type=hidden id="DT_EXPIRY_START" name="DT_EXPIRY_START">
<input type=hidden id="DT_EXPIRY_END" name="DT_EXPIRY_END">
</form>

<!-- layout-1 End -->
