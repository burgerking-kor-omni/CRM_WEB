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
 
   - PAGE ID : MNG0003R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">스탬프 기준관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="registForm" name="registForm"><h2 class="ub-control title" for="standardInfo" hfold="1">기준정보</h2>
<div class="ub-layout " id="standardInfo" name="standardInfo"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
<col width="150px"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="DT_APPLY_START,DT_APPLY_END">적용기간</label></th>
<td id="layout-1_1_2" colspan=6><input type=text class="ub-control input-text calendar " id="DT_APPLY_START" name="DT_APPLY_START"       metaformat="date" value="${paramMap.DT_START}"     metaessential="1"           style="text-align:left;width:75px;"><label class="ub-control label"      style="width:100px;"    metaformat="date"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_APPLY_END" name="DT_APPLY_END"       metaformat="date" value="${paramMap.DT_END}"     metaessential="1"           style="text-align:left;width:75px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_2_4" colspan=2><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:250px;"></td>
<th id="layout-1_2_5"><label class="ub-control label"             for="FG_USE_MAIN">사용여부</label></th>
<td id="layout-1_2_6" colspan=3><select id="FG_USE_MAIN" name="FG_USE_MAIN" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="Y"     metaessential="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7" rowspan=4><label class="ub-control label">적립채널</label></th>
<th id="layout-1_3_8"><label class="ub-control label">딜리버리</label></th>
<td id="layout-1_3_9"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0101"><label>POS</label></input></td>
<td id="layout-1_3_10"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0102"><label>KIOSK</label></input></td>
<td id="layout-1_3_11"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0103"><label>APP</label></input></td>
<td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0104"><label>Web</label></input></td>
<td id="layout-1_3_13"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0105"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_14"><label class="ub-control label">킹오더</label></th>
<td id="layout-1_4_15"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0201"><label>POS</label></input></td>
<td id="layout-1_4_16"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0202"><label>KIOSK</label></input></td>
<td id="layout-1_4_17"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0203"><label>APP</label></input></td>
<td id="layout-1_4_18"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0204"><label>Web</label></input></td>
<td id="layout-1_4_19"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0205"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_20"><label class="ub-control label">킹오더 DT</label></th>
<td id="layout-1_5_21"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0301"><label>POS</label></input></td>
<td id="layout-1_5_22"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0302"><label>KIOSK</label></input></td>
<td id="layout-1_5_23"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0303"><label>APP</label></input></td>
<td id="layout-1_5_24"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0304"><label>Web</label></input></td>
<td id="layout-1_5_25"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0305"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_26"><label class="ub-control label">매장</label></th>
<td id="layout-1_6_27"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0401"><label>POS</label></input></td>
<td id="layout-1_6_28"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0402"><label>KIOSK</label></input></td>
<td id="layout-1_6_29"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0403"><label>APP</label></input></td>
<td id="layout-1_6_30"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0404"><label>Web</label></input></td>
<td id="layout-1_6_31"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0405"><label>Mobile Web</label></input></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="standardInfo2" hfold="1">적립기준</h2>
<div class="ub-layout floatBox" id="standardInfo2" name="standardInfo2"><div class="ub-layout rightBox"   style="width:49%;"><table class="ub-control table normal " id="stdlayout">
<colgroup>
<col width="60px"/>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" rowspan=4><label id="LBL_CATEGORY" name="LBL_CATEGORY" class="ub-control label"             for="MENU_CATEGORY_2">상품</label></th>
<td id="layout-1_1_2" colspan=4><input type=text  class="ub-control input-text " id="MENU_NAME" name="MENU_NAME" maxLength="20" metalength="20"                       style="text-align:left;width:195px;"><input type=hidden id="ID_ROW" name="ID_ROW"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">대</label></th>
<td id="layout-1_2_4" colspan=3 style=' vertical-align:Middle'><select id="MENU_CATEGORY_1" name="MENU_CATEGORY_1" class="ub-control select "     style="width:150px;" size="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label">중</label></th>
<td id="layout-1_3_6" colspan=3 style=' vertical-align:Middle'><select id="MENU_CATEGORY_2" name="MENU_CATEGORY_2" class="ub-control select "     style="width:220px;" size="1"></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">소</label></th>
<td id="layout-1_4_8" colspan=3 style=' vertical-align:Middle'><select id="MENU_CATEGORY_3" name="MENU_CATEGORY_3" class="ub-control select "     style="width:250px;" size="1"></select></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9" colspan=2><label id="LBL_GRADE" name="LBL_GRADE" class="ub-control label">멤버십</label></th>
<td id="layout-1_5_10" colspan=3></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_11" colspan=2><label id="LBL_CNT" name="LBL_CNT" class="ub-control label">적립개수</label></th>
<td id="layout-1_6_12"><input type=text  class="ub-control input-text " id="STAMP_CNT" name="STAMP_CNT" maxLength="2" metalength="2"      metaformat="number"                 style="text-align:right;width:50px;"><label class="ub-control label">개</label></td>
<th id="layout-1_6_13"><label id="LBL_USE" name="LBL_USE" class="ub-control label">사용여부</label></th>
<td id="layout-1_6_14"><select id="FG_USE" name="FG_USE" class="ub-control select "     style="width:120px;" size="1"></select></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button inner icon"     onclick="fnCheck('insert')">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
<span class="ub-control button inner icon" id="updateBtn"     onclick="fnCheck('update')">
    <a href="#none" title="변경"><span></span>변경</a>
</span>
</div>
</div>
<div class="ub-layout leftBox"   style="width:49%;"><div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon"     onclick="fnDelList('list_prod')">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_prod" name="list_prod"></table> 
	
</div>
</div>
</div>
<h2 class="ub-control title" for="exceptLayout" hfold="1">적립제외 매장</h2>
<div class="ub-layout " id="exceptLayout" name="exceptLayout"><table class="ub-control table normal " id="StoreExLayout">
<colgroup>
<col width="150px"/>
<col width="280px"/>
<col width="200px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" rowspan=3><label class="ub-control label">제외 매장 설정</label></th>
<td id="layout-1_1_2"><br/><h4 class="ub-control title">전체 매장</h4><br/><select id="TP_STOR_ALL" name="TP_STOR_ALL" class="ub-control select "     style="width:200px;" size="1"></select></td>
<td id="layout-1_1_3" rowspan=3 style='text-align:Center vertical-align:Top'><span class="ub-control button inner icon" id="addExcept"     onclick="fnAddAll()">    <a href="#none" title="전체 등록>>"><span></span>전체 등록>></a></span><br/><br/><span class="ub-control button inner icon" id="addExcept"     onclick="fnAddEx()">    <a href="#none" title="선택 등록>>"><span></span>선택 등록>></a></span><br/><br/><br/><br/><span class="ub-control button inner icon" id="delExcept"     onclick="fnDelAll();">    <a href="#none" title="<<전체 삭제"><span></span><<전체 삭제</a></span><br/><br/><span class="ub-control button inner icon" id="delExcept"     onclick="fnDelEx();">    <a href="#none" title="<<선택 삭제"><span></span><<선택 삭제</a></span></td>
<td id="layout-1_1_4"><h4 class="ub-control title">제외 매장</h4></td>
</tr>
<tr id="layout-1_2">
<td id="layout-1_2_5"><input type=text  class="ub-control input-text " id="NM_STORE_SEARCH" name="NM_STORE_SEARCH" maxLength="20" metalength="20"                       style="text-align:left;width:125px;"><span class="ub-control button inner icon"     onclick="searchStore();">    <a href="#none" title="검색"><span></span>검색</a></span></td>
<td id="layout-1_2_6"></td>
</tr>
<tr id="layout-1_3">
<td id="layout-1_3_7"><select id="CD_STOR_ALL" name="CD_STOR_ALL" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
<td id="layout-1_3_8"><select id="CD_STOR_EX" name="CD_STOR_EX" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave()">
    <a href="#none" title="저장"><span></span>저장</a>
</span>
</div>
</form>

<!-- layout-1 End -->
