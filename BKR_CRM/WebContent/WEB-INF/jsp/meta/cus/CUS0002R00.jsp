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
	DataList _dl_CustManageDAO_getCustDetail = ViewUtil.getResult().getDataList("CustManageDAO.getCustDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUS0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">회원 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="detailForm" name="detailForm"><div class="ub-layout "><h2 class="ub-control title" for="cusInfo" hfold="1">기본정보</h2>
<div class="ub-layout details" id="cusInfo" name="cusInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="335px"/>
<col width="120px"/>
<col width="300px"/>
<col width="130px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">회원PK</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ID_MEMBER" name="ID_MEMBER"       value="${paramMap.ID_MEMBER}"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">회원명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_MEMBER" name="NM_MEMBER"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "NM_MEMBER") %>"  readonly              style="text-align:left;width:100px;"   disabled><span class="ub-control button inner icon" id="nmChange">    <a href="#none" title="이름변경"><span></span>이름변경</a></span></td>
<th id="layout-1_1_5"><label class="ub-control label">회원상태</label></th>
<td id="layout-1_1_6"><select id="CD_STATUS" name="CD_STATUS" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_STATUS") %>"></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">생년월일</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="DT_BIRTHDAY" name="DT_BIRTHDAY"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_BIRTHDAY") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_2_9"><label class="ub-control label">성별</label></th>
<td id="layout-1_2_10"><select id="CD_GENDER" name="CD_GENDER" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_GENDER") %>"  disabled            disabled></select></td>
<th id="layout-1_2_11"><label class="ub-control label">연령대</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="CD_AGE_GRADE" name="CD_AGE_GRADE"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_AGE") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">회원등급</label></th>
<td id="layout-1_3_14"><select id="CD_GRADE" name="CD_GRADE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_GRADE") %>"></select></td>
<th id="layout-1_3_15"><label class="ub-control label">스템프개수</label></th>
<td id="layout-1_3_16"><input type=text  class="ub-control input-text " id="CNT_STAMP" name="CNT_STAMP"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CNT_STAMP") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_3_17"></th>
<td id="layout-1_3_18"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="cusInfo2" hfold="1">연락처정보</h2>
<div class="ub-layout details" id="cusInfo2" name="cusInfo2"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="335px"/>
<col width="120px"/>
<col width="300px"/>
<col width="130px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">이메일</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DS_EMAIL") %>"  readonly              style="text-align:left;width:200px;"   disabled><span class="ub-control button inner icon" id="emailChange">    <a href="#none" title="이메일 변경"><span></span>이메일 변경</a></span></td>
<th id="layout-1_1_3"><label class="ub-control label">이메일 수신여부</label></th>
<td id="layout-1_1_4"><select id="YN_EMAIL_RECV" name="YN_EMAIL_RECV" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "YN_EMAIL_RECV") %>"></select></td>
<th id="layout-1_1_5"><label class="ub-control label">이메일 수신허용일</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="DT_EMAIL_RECV" name="DT_EMAIL_RECV"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_EMAIL_RECV") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="NO_PHONE" name="NO_PHONE"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "NO_PHONE") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_2_9"><label class="ub-control label">SMS 수신여부</label></th>
<td id="layout-1_2_10"><select id="YN_SMS_RECV" name="YN_SMS_RECV" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "YN_SMS_RECV") %>"></select></td>
<th id="layout-1_2_11"><label class="ub-control label">SMS 수신허용일</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="DT_SMS_RECV" name="DT_SMS_RECV"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_SMS_RECV") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">푸쉬토큰PK</label></th>
<td id="layout-1_3_14" colspan=5><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "TOKEN_PK") %>"  readonly              style="text-align:left;width:420px;"   disabled></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_15"><label class="ub-control label">대표 주소</label></th>
<td id="layout-1_4_16" colspan=5><input type=text  class="ub-control input-text " id="ZIP_CODE" name="ZIP_CODE"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "ZIP_CODE") %>"  readonly              style="text-align:left;width:52px;"   disabled><input type=text  class="ub-control input-text " id="DS_ADDR" name="DS_ADDR"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DS_ADDR") %>"  readonly              style="text-align:left;width:320px;"   disabled><input type=text  class="ub-control input-text " id="DS_ADDR_DTL" name="DS_ADDR_DTL"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DS_ADDR_DTL") %>"  readonly              style="text-align:left;width:260px;"   disabled></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="accountInfo" hfold="1">계정정보</h2>
<div class="ub-layout " id="accountInfo" name="accountInfo"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="335px"/>
<col width="120px"/>
<col width="300px"/>
<col width="130px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">회원ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DS_EMAIL") %>"  readonly              style="text-align:left;width:200px;"   disabled></td>
<th id="layout-1_1_3"><label class="ub-control label">비밀번호 변경일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DT_CHNG_PASSWD" name="DT_CHNG_PASSWD"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_CHNG_PASSWD") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_1_5"><label class="ub-control label">최종로그인</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="DT_LOGIN_LAST" name="DT_LOGIN_LAST"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_LAST_LOGIN") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">가입경로</label></th>
<td id="layout-1_2_8"><select id="CD_JOIN_PATH" name="CD_JOIN_PATH" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_JOIN_PATH") %>"></select></td>
<th id="layout-1_2_9"><label class="ub-control label">가입사이트</label></th>
<td id="layout-1_2_10"><select id="CD_JOIN_SITE" name="CD_JOIN_SITE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_JOIN_SITE") %>"></select></td>
<th id="layout-1_2_11"><label class="ub-control label">가입일</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="DT_JOIN" name="DT_JOIN"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_JOIN") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">휴면계정여부</label></th>
<td id="layout-1_3_14"><select id="YN_SLEEP" name="YN_SLEEP" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "CD_DORMANCY") %>"></select></td>
<th id="layout-1_3_15"><label class="ub-control label">개인정보<br />처리방침동의</label></th>
<td id="layout-1_3_16"><select id="YN_PRIVACY_AGREE" name="YN_PRIVACY_AGREE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "YN_PRIVACY_AGREE") %>"></select></td>
<th id="layout-1_3_17"><label class="ub-control label">버거킹이용약관<br />동의여부</label></th>
<td id="layout-1_3_18"><select id="YN_BKR_AGREE" name="YN_BKR_AGREE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "YN_BKR_AGREE") %>"></select></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label">휴면계정 처리일</label></th>
<td id="layout-1_4_20"><input type=text  class="ub-control input-text " id="DT_SLEEP" name="DT_SLEEP"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_DORMANCY") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_4_21"><label class="ub-control label">개인정보<br />처리방침동의일</label></th>
<td id="layout-1_4_22"><input type=text  class="ub-control input-text " id="DT_PRIVACY_AGREE" name="DT_PRIVACY_AGREE"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_PRIVACY_AGREE") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_4_23"><label class="ub-control label">버거킹이용약관<br />동의일</label></th>
<td id="layout-1_4_24"><input type=text  class="ub-control input-text " id="DT_BKR_AGREE" name="DT_BKR_AGREE"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_BKR_AGREE") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_25"><label class="ub-control label">실명인증여부</label></th>
<td id="layout-1_5_26"><select id="YN_CONFIRM" name="YN_CONFIRM" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "YN_CONFIRM") %>"></select></td>
<th id="layout-1_5_27"><label class="ub-control label">실명인증일</label></th>
<td id="layout-1_5_28"><input type=text  class="ub-control input-text " id="DT_CONFIRM" name="DT_CONFIRM"       value="<%=JspUtils.getDefaultValue(_dl_CustManageDAO_getCustDetail, "DT_CONFIRM") %>"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_5_29"></th>
<td id="layout-1_5_30"></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout " id="cardLayout" name="cardLayout"><h2 class="ub-control title" for="cardInfo" hfold="1">선불카드</h2>
<div class="ub-layout list" id="cardInfo" name="cardInfo"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list_card" name="list_card"></table> 
	
</div>
</div>
</div>
<div class="ub-layout floatBox"><div class="ub-layout leftBox"><span class="ub-control button inner icon" id="delBtn">
    <a href="#none" title="회원탈퇴"><span></span>회원탈퇴</a>
</span>
</div>
<div class="ub-layout rightBox"><span class="ub-control button inner icon"     onclick="fnAddStamp();">
    <a href="#none" title="스탬프 추가"><span></span>스탬프 추가</a>
</span>
</div>
</div>
</form>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tabs" name="tabs" class="ub-control tab"></div>

<!-- layout-1 End -->
