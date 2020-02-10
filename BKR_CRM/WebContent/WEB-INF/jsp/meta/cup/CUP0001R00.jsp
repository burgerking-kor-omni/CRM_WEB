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
	DataList _dl_CouponManageDAO_getDauPinConfig = ViewUtil.getResult().getDataList("CouponManageDAO.getDauPinConfig");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUP0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">다우 핀 가져오기 설정</h1>
<div class="ub-layout "><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<td id="layout-1_1_1"><label class="ub-control label">남은 쿠폰이 </label><input type=text  class="ub-control input-text " id="VAL_LIMIT_PIN" name="VAL_LIMIT_PIN" maxLength="5" metalength="5"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CouponManageDAO_getDauPinConfig, "VAL_LIMIT_PIN") %>"                style="text-align:left;width:100px;"><label class="ub-control label">개 미만일 때 </label><input type=text  class="ub-control input-text " id="VAL_BRING_PIN" name="VAL_BRING_PIN" maxLength="5" metalength="5"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CouponManageDAO_getDauPinConfig, "VAL_BRING_PIN") %>"                style="text-align:left;width:100px;"><label class="ub-control label"> 개 씩 1시간마다 가져오기</label></td>
</tr>
<tr id="layout-1_2">
<td id="layout-1_2_2"><label class="ub-control label">실시간 수동으로 가져오기 할 때, 기본 개수 </label><input type=text  class="ub-control input-text " id="VAL_BRING_PIN_MANUAL" name="VAL_BRING_PIN_MANUAL" maxLength="5" metalength="5"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CouponManageDAO_getDauPinConfig, "VAL_BRING_PIN_MANUAL") %>"                style="text-align:left;width:100px;"><label class="ub-control label"> 개</label></td>
</tr>
<tr id="layout-1_3">
<td id="layout-1_3_3"><label class="ub-control label">초기 다우 핀 가져오기 개수 </label><input type=text  class="ub-control input-text " id="VAL_FIRST_PIN" name="VAL_FIRST_PIN" maxLength="5" metalength="5"      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_CouponManageDAO_getDauPinConfig, "VAL_FIRST_PIN") %>"                style="text-align:left;width:100px;"><label class="ub-control label"> 개</label></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave()">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
