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
 
   - PAGE ID : VOC0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title" id="lbl_title" name="lbl_title">VOC 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="detailForm" name="detailForm"><h2 class="ub-control title">주문정보</h2>
<div class="ub-layout "><table class="ub-control table normal " id="ORDER_INFO">
<colgroup>
<col width="120px"/>
<col width="360px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">주문번호</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ORDER_NO" name="ORDER_NO" maxLength="20" metalength="20"                       style="text-align:left;width:150px;"><span class="ub-control button inner icon" id="popupDetail"     onclick="fnShowDetail()">    <a href="#none" title="검색"><span></span>검색</a></span><input type=hidden id="FG_ORDER" name="FG_ORDER"    value="N"><input type=hidden id="CD_STATUS" name="CD_STATUS"><input type=hidden id="CALL_ORDER_NO" name="CALL_ORDER_NO"><input type=hidden id="POS_ORDER_NO" name="POS_ORDER_NO"><span class="ub-control button inner icon" id="resetBtn"     onclick="uxl.reload();">    <a href="#none" title="초기화"><span></span>초기화</a></span></td>
<th id="layout-1_1_3"><label class="ub-control label">접수채널</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="BIZ_CHNN_NM" name="BIZ_CHNN_NM"       value="CRM"  readonly              style="text-align:left;width:120px;"><input type=hidden id="BIZ_CHNN" name="BIZ_CHNN"    value="05"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">결재방법</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="PAYMENT_TYPE_SUB" name="PAYMENT_TYPE_SUB"         readonly              style="text-align:left;width:150px;"><input type=hidden id="PAYMENT_TYPE" name="PAYMENT_TYPE"></td>
<th id="layout-1_2_7"><label class="ub-control label">주문일자</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="DT_ORDER" name="DT_ORDER"         readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">결재금액</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text " id="PAYMENT_PRC" name="PAYMENT_PRC"      metaformat="number"   readonly              style="text-align:left;width:100px;"><label class="ub-control label">원</label></td>
<th id="layout-1_3_11"><label id="MENU_CODE_TXT" name="MENU_CODE_TXT" class="ub-control label">상품코드</label></th>
<td id="layout-1_3_12"><input type=text  class="ub-control input-text " id="MENU_CODE" name="MENU_CODE"         readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label"             for="STOR_NM">매장</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text " id="STOR_NM" name="STOR_NM" maxLength="10" metalength="10"       value="${paramMap.STOR_NM}"                style="text-align:left;width:100px;"><input type=text  class="ub-control input-text " id="NM_STORE" name="NM_STORE"       value="${paramMap.NM_STORE}"  readonly              style="text-align:left;width:100px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="img" name="img"><span>@@</span></a><input type=hidden id="STOR_CD" name="STOR_CD"></td>
<th id="layout-1_4_15"><label class="ub-control label">상품명</label></th>
<td id="layout-1_4_16"><input type=text  class="ub-control input-text " id="MENU_NAME" name="MENU_NAME" maxLength="20" metalength="20"                       style="text-align:left;width:120px;"><input type=text  class="ub-control input-text " id="MENU_NM" name="MENU_NM"         readonly              style="text-align:left;width:200px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="imgMenu" name="imgMenu"><span>@@</span></a><input type=hidden id="MENU_CD" name="MENU_CD"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">회원정보</h2>
<div class="ub-layout "><table class="ub-control table normal " id="memberInfo">
<colgroup>
<col width="120px"/>
<col width="180px"/>
<col width="120px"/>
<col width="180px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">회원여부</label></th>
<td id="layout-1_1_2"><input class="ub-control radio" type=radio  id="YM_MEMBER" name="YM_MEMBER"     value="Y"><label> Y</label><input class="ub-control radio" type=radio  id="YM_MEMBER" name="YM_MEMBER"    checked value="N"><label> N</label></td>
<th id="layout-1_1_3"></th>
<td id="layout-1_1_4"></td>
<td id="layout-1_1_5"></td>
<td id="layout-1_1_6"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label"             for="NM_CUST">이름</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="NM_CUST" name="NM_CUST" maxLength="10" metalength="10"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_2_9"><label class="ub-control label"             for="NO_PHONE">전화번호</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="NO_PHONE" name="NO_PHONE"            metaessential="1"           style="text-align:left;width:100px;"></td>
<th id="layout-1_2_11"><label class="ub-control label"             for="DS_EMAIL">이메일</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL" maxLength="50" metalength="50"                       style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">회원PK</label></th>
<td id="layout-1_3_14"><input type=text  class="ub-control input-text " id="ID_MEMBER" name="ID_MEMBER"                       style="text-align:left;width:100px;"></td>
<td id="layout-1_3_15"></td>
<td id="layout-1_3_16"></td>
<td id="layout-1_3_17"></td>
<td id="layout-1_3_18"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">등록정보</h2>
<div class="ub-layout " id="regInfo" name="regInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CD_VOC_CAUSE_2">유형</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_CAUSE" name="NM_CAUSE" maxLength="15" metalength="15"                       style="text-align:left;width:100px;"><select id="CD_VOC_CAUSE_1" name="CD_VOC_CAUSE_1" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="${paramMap.CD_VOC_CAUSE_1}"></select><select id="CD_VOC_CAUSE_2" name="CD_VOC_CAUSE_2" class="ub-control select "     style="width:160px;" size="1"       metaessential="1"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DT_VOC_REG">발생일자</label></th>
<td id="layout-1_2_4"><input type=text class="ub-control input-text calendar " id="DT_VOC_REG" name="DT_VOC_REG"       metaformat="date" value="${paramMap.TODAY}"     metaessential="1"           style="text-align:left;width:70px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:600px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="DS_CONT">내용</label></th>
<td id="layout-1_4_8"><textarea class="ub-control textarea " id="DS_CONT" name="DS_CONT"  metalength="4000"      style="width:600px;" rows="5"      metaessential="1"            rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave();">
    <a href="#none" title="Register"><span class="ico-register"></span>등록</a>
</span>
</div>

<!-- layout-1 End -->
