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
	DataList _dl_CustManageDAO_getDownStd = ViewUtil.getResult().getDataList("CustManageDAO.getDownStd");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUS0030R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">멤버십 기준관리</h1>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"   style="width:49%;"><h2 class="ub-control title">멤버십 기준 목록</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_grade" name="list_grade"></table> 
	
</div>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon" id="newBtn">
    <a href="#none" title="Add"><span class="ico-add"></span>신규추가</a>
</span>
</div>
</div>
<div class="ub-layout rightBox"   style="width:49%;"><form id="detailForm" name="detailForm"><div class="ub-layout "><h2 class="ub-control title">등급상세</h2>
<table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">등급코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_GRADE" name="CD_GRADE"         readonly              style="text-align:left;width:127px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="NM_MENBER_GRADE">등급명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_GRADE" name="NM_GRADE" maxLength="10" metalength="10"            metaessential="1"           style="text-align:left;width:127px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="CNT_MAX_STAMP,CNT_MIN_STAMP">등급별스탬프</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="CNT_MIN_STAMP" name="CNT_MIN_STAMP" maxLength="6" metalength="6"      metaformat="number"      metaessential="1"           style="text-align:left;width:40px;"><label class="ub-control label"> ~ </label><input type=text  class="ub-control input-text " id="CNT_MAX_STAMP" name="CNT_MAX_STAMP" maxLength="6" metalength="6"      metaformat="number"      metaessential="1"           style="text-align:left;width:40px;"></td>
<th id="layout-1_2_7"><label class="ub-control label"             for="RT_DSCNT_CART">장바구니할인</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="RT_DSCNT_CART" name="RT_DSCNT_CART" maxLength="2" metalength="2"      metaformat="number"      metaessential="1"           style="text-align:left;width:100px;"><label class="ub-control label"> %</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="FG_USE">사용여부</label></th>
<td id="layout-1_3_10" colspan=3><select id="FG_USE" name="FG_USE" class="ub-control select "     style="width:142px;" size="1"       metaessential="1"></select><br/><label id="lbl_warring" name="lbl_warring" class="ub-control label"><br />※ 등급별스탬프의 최소-최대 개수는 중복 or 비어있는 개수가 존재하면 안됩니다.</label></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="YN_NEW" name="YN_NEW"    value="N">
</div>
</form>
<h2 class="ub-control title">멤버십 공통</h2>
<div class="ub-layout "><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CD_DOWN_STAD">하향적용기간</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CD_DOWN_STAD" name="CD_DOWN_STAD" maxLength="2" metalength="2"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getDownStd, "CD_DOWN_STAD") %>"     metaessential="1"           style="text-align:left;width:127px;"><label class="ub-control label"> 개월</label><label id="lbl_warring2" name="lbl_warring2" class="ub-control label"> (최종 등급 변경일로부터의 기간을 의미)</label></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon" id="saveBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
<span class="ub-control button inner icon" id="delBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>삭제</a>
</span>
</div>
</div>
</div>

<!-- layout-1 End -->
