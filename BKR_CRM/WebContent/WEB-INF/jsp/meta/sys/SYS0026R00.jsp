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
	DataList _dl_UserManageInquiry_getUserDetail = ViewUtil.getResult().getDataList("UserManageInquiry.getUserDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0026R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">사용자정보 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col width="35%"/>
<col width="15%"/>
<col width="35%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">이름 </label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "USER_NM") %>"  readonly              style="text-align:left;width:130px;"><input type=hidden id="USER_ID" name="USER_ID"    value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "USER_ID") %>"></td>
<th id="layout-1_1_3"><label class="ub-control label">부서</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "DEPT_NM") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">사번 </label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="EMP_NO" name="EMP_NO"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "EMP_NO") %>"  readonly              style="text-align:left;width:130px;"><input type=hidden id="LOGIN_ID" name="LOGIN_ID"    value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "EMP_NO") %>"></td>
<th id="layout-1_2_7"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="PHONE_NO" name="PHONE_NO"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "PHONE_NO") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">휴대전화</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="MOBILE_NO" name="MOBILE_NO"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "MOBILE_NO") %>"  readonly              style="text-align:left;width:130px;"></td>
<th id="layout-1_3_11"><label class="ub-control label">내선번호</label></th>
<td id="layout-1_3_12"><input type=text  class="ub-control input-text " id="OFFICE_PHONE_NO" name="OFFICE_PHONE_NO"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "OFFICE_PHONE_NO") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label">팩스번호</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="FAX_NO" name="FAX_NO"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "FAX_NO") %>"  readonly              style="text-align:left;width:130px;"></td>
<th id="layout-1_4_15"><label class="ub-control label">이메일</label></th>
<td id="layout-1_4_16"><input type=text  class="ub-control input-text " id="EMAIL_DS" name="EMAIL_DS"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "EMAIL_DS") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17"><label class="ub-control label">직위</label></th>
<td id="layout-1_5_18"><input type=text  class="ub-control input-text " id="POSITION_NM" name="POSITION_NM"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "POSITION_NM") %>"  readonly              style="text-align:left;width:130px;"></td>
<th id="layout-1_5_19"><label class="ub-control label">재직여부</label></th>
<td id="layout-1_5_20"><input type=text  class="ub-control input-text " id="INCUMBENT_CD" name="INCUMBENT_CD"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "INCUMBENT_CD") %>"                style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_21"><label class="ub-control label">담당업무</label></th>
<td id="layout-1_6_22" colspan=3><input type=text  class="ub-control input-text " id="CHRG_CD" name="CHRG_CD"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "CHRG_CD") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_23"><label class="ub-control label">입사일</label></th>
<td id="layout-1_7_24"><input type=text  class="ub-control input-text " id="JOIN_DT" name="JOIN_DT"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "JOIN_DT") %>"  readonly              style="text-align:left;width:130px;"></td>
<th id="layout-1_7_25"><label class="ub-control label">퇴사일</label></th>
<td id="layout-1_7_26"><input type=text  class="ub-control input-text " id="RETIRE_DT" name="RETIRE_DT"       value="<%=JspUtils.getDefaultValue(_dl_UserManageInquiry_getUserDetail, "RETIRE_DT") %>"  readonly              style="text-align:left;width:130px;"></td>
</tr>
</tbody>
</table>
 
<h2 class="ub-control title">권한그룹</h2>
<table class="ub-control table normal ">
<colgroup>
<col width="200px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">권한그룹</label></th>
<td id="layout-1_1_2"><div class="ub-layout floatBox"><div class="ub-layout leftBox"><select id="AUTH_LIST" name="AUTH_LIST" multiple class="ub-control select-multiple"     style="width:300px;"  size="10"></select></div><div class="ub-layout rightBox"><a href="#none"  class="ub-control button imgBtn img-plus" id="addAuthGroup" name="addAuthGroup"><span></span></a><a href="#none"  class="ub-control button imgBtn img-minus" id="removeAuthGroup" name="removeAuthGroup"><span></span></a></div></div></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="pw_reset">
    <a href="#none" title="Save"><span class="ico-save"></span>비밀번호 초기화</a>
</span>
<span class="ub-control button bottom icon" id="saveBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>권한 저장</a>
</span>
</div>
</div>

<!-- layout-1 End -->
