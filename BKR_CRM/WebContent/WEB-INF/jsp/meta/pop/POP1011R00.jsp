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
	DataList _dl_CustManageRimsDAO_getOrderDetailRims = ViewUtil.getResult().getDataList("CustManageRimsDAO.getOrderDetailRims");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP1011R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">주문 상세</h1>
<h2 class="ub-control title" for="orderInfo" hfold="1">주문관리</h2>
<div class="ub-layout " id="orderInfo" name="orderInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="180px"/>
<col width="130px"/>
<col width="180px"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" style=' vertical-align:Middle'><label class="ub-control label">주문번호</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ORDER_NO" name="ORDER_NO"       value="${paramMap.ORDER_NO}"  readonly              style="text-align:left;width:205px;"   disabled></td>
<th id="layout-1_1_3" style=' vertical-align:Middle'><label class="ub-control label">포스 주문번호</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text "       value="${paramMap.POS_NO}"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5" style=' vertical-align:Middle'><label class="ub-control label">매장명</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "STOR_NM") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_2_7" style=' vertical-align:Middle'><label class="ub-control label">주문일자</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "DT_ORDER") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">결제구분</label></th>
<td id="layout-1_3_10"><select id="CD_PAY_WAY" name="CD_PAY_WAY" class="ub-control select "     style="width:220px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "CD_PAY_WAY") %>"              disabled></select></td>
<th id="layout-1_3_11" style=' vertical-align:Middle'><label class="ub-control label">상품금액</label></th>
<td id="layout-1_3_12"><input type=text  class="ub-control input-text " id="TOT_SALE_AMT" name="TOT_SALE_AMT"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "TOT_SALE_AMT") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label">총할인금액</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="TOT_DC_AMT" name="TOT_DC_AMT"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "TOT_DC_AMT") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_4_15"><label class="ub-control label">결제금액</label></th>
<td id="layout-1_4_16"><input type=text  class="ub-control input-text " id="ACTUAL_SALE_AMT" name="ACTUAL_SALE_AMT"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CustManageRimsDAO_getOrderDetailRims, "ACTUAL_SALE_AMT") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="couponInfo" hfold="1">사용쿠폰</h2>
<div class="ub-layout " id="couponInfo" name="couponInfo"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_coupon" name="list_coupon"></table> 
	
</div>
</div>
<h2 class="ub-control title" for="prodInfo" hfold="1">상품</h2>
<div class="ub-layout " id="prodInfo" name="prodInfo"><div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_prod" name="list_prod"></table> 
	
</div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="saveBtn"     onclick="fnSave()">
    <a href="#none" title="선택"><span></span>선택</a>
</span>
<span class="ub-control button bottom icon"     onclick="self.close();">
    <a href="#none" title="닫기"><span></span>닫기</a>
</span>
</div>
<form id="searchForm" name="searchForm"><input type=hidden id="ORDER_NO" name="ORDER_NO"    value="${paramMap.ORDER_NO}">
<input type=hidden id="STOR_CD" name="STOR_CD"    value="${paramMap.STOR_CD}">
<input type=hidden id="POS_NO" name="POS_NO"    value="${paramMap.POS_NO}">
<input type=hidden id="SALE_DT" name="SALE_DT"    value="${paramMap.SALE_DT}">
<input type=hidden id="ID_MEMBER" name="ID_MEMBER"    value="${paramMap.ID_MEMBER}">
</form>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging"></div>

<!-- layout-1 End -->
