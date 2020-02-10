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
 
   - PAGE ID : SYS0149R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">사용자정보 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnList">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col width="40%"/>
<col width="15%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="LOGIN_ID">ID (사번)</label></th>
<td id="layout-1_1_2" colspan=3><input type=text  class="ub-control input-text " id="LOGIN_ID" name="LOGIN_ID" maxLength="20" metalength="20"            metaessential="1"           style="text-align:left;width:120px;"><span class="ub-control button inner icon" id="checkBtn">    <a href="#none" title="Add"><span class="ico-add"></span>중복확인</a></span><label id="dupAlertMsg" name="dupAlertMsg" class="ub-control label"></label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="USER_NM">이름</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM" maxLength="20" metalength="20"            metaessential="1"           style="text-align:left;width:120px;"></td>
<th id="layout-1_2_5"><label class="ub-control label"             for="PASSWD">비밀번호</label></th>
<td id="layout-1_2_6"><input type=password  class="ub-control input-text " id="PASSWD" name="PASSWD" maxLength="15" metalength="15"     style="width:120px;"        metaessential="1"><label id="txt_pass" name="txt_pass" class="ub-control label"     style="color:red;">(영문, 숫자 포함 10자리)</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label class="ub-control label"             for="DEPT_NM">부서</label></th>
<td id="layout-1_3_8"><input type=text  class="ub-control input-text " id="DEPT_NM" name="DEPT_NM"         readonly   metaessential="1"           style="text-align:left;width:120px;"><input type=hidden id="DEPT_ID" name="DEPT_ID"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="searchDept" name="searchDept"><span>@@</span></a></td>
<th id="layout-1_3_9"><label class="ub-control label"             for="CD_DUTY">직책</label></th>
<td id="layout-1_3_10"><select id="CD_DUTY" name="CD_DUTY" class="ub-control select "     style="width:135px;" size="1"       metaessential="0"></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_11"><label class="ub-control label"             for="MOBILE_NO">핸드폰 번호</label></th>
<td id="layout-1_4_12"><input type=text  class="ub-control input-text " id="MOBILE_NO" name="MOBILE_NO"            metaessential="0"           style="text-align:left;width:120px;"></td>
<th id="layout-1_4_13"><label class="ub-control label"             for="EMAIL_DS">이메일</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="EMAIL_DS" name="EMAIL_DS"            metaessential="0"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_15"><label class="ub-control label"             for="INCUMBENT_CD">재직구분</label></th>
<td id="layout-1_5_16"><select id="INCUMBENT_CD" name="INCUMBENT_CD" class="ub-control select "     style="width:135px;" size="1"       metaessential="1"></select></td>
<th id="layout-1_5_17"></th>
<td id="layout-1_5_18"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_19"><label class="ub-control label"             for="CD_ROLE_LIST">사용자권한</label></th>
<td id="layout-1_6_20"><select id="CD_ROLE" name="CD_ROLE" class="ub-control select "     style="width:135px;" size="1"       metaessential="0"></select><span class="ub-control button inner icon"     onclick="fnAdd();">    <a href="#none" title="추가"><span></span>추가</a></span><span class="ub-control button inner icon"     onclick="fnDel();">    <a href="#none" title="삭제"><span></span>삭제</a></span><br/><br/><select id="CD_ROLE_LIST" name="CD_ROLE_LIST" multiple class="ub-control select-multiple"     style="width:255px;"  size="4"         metaessential="0"></select></td>
<th id="layout-1_6_21"></th>
<td id="layout-1_6_22"></td>
</tr>
</tbody>
</table>
 
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnRegist">
    <a href="#none" title="Save"><span class="ico-save"></span>등록</a>
</span>
</div>
</div>

<!-- layout-1 End -->
