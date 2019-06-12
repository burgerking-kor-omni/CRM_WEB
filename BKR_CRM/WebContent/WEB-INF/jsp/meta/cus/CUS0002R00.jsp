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
 
   - PAGE ID : CUS0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">고객 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="detailForm" name="detailForm"><h2 class="ub-control title" for="cusInfo" hfold="1">기본정보</h2>
<div class="ub-layout details" id="cusInfo" name="cusInfo"><table class="ub-control table normal " id="cusTable">
<colgroup>
<col width="120px"/>
<col width="300px"/>
<col width="120px"/>
<col width="300px"/>
<col width="125px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">고객 번호</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="20180620001"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">고객명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_CUST" name="NM_CUST"       value="홍길동"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">성별</label></th>
<td id="layout-1_1_6"><select id="CD_GENDER" name="CD_GENDER" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="N"  disabled></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">고객 구분</label></th>
<td id="layout-1_2_8"><select id="TP_CUST" name="TP_CUST" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="N"  disabled></select></td>
<th id="layout-1_2_9"><label class="ub-control label">주민번호</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text "       value="900101-1234567"  readonly              style="text-align:left;width:100px;"   disabled></td>
<th id="layout-1_2_11"><label class="ub-control label">고객성향</label></th>
<td id="layout-1_2_12"><select id="CD_CUST_INCLN" name="CD_CUST_INCLN" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">내/외국인 구분</label></th>
<td id="layout-1_3_14"><select id="FG_DOMESTIC_CUST" name="FG_DOMESTIC_CUST" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
<th id="layout-1_3_15"><label class="ub-control label">생일</label></th>
<td id="layout-1_3_16"><input type=text class="ub-control input-text calendar "                        style="text-align:left;width:100px;"><input class="ub-control radio" type=radio     checked><label> 양력</label><input class="ub-control radio" type=radio><label> 음력</label></td>
<th id="layout-1_3_17"><label class="ub-control label">직업</label></th>
<td id="layout-1_3_18"><input type=text  class="ub-control input-text "       value="직장인"                style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="cusInfo2" hfold="1">연락처정보</h2>
<div class="ub-layout " id="cusInfo2" name="cusInfo2"><table class="ub-control table normal " id="cusTable">
<colgroup>
<col width="120px"/>
<col width="300px"/>
<col width="120px"/>
<col width="300px"/>
<col width="125px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">이메일</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="abcd"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">Email 수신여부</label></th>
<td id="layout-1_1_4"><select id="FG_ACCEPT_EMAIL" name="FG_ACCEPT_EMAIL" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
<th id="layout-1_1_5"><label class="ub-control label">Email 수신허용일</label></th>
<td id="layout-1_1_6"><input type=text class="ub-control input-text calendar "       metaformat="date"                 style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " maxLength="13" metalength="13"       value="010-1234-5678"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_2_9"><label class="ub-control label">SMS 수신여부</label></th>
<td id="layout-1_2_10"><select id="FG_ACCEPT_SMS" name="FG_ACCEPT_SMS" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="N"  disabled></select></td>
<th id="layout-1_2_11"><label class="ub-control label">SMS 수신허용일</label></th>
<td id="layout-1_2_12"><input type=text class="ub-control input-text calendar "       metaformat="date"                 style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">푸쉬 허용여부</label></th>
<td id="layout-1_3_14"><input class="ub-control input-checkbox" type="checkbox"    checked><label> 버거킹 소식</label></input><input class="ub-control input-checkbox" type="checkbox"    checked><label> 광고 소식</label></input></td>
<td id="layout-1_3_15"></td>
<td id="layout-1_3_16"></td>
<td id="layout-1_3_17"></td>
<td id="layout-1_3_18"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label">대표 주소</label></th>
<td id="layout-1_4_20" colspan=5><input type=text  class="ub-control input-text " id="ID_ADDR" name="ID_ADDR"                       style="text-align:left;width:50px;"><input type=text  class="ub-control input-text " id="DS_ADDR" name="DS_ADDR"                       style="text-align:left;width:200px;"><input type=text  class="ub-control input-text " id="DS_ADDR_DTL" name="DS_ADDR_DTL"                       style="text-align:left;width:300px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="fnSearch" name="fnSearch"><span>@@</span></a></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_21"><label class="ub-control label">직장 주소</label></th>
<td id="layout-1_5_22" colspan=5><input type=text  class="ub-control input-text " id="ID_ADDR_JOB" name="ID_ADDR_JOB"                       style="text-align:left;width:50px;"><input type=text  class="ub-control input-text " id="DS_ADDR_JOB" name="DS_ADDR_JOB"                       style="text-align:left;width:200px;"><input type=text  class="ub-control input-text " id="DS_ADDR_DTL_JOB" name="DS_ADDR_DTL_JOB"                       style="text-align:left;width:300px;"><a href="#none" title="search" class="ub-control button imgBtn img-search" id="fnSearch_job" name="fnSearch_job"><span>@@</span></a></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="cusInfo3" hfold="1">계정정보</h2>
<div class="ub-layout " id="cusInfo3" name="cusInfo3"><table class="ub-control table normal " id="cusTable">
<colgroup>
<col width="120px"/>
<col width="300px"/>
<col width="120px"/>
<col width="300px"/>
<col width="125px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">고객 ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text "       value="abcd@naver.com"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">비밀번호</label></th>
<td id="layout-1_1_4"><input type=password  class="ub-control input-text "     style="width:100px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">비밀번호 변경일</label></th>
<td id="layout-1_1_6"><label class="ub-control label">2018-08-17</label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">간편로그인 종류</label></th>
<td id="layout-1_2_8"><select id="CD_SNS_LOGIN" name="CD_SNS_LOGIN" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
<th id="layout-1_2_9"><label class="ub-control label">간편 로그인 ID</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text "       value="abcd@naver.com"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_2_11"><label class="ub-control label">간편 로그인 상태</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text "       value="정상"  readonly              style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label">가입경로</label></th>
<td id="layout-1_3_14"><select id="CD_JOIN_ROOT" name="CD_JOIN_ROOT" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
<th id="layout-1_3_15"><label class="ub-control label">로그인실패 횟수</label></th>
<td id="layout-1_3_16"><input type=text  class="ub-control input-text "      metaformat="number" value="0"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_3_17"></th>
<td id="layout-1_3_18"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_19"><label class="ub-control label">휴면계정 여부</label></th>
<td id="layout-1_4_20"><select id="CD_INACTIVE" name="CD_INACTIVE" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
<th id="layout-1_4_21"><label class="ub-control label">휴면계정 예정일</label></th>
<td id="layout-1_4_22"><input type=text  class="ub-control input-text "       value="2019-08-31"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_4_23"></th>
<td id="layout-1_4_24"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_25"><label class="ub-control label">탈퇴 여부</label></th>
<td id="layout-1_5_26"><select id="YN_DEL" name="YN_DEL" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="N"  disabled></select></td>
<th id="layout-1_5_27"><label class="ub-control label">탈퇴 일자</label></th>
<td id="layout-1_5_28"><input type=text  class="ub-control input-text "         readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_5_29"><label class="ub-control label">탈퇴사유</label></th>
<td id="layout-1_5_30"><select id="CD_DEL" name="CD_DEL" class="ub-control select "     style="width:115px;" size="1"    disabled></select></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="cusInfo4" hfold="1">현황정보</h2>
<div class="ub-layout details" id="cusInfo4" name="cusInfo4"><table class="ub-control table normal " id="cusTable">
<colgroup>
<col width="120px"/>
<col width="300px"/>
<col width="120px"/>
<col width="300px"/>
<col width="125px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">고객 등급</label></th>
<td id="layout-1_1_2"><select id="CD_GRADE" name="CD_GRADE" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="04"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">최종 구매일</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text "       value="2018-08-17"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_1_5"><label class="ub-control label">구매 누적액</label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text "      metaformat="number" value="120000"  readonly              style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">킹스템프 적립</label></th>
<td id="layout-1_2_8" colspan=5><input type=text  class="ub-control input-text "         readonly              style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="cusInfo5" hfold="1">관련자정보<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
<span class="ub-control button inner icon">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
</div>
</h2>
<div class="ub-layout list" id="cusInfo5" name="cusInfo5"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button inner icon" id="PASSRESET">
    <a href="#none" title="비밀번호 초기화"><span></span>비밀번호 초기화</a>
</span>
<span class="ub-control button inner icon" id="updBtn">
    <a href="#none" title="수정"><span></span>수정</a>
</span>
</div>
</form>
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:50px;text-align:center;"><h3 style="padding:10px;">Tab Control</h3></div>
<div id="tabs" name="tabs" class="ub-control tab"></div>

<!-- layout-1 End -->
