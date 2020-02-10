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
 
   - PAGE ID : CUS0031R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">스탬프 기준관리</h1>
<h2 class="ub-control title" for="standardInfo" hfold="1">기준정보</h2>
<div class="ub-layout " id="standardInfo" name="standardInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">구매방법</label></th>
<td id="layout-1_1_2" colspan=6></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">적립채널</label></th>
<td id="layout-1_2_4"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"><label>POS</label></input></td>
<td id="layout-1_2_5"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"><label>KIOSK</label></input></td>
<td id="layout-1_2_6"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"><label>APP</label></input></td>
<td id="layout-1_2_7"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"><label>Web</label></input></td>
<td id="layout-1_2_8"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"><label>Mobile Web</label></input></td>
<td id="layout-1_2_9"><input class="ub-control input-checkbox" type="checkbox" id="CALLCENTER" name="CALLCENTER"><label>Call Center</label></input></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_10"><label class="ub-control label">차감기준</label></th>
<td id="layout-1_3_11"><input class="ub-control radio" type=radio><label> 제한없음</label></td>
<td id="layout-1_3_12"><input class="ub-control radio" type=radio><label> 1년</label></td>
<td id="layout-1_3_13"><input class="ub-control radio" type=radio><label> 2년</label></td>
<td id="layout-1_3_14"><input class="ub-control radio" type=radio><label> 3년</label></td>
<td id="layout-1_3_15"><input class="ub-control radio" type=radio><label> 4년</label></td>
<td id="layout-1_3_16"><input class="ub-control radio" type=radio><label> 5년</label></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="standardInfo2" hfold="1">적립기준</h2>
<div class="ub-layout floatBox" id="standardInfo2" name="standardInfo2"><div class="ub-layout rightBox"   style="width:39%;"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">상품</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="MENU_NAME" name="MENU_NAME"         readonly              style="text-align:left;width:200px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">적립개수</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="STAMP_CNT" name="STAMP_CNT"                       style="text-align:right;width:100px;"><label class="ub-control label">개</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">사용여부</label></th>
<td id="layout-1_3_6"><select id="FG_USE" name="FG_USE" class="ub-control select "     style="width:120px;" size="1"></select></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout leftBox"   style="width:59%;"><div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon"     onclick="fnPopup('POP2001','P');">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_prod" name="list_prod"></table> 
	
</div>
</div>
</div>
<h2 class="ub-control title" for="collectInfo" hfold="1">적립혜택</h2>
<div class="ub-layout " id="collectInfo" name="collectInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">스탬프 5개</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_COUPON_5" name="NM_COUPON_5"         readonly              style="text-align:left;width:200px;"   disabled><span class="ub-control button inner icon"     onclick="fnPopup('POP3001','5');">    <a href="#none" title="찾기"><span></span>찾기</a></span></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">스탬프 10개</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="NM_COUPON_10" name="NM_COUPON_10"         readonly              style="text-align:left;width:200px;"   disabled><span class="ub-control button inner icon"     onclick="fnPopup('POP3001','10');">    <a href="#none" title="찾기"><span></span>찾기</a></span></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="changeRec" hfold="1">변경이력</h2>
<div class="ub-layout list" id="changeRec" name="changeRec"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_change" name="list_change"></table> 
	
</div>

<!-- layout-1 End -->
