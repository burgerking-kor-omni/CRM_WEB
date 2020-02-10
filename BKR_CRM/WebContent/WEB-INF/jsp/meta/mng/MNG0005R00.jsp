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
	DataList _dl_stampManageDAO_getTbsStamp = ViewUtil.getResult().getDataList("stampManageDAO.getTbsStamp");
	DataList _dl_stampManageDAO_getTbsStampRecord = ViewUtil.getResult().getDataList("stampManageDAO.getTbsStampRecord");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : MNG0005R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">스탬프 기준 이력관리</h1>
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
<th id="layout-1_1_1"><label class="ub-control label">구분</label></th>
<td id="layout-1_1_2" colspan=2><input type=text  class="ub-control input-text " id="TP_SET" name="TP_SET"       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStamp, "TP_SET") %>"  readonly              style="text-align:left;width:100px;"   disabled><input type=hidden id="NO_STAMP_RECODE" name="NO_STAMP_RECODE"    value="${paramMap.NO_STAMP_RECODE}"></td>
<th id="layout-1_1_3"><label class="ub-control label">적용기간</label></th>
<td id="layout-1_1_4" colspan=3><input type=text class="ub-control input-text calendar " id="DT_APPLY_START" name="DT_APPLY_START"       metaformat="date" value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "DT_APPLY_START") %>"  readonly              style="text-align:left;width:75px;"   disabled><label class="ub-control label"      style="width:100px;"    metaformat="date"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_APPLY_END" name="DT_APPLY_END"       metaformat="date" value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "DT_APPLY_END") %>"  readonly              style="text-align:left;width:75px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_2_6" colspan=2><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "DS_TITLE") %>"  readonly              style="text-align:left;width:250px;"   disabled></td>
<th id="layout-1_2_7"><label class="ub-control label">사용여부</label></th>
<td id="layout-1_2_8" colspan=3><select id="FG_USE_MAIN" name="FG_USE_MAIN" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "FG_USE") %>"     metaessential="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9" rowspan=4><label class="ub-control label">적립채널</label></th>
<th id="layout-1_3_10"><label class="ub-control label">딜리버리</label></th>
<td id="layout-1_3_11"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0101"><label>POS</label></input></td>
<td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0102"><label>KIOSK</label></input></td>
<td id="layout-1_3_13"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0103"><label>APP</label></input></td>
<td id="layout-1_3_14"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0104"><label>Web</label></input></td>
<td id="layout-1_3_15"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0105"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_16"><label class="ub-control label">킹오더</label></th>
<td id="layout-1_4_17"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0201"><label>POS</label></input></td>
<td id="layout-1_4_18"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0202"><label>KIOSK</label></input></td>
<td id="layout-1_4_19"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0203"><label>APP</label></input></td>
<td id="layout-1_4_20"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0204"><label>Web</label></input></td>
<td id="layout-1_4_21"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0205"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_22"><label class="ub-control label">킹오더 DT</label></th>
<td id="layout-1_5_23"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0301"><label>POS</label></input></td>
<td id="layout-1_5_24"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0302"><label>KIOSK</label></input></td>
<td id="layout-1_5_25"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0303"><label>APP</label></input></td>
<td id="layout-1_5_26"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0304"><label>Web</label></input></td>
<td id="layout-1_5_27"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0305"><label>Mobile Web</label></input></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_28"><label class="ub-control label">매장</label></th>
<td id="layout-1_6_29"><input class="ub-control input-checkbox" type="checkbox" id="POS" name="POS"     value="0401"><label>POS</label></input></td>
<td id="layout-1_6_30"><input class="ub-control input-checkbox" type="checkbox" id="KIOSK" name="KIOSK"     value="0402"><label>KIOSK</label></input></td>
<td id="layout-1_6_31"><input class="ub-control input-checkbox" type="checkbox" id="APP" name="APP"     value="0403"><label>APP</label></input></td>
<td id="layout-1_6_32"><input class="ub-control input-checkbox" type="checkbox" id="WEB" name="WEB"     value="0404"><label>Web</label></input></td>
<td id="layout-1_6_33"><input class="ub-control input-checkbox" type="checkbox" id="MOBILEWEB" name="MOBILEWEB"     value="0405"><label>Mobile Web</label></input></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="standardInfo2" hfold="1">적립기준</h2>
<div class="ub-layout floatBox" id="standardInfo2" name="standardInfo2"><div class="ub-layout rightBox"   style="width:49%;"><table class="ub-control table normal " id="stdlayout">
<colgroup>
<col />
<col width="70px"/>
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" rowspan=3><label id="LBL_CATEGORY" name="LBL_CATEGORY" class="ub-control label"             for="MENU_CATEGORY_2">상품</label></th>
<th id="layout-1_1_2"><label class="ub-control label">대</label></th>
<td id="layout-1_1_3" colspan=3><select id="MENU_CATEGORY_1" name="MENU_CATEGORY_1" class="ub-control select readonly"     style="width:150px;" size="1"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_4"><label class="ub-control label">중</label></th>
<td id="layout-1_2_5" colspan=3><select id="MENU_CATEGORY_2" name="MENU_CATEGORY_2" class="ub-control select readonly"     style="width:220px;" size="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_6"><label class="ub-control label">소</label></th>
<td id="layout-1_3_7" colspan=3><select id="MENU_CATEGORY_3" name="MENU_CATEGORY_3" class="ub-control select readonly"     style="width:250px;" size="1"></select><input type=hidden id="ID_ROW" name="ID_ROW"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_8" colspan=2><label id="LBL_GRADE" name="LBL_GRADE" class="ub-control label">멤버십</label></th>
<td id="layout-1_4_9" colspan=3></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_10" colspan=2><label id="LBL_CNT" name="LBL_CNT" class="ub-control label">적립개수</label></th>
<td id="layout-1_5_11"><input type=text  class="ub-control input-text " id="STAMP_CNT" name="STAMP_CNT" maxLength="2" metalength="2"         readonly              style="text-align:right;width:50px;"   disabled><label class="ub-control label">개</label></td>
<th id="layout-1_5_12"><label id="LBL_USE" name="LBL_USE" class="ub-control label">사용여부</label></th>
<td id="layout-1_5_13"><select id="FG_USE" name="FG_USE" class="ub-control select readonly"     style="width:120px;" size="1"></select></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout leftBox"   style="width:49%;"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_prod" name="list_prod"></table> 
	
</div>
</div>
</div>
<h2 class="ub-control title" for="exceptLayout" hfold="1">적립제외 매장</h2>
<div class="ub-layout " id="exceptLayout" name="exceptLayout"><table class="ub-control table normal ">
<colgroup>
<col width="200px"/>
<col width="280px"/>
<col width="100px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">제외 매장 설정</label></th>
<td id="layout-1_1_2"><br/><h4 class="ub-control title">전체 매장</h4><br/><br/><select id="CD_STOR_ALL" name="CD_STOR_ALL" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
<td id="layout-1_1_3"></td>
<td id="layout-1_1_4"><br/><h4 class="ub-control title">제외 매장</h4><br/><br/><select id="CD_STOR_EX" name="CD_STOR_EX" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
</tr>
</tbody>
</table>
 
</div>
<table class="ub-control table normal " id="stdlayout">
<colgroup>
<col width="120px"/>
<col width="280px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">최초등록자</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "NM_REG_USER") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_1_3"><label id="LBL_USE" name="LBL_USE" class="ub-control label"></label><label class="ub-control label">최초등록일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "DT_REG") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">최종수정자</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "NM_UPT_USER") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_2_7"><label id="LBL_USE" name="LBL_USE" class="ub-control label"></label><label class="ub-control label">최종수정일</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_stampManageDAO_getTbsStampRecord, "DT_UPT") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="self.close()">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>

<!-- layout-1 End -->
