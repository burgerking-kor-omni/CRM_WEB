<%--
#*
 *  파 일 명 :  EXP9995.jsp
 *  설    명 :  화면 resize 테스트 
 *  작 성 자 :  황민국
 *  작 성 일 :  2017-02-13
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
%>
<%-- <script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/jquery-1.8.3.min.js'/>"></script>
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/jquery/ui/jquery-ui-1.9.2.min.js'/>"></script> --%>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : EXP9996R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================  -->

<!-- <div id="resizeTest" style="border:1px solid red">
 	<div class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se">
 	</div>
</div> -->	 
 

<div class="ub-layout button top">
<span class="ub-control button top icon" id="btnBuildMeta">
    <a href="#none" title="Build Meta Jsp"><ub:message code="button.APM0001.make.meta.jsp" text="MetaJSP생성"/></a>
</span>
<span class="ub-control button top icon" id="btnRemoveMeta">
    <a href="#none" title="Remove Meta Jsp"><ub:message code="button.APM0001.remove.meta.jsp" text="MetaJSP삭제"/></a>
</span>
<span class="ub-control button top icon" id="btnBuildXml">
    <a href="#none" title="Build All Xml"><ub:message code="button.APM0001.make.all.xml" text="전체XML생성"/></a>
</span>
<!-- <span class="ub-control button top icon" id="btnRemoveXml"> -->
<!--     <a href="#none" title="Remove All Xml"><ub:message code="button.APM0001.remove.all.xml" text="전체XML삭제"/></a> -->
<!-- </span> -->
<span class="ub-control button top icon" id="btnScreenCache">
    <a href="#none" title="Remove Screen Cache"><ub:message code="button.APM0001.screen.cache.init" text="화면캐시초기화"/></a>
</span>
<span class="ub-control button top icon" id="btnMeta">
    <a href="#none" title="Meta Sync"><span class="ico-register"></span><ub:message code="button.APM0001.link.meta" text="메타연동"/></a>
</span>
<span class="ub-control button top icon" id="register">
    <a href="#none" title="Register"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
</span>
</div>
  
<div id="resizeTest" class="ub-layout resize-area">

<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0001.title" text="화면"/></h1>

<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label" for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:120px;" blankType="0"/>
	<input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="${paramMap.CATEGORY_CODE}">
</td>
<th id="layout-1_1_3"><label class="ub-control label" for="SCREEN_ID"><ub:message code="label.APM.screen.id" text="화면ID"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="7" metalength="7"       value="${paramMap.SCREEN_ID}"                style="text-align:left;width:106px;"></td>
<th id="layout-1_1_5"><label class="ub-control label" for="SCREEN_NAME"><ub:message code="label.APM.screen.name" text="화면명"/></label></th>
<td id="layout-1_1_6"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"       value="${paramMap.SCREEN_NAME}"                style="text-align:left;width:106px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label" for="SCREEN_TYPE"><ub:message code="label.APM.screen.type" text="화면유형"/></label></th>
<td id="layout-1_2_8">
	<ub:code-select codeCategory="APMD_SCREEN_TYPE" id="SCREEN_TYPE" style="width:120px;" blankType="1" defaultValue="${paramMap.SCREEN_TYPE}"/>
</td>
<th id="layout-1_2_9"><label class="ub-control label" for="VIEW_TYPE"><ub:message code="label.APM.view.type" text="View유형"/></label></th>
<td id="layout-1_2_10">
	<ub:code-select codeCategory="APMD_SCREEN_VIEW_TYPE" id="VIEW_TYPE" style="width:120px;" blankType="1" defaultValue="${paramMap.VIEW_TYPE}"/>
</td>
<th id="layout-1_2_11"><label class="ub-control label" for="LOGIN_CHECK_YN"><ub:message code="label.APM.login.check.yn" text="로그인 체크여부"/></label></th>
<td id="layout-1_2_12">
	<ub:code-select codeCategory="FLAG_YN" id="LOGIN_CHECK_YN" style="width:120px;" blankType="1" defaultValue="${paramMap.LOGIN_CHECK_YN}"/>
</td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
<a href="#none" title="Search"><ub:message code="button.common.search" text="검색"/></a>
</span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="page" name="page" class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

</div>

<!-- layout-1 End -->

</div>	 


<!-- <div class="ub-layout details"> -->
<!-- <h2 class="ub-control title">기본정보</h2> -->
<%-- <table class="ub-control table normal " id="tblScrInfo" summary="APMD /  화면관리 상세-Normal Summary-0"><caption>APMD /  화면관리 상세-Normal-0</caption> --%>
<%-- <colgroup> --%>
<%-- <col width="150px"> --%>
<%-- <col width="40%"> --%>
<%-- <col width="150px"> --%>
<%-- <col> --%>
<%-- </colgroup> --%>
<!-- <tbody> -->
<!-- <tr id="layout-1_1"> -->
<!-- <th id="layout-1_1_1" scope="col"><label class="ub-control label" for="SCREEN_ID">화면ID<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_1_2"><input type="text" class="ub-control input-text  readonly" id="SCREEN_ID" name="SCREEN_ID" maxlength="7" metalength="7" value="INF0030" readonly="" metaessential="1" style="text-align:left;width:186px;"><select id="funcAlsIdItems" name="funcAlsIdItems" class="ub-control select " style="width: 120px; display: none;" size="1" datacid="APMD_FUNCTION_ALIAS"><option value="INQUIRY">[INQUIRY]  조회</option> -->

<!-- <option value="REGIST">[REGIST]  등록</option> -->

<!-- <option value="MODIFY">[MODIFY]  수정</option> -->

<!-- <option value="REMOVE">[REMOVE]  삭제</option> -->

<!-- <option value="EXECUTE">[EXECUTE]  실행/처리</option> -->

<!-- <option value="PRINT">[PRINT]  출력</option> -->

<!-- <option value="REQUEST">[REQUEST]  요청</option> -->

<!-- <option value="CONFIRM">[CONFIRM]  확인/결정/승인/확정</option> -->

<!-- <option value="CANCEL">[CANCEL]  취소</option> -->

<!-- <option value="COMPLETE">[COMPLETE]  완료</option> -->

<!-- <option value="IMPORT">[IMPORT]  Import</option> -->

<!-- <option value="EXPORT">[EXPORT]  Export</option> -->

<!-- <option value="CONFIG">[CONFIG]  설정</option> -->

<!-- <option value="CHECK">[CHECK]  체크</option> -->

<!-- <option value="USERDEFINED1">[USERDEFINED1]  사용자정의1</option> -->

<!-- <option value="USERDEFINED2">[USERDEFINED2]  사용자정의2</option> -->

<!-- <option value="USERDEFINED3">[USERDEFINED3]  사용자정의3</option> -->

<!-- <option value="USERDEFINED4">[USERDEFINED4]  사용자정의4</option> -->

<!-- <option value="USERDEFINED5">[USERDEFINED5]  사용자정의5</option> -->

<!-- <option value="USERDEFINED6">[USERDEFINED6]  사용자정의6</option> -->

<!-- <option value="USERDEFINED7">[USERDEFINED7]  사용자정의7</option> -->

<!-- <option value="USERDEFINED8">[USERDEFINED8]  사용자정의8</option> -->

<!-- <option value="USERDEFINED9">[USERDEFINED9]  사용자정의9</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_1_3" scope="col"><label class="ub-control label" for="CATEGORY_CODE">분류<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_1_4"><input type="hidden" name="CATEGORY_CODE" id="CATEGORY_CODE" value="INF"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select  readonly" style="width:200px;" size="1" disabled="disabled" metaessential="0"><option value="">선택안됨</option><option value="ANA">[ANA] 현황통계</option><option value="APP">[APP] 결재관리</option><option value="COM">[COM] 업무공통</option><option value="CSA">[CSA] CS활동</option><option value="CSI">[CSI] 만족도조사</option><option value="CTL">[CTL] 공통 Tools</option><option value="CUS">[CUS] 고객정보</option><option value="DSH">[DSH] 대시보드</option><option value="EXP">[EXP] 예제</option><option value="GRP">[GRP] 그룹웨어</option><option value="IND">[IND] 보상관리</option><option value="INF">[INF] 정보마당</option><option value="ISS">[ISS] 개선과제</option><option value="MOB">[MOB] 모바일</option><option value="POP">[POP] 팝업</option><option value="POR">[POR] 포탈</option><option value="RUL">[RUL] Rule관리</option><option value="SYS">[SYS] 시스템관리</option><option value="VAP">[VAP] VOC신청관리</option><option value="VOC">[VOC] VOC관리</option><option value="VRE">[VRE] VOC요청관리</option></select><input type="hidden" id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE" value="INF"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_2"> -->
<!-- <th id="layout-1_2_5" scope="col"><label class="ub-control label" for="SCREEN_TYPE">화면 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_2_6"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_SCREEN_TYPE" defaultvalue="R" metaessential="1"><option value="L">List</option> -->

<!-- <option value="D">Detail</option> -->

<!-- <option value="R" selected="">Register</option> -->

<!-- <option value="C">Complex</option> -->

<!-- <option value="T">Tree</option> -->

<!-- <option value="X">UnDefined</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_2_7" scope="col"><label class="ub-control label" for="LAYOUT_TYPE">Layout 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_2_8"><select id="LAYOUT_TYPE" name="LAYOUT_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_LAYOUT_TYPE" defaultvalue="Popup" metaessential="1"><option value="">선택안됨</option> -->

<!-- <option value="Default">Default</option> -->

<!-- <option value="FullWidth">FullWidth</option> -->

<!-- <option value="LeftMenu">LeftMenu</option> -->

<!-- <option value="Popup" selected="">Popup</option> -->

<!-- <option value="InnerContent">InnerContent</option> -->

<!-- <option value="TabContent">TabContent</option> -->

<!-- <option value="Blank">Blank</option> -->

<!-- <option value="MainPortal">MainPortal</option> -->

<!-- <option value="Login">Login</option> -->

<!-- <option value="Report">Report</option> -->

<!-- <option value="Board">Board</option> -->

<!-- <option value="MobileBoard">MobileBoard</option> -->

<!-- <option value="UnDefined">UnDefined</option> -->

<!-- </select></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_3"> -->
<!-- <th id="layout-1_3_9" scope="col"><label class="ub-control label" for="VIEW_TYPE">View 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_3_10"><select id="VIEW_TYPE" name="VIEW_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_SCREEN_VIEW_TYPE" defaultvalue="M" metaessential="1"><option value="">선택안됨</option> -->

<!-- <option value="M" selected="">Meta</option> -->

<!-- <option value="j">Jsp</option> -->

<!-- <option value="V">Velocity</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_3_11" scope="col"><label class="ub-control label">로그인 체크여부</label></th> -->
<!-- <td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn" checked="checked"><label></label><input type="hidden" id="loginChkYn" name="loginChkYn" value="Y"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_4" style="display: table-row;"> -->
<!-- <th id="layout-1_4_13" scope="col"><label id="LBL_PID" name="LBL_PID" class="ub-control label" for="PID_VALUE">메타ID<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_4_14"> -->

<!-- 	<input type="text" class="ub-control input-text  ui-autocomplete-input" id="SEARCH_PID" name="SEARCH_PID" style="text-align:left;width:400px;" autocomplete="off"><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span> -->
<!-- 	<input type="hidden" id="PID_VALUE" name="PID_VALUE" value="INF0030R00" metaessential="1"> -->
<!-- </td> -->
<!-- <td id="layout-1_4_15"></td> -->
<!-- <td id="layout-1_4_16"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_5"> -->
<!-- <th id="layout-1_5_17" scope="col"><label class="ub-control label" for="SCREEN_NAME">화면명<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_5_18" colspan="3"><input type="text" class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME" maxlength="100" metalength="100" value="팝업 기간 설정" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_6"> -->
<!-- <th id="layout-1_6_19" scope="col"><label id="filePathNm" name="filePathNm" class="ub-control label">파일경로</label></th> -->
<!-- <td id="layout-1_6_20" colspan="3"><input type="text" class="ub-control input-text " id="FILE_PATH" name="FILE_PATH" maxlength="1000" metalength="1000" value="/standard/inf/" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_7"> -->
<!-- <th id="layout-1_7_21" scope="col"><label class="ub-control label" for="FILE_NAME">파일명<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_7_22" colspan="3"><input type="text" class="ub-control input-text " id="FILE_NAME" name="FILE_NAME" maxlength="100" metalength="100" value="INF0030" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_8"> -->
<!-- <th id="layout-1_8_23" scope="col"><label class="ub-control label">설명</label></th> -->
<!-- <td id="layout-1_8_24" colspan="3"><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION" metalength="2000" style="width:412px;" rows="5"></textarea></td> -->
<!-- </tr> -->
<!-- </tbody> -->
<!-- </table> -->
 
<!-- </div> -->
<!-- <div class="ub-layout details"> -->
<!-- <h2 class="ub-control title">기본정보</h2> -->
<%-- <table class="ub-control table normal " id="tblScrInfo" summary="APMD /  화면관리 상세-Normal Summary-0"><caption>APMD /  화면관리 상세-Normal-0</caption> --%>
<%-- <colgroup> --%>
<%-- <col width="150px"> --%>
<%-- <col width="40%"> --%>
<%-- <col width="150px"> --%>
<%-- <col> --%>
<%-- </colgroup> --%>
<!-- <tbody> -->
<!-- <tr id="layout-1_1"> -->
<!-- <th id="layout-1_1_1" scope="col"><label class="ub-control label" for="SCREEN_ID">화면ID<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_1_2"><input type="text" class="ub-control input-text  readonly" id="SCREEN_ID" name="SCREEN_ID" maxlength="7" metalength="7" value="INF0030" readonly="" metaessential="1" style="text-align:left;width:186px;"><select id="funcAlsIdItems" name="funcAlsIdItems" class="ub-control select " style="width: 120px; display: none;" size="1" datacid="APMD_FUNCTION_ALIAS"><option value="INQUIRY">[INQUIRY]  조회</option> -->

<!-- <option value="REGIST">[REGIST]  등록</option> -->

<!-- <option value="MODIFY">[MODIFY]  수정</option> -->

<!-- <option value="REMOVE">[REMOVE]  삭제</option> -->

<!-- <option value="EXECUTE">[EXECUTE]  실행/처리</option> -->

<!-- <option value="PRINT">[PRINT]  출력</option> -->

<!-- <option value="REQUEST">[REQUEST]  요청</option> -->

<!-- <option value="CONFIRM">[CONFIRM]  확인/결정/승인/확정</option> -->

<!-- <option value="CANCEL">[CANCEL]  취소</option> -->

<!-- <option value="COMPLETE">[COMPLETE]  완료</option> -->

<!-- <option value="IMPORT">[IMPORT]  Import</option> -->

<!-- <option value="EXPORT">[EXPORT]  Export</option> -->

<!-- <option value="CONFIG">[CONFIG]  설정</option> -->

<!-- <option value="CHECK">[CHECK]  체크</option> -->

<!-- <option value="USERDEFINED1">[USERDEFINED1]  사용자정의1</option> -->

<!-- <option value="USERDEFINED2">[USERDEFINED2]  사용자정의2</option> -->

<!-- <option value="USERDEFINED3">[USERDEFINED3]  사용자정의3</option> -->

<!-- <option value="USERDEFINED4">[USERDEFINED4]  사용자정의4</option> -->

<!-- <option value="USERDEFINED5">[USERDEFINED5]  사용자정의5</option> -->

<!-- <option value="USERDEFINED6">[USERDEFINED6]  사용자정의6</option> -->

<!-- <option value="USERDEFINED7">[USERDEFINED7]  사용자정의7</option> -->

<!-- <option value="USERDEFINED8">[USERDEFINED8]  사용자정의8</option> -->

<!-- <option value="USERDEFINED9">[USERDEFINED9]  사용자정의9</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_1_3" scope="col"><label class="ub-control label" for="CATEGORY_CODE">분류<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_1_4"><input type="hidden" name="CATEGORY_CODE" id="CATEGORY_CODE" value="INF"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select  readonly" style="width:200px;" size="1" disabled="disabled" metaessential="0"><option value="">선택안됨</option><option value="ANA">[ANA] 현황통계</option><option value="APP">[APP] 결재관리</option><option value="COM">[COM] 업무공통</option><option value="CSA">[CSA] CS활동</option><option value="CSI">[CSI] 만족도조사</option><option value="CTL">[CTL] 공통 Tools</option><option value="CUS">[CUS] 고객정보</option><option value="DSH">[DSH] 대시보드</option><option value="EXP">[EXP] 예제</option><option value="GRP">[GRP] 그룹웨어</option><option value="IND">[IND] 보상관리</option><option value="INF">[INF] 정보마당</option><option value="ISS">[ISS] 개선과제</option><option value="MOB">[MOB] 모바일</option><option value="POP">[POP] 팝업</option><option value="POR">[POR] 포탈</option><option value="RUL">[RUL] Rule관리</option><option value="SYS">[SYS] 시스템관리</option><option value="VAP">[VAP] VOC신청관리</option><option value="VOC">[VOC] VOC관리</option><option value="VRE">[VRE] VOC요청관리</option></select><input type="hidden" id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE" value="INF"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_2"> -->
<!-- <th id="layout-1_2_5" scope="col"><label class="ub-control label" for="SCREEN_TYPE">화면 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_2_6"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_SCREEN_TYPE" defaultvalue="R" metaessential="1"><option value="L">List</option> -->

<!-- <option value="D">Detail</option> -->

<!-- <option value="R" selected="">Register</option> -->

<!-- <option value="C">Complex</option> -->

<!-- <option value="T">Tree</option> -->

<!-- <option value="X">UnDefined</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_2_7" scope="col"><label class="ub-control label" for="LAYOUT_TYPE">Layout 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_2_8"><select id="LAYOUT_TYPE" name="LAYOUT_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_LAYOUT_TYPE" defaultvalue="Popup" metaessential="1"><option value="">선택안됨</option> -->

<!-- <option value="Default">Default</option> -->

<!-- <option value="FullWidth">FullWidth</option> -->

<!-- <option value="LeftMenu">LeftMenu</option> -->

<!-- <option value="Popup" selected="">Popup</option> -->

<!-- <option value="InnerContent">InnerContent</option> -->

<!-- <option value="TabContent">TabContent</option> -->

<!-- <option value="Blank">Blank</option> -->

<!-- <option value="MainPortal">MainPortal</option> -->

<!-- <option value="Login">Login</option> -->

<!-- <option value="Report">Report</option> -->

<!-- <option value="Board">Board</option> -->

<!-- <option value="MobileBoard">MobileBoard</option> -->

<!-- <option value="UnDefined">UnDefined</option> -->

<!-- </select></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_3"> -->
<!-- <th id="layout-1_3_9" scope="col"><label class="ub-control label" for="VIEW_TYPE">View 유형<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_3_10"><select id="VIEW_TYPE" name="VIEW_TYPE" class="ub-control select " style="width:200px;" size="1" datacid="APMD_SCREEN_VIEW_TYPE" defaultvalue="M" metaessential="1"><option value="">선택안됨</option> -->

<!-- <option value="M" selected="">Meta</option> -->

<!-- <option value="j">Jsp</option> -->

<!-- <option value="V">Velocity</option> -->

<!-- </select></td> -->
<!-- <th id="layout-1_3_11" scope="col"><label class="ub-control label">로그인 체크여부</label></th> -->
<!-- <td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn" checked="checked"><label></label><input type="hidden" id="loginChkYn" name="loginChkYn" value="Y"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_4" style="display: table-row;"> -->
<!-- <th id="layout-1_4_13" scope="col"><label id="LBL_PID" name="LBL_PID" class="ub-control label" for="PID_VALUE">메타ID<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_4_14"> -->

<!-- 	<input type="text" class="ub-control input-text  ui-autocomplete-input" id="SEARCH_PID" name="SEARCH_PID" style="text-align:left;width:400px;" autocomplete="off"><span role="status" aria-live="polite" class="ui-helper-hidden-accessible"></span> -->
<!-- 	<input type="hidden" id="PID_VALUE" name="PID_VALUE" value="INF0030R00" metaessential="1"> -->
<!-- </td> -->
<!-- <td id="layout-1_4_15"></td> -->
<!-- <td id="layout-1_4_16"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_5"> -->
<!-- <th id="layout-1_5_17" scope="col"><label class="ub-control label" for="SCREEN_NAME">화면명<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_5_18" colspan="3"><input type="text" class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME" maxlength="100" metalength="100" value="팝업 기간 설정" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_6"> -->
<!-- <th id="layout-1_6_19" scope="col"><label id="filePathNm" name="filePathNm" class="ub-control label">파일경로</label></th> -->
<!-- <td id="layout-1_6_20" colspan="3"><input type="text" class="ub-control input-text " id="FILE_PATH" name="FILE_PATH" maxlength="1000" metalength="1000" value="/standard/inf/" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_7"> -->
<!-- <th id="layout-1_7_21" scope="col"><label class="ub-control label" for="FILE_NAME">파일명<span class="required">*</span></label></th> -->
<!-- <td id="layout-1_7_22" colspan="3"><input type="text" class="ub-control input-text " id="FILE_NAME" name="FILE_NAME" maxlength="100" metalength="100" value="INF0030" metaessential="1" style="text-align:left;width:400px;"></td> -->
<!-- </tr> -->
<!-- <tr id="layout-1_8"> -->
<!-- <th id="layout-1_8_23" scope="col"><label class="ub-control label">설명</label></th> -->
<!-- <td id="layout-1_8_24" colspan="3"><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION" metalength="2000" style="width:412px;" rows="5"></textarea></td> -->
<!-- </tr> -->
<!-- </tbody> -->
<!-- </table> -->
 
<!-- </div> -->
   
<script type="text/javascript">

/* 화면조절 초기 변수 */
var resizeStatus = "Y";
/* 클릭상태 초기 변수 */
var clickStatus = "N";
/* div영역 초기 높이 이자 */ 
var preDivHeight = $('#resizeTest')[0].clientHeight;

$(document).ready(function(){
	
//	$('#resizeTest').css("height","200px");
//hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	
	var options = {
			//header name
			colNames:[  '<%=MessageUtils.getMessage("label.APM.category", "분류") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.id", "화면ID") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.name", "화면명") %>'
			          , '<%=MessageUtils.getMessage("label.APM.layout.type", "Layout 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.screen.type", "화면 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.view.type", "View 유형") %>'
			          , '<%=MessageUtils.getMessage("label.APM.login.check.yn", "로그인 체크여부") %>'
			          , '<%=MessageUtils.getMessage("label.APM.reg.date", "작성일") %>'
			          <%-- , '<%=MessageUtils.getMessage("label.APM.xml", "XML") %>' --%>
			         ]
			
			//mapping column
			, colModel:[
				    {name:'CATEGORY_CODE',    width:10, align:'center'}
				  , {name:'SCREEN_ID',       width:15, align:'center'}
				  , {name:'SCREEN_NAME',       width:55, align:'left'}
				  , {name:'LAYOUT_TYPE', width:15, align:'center', codeCategory:'APMD_LAYOUT_TYPE'}
				  , {name:'SCREEN_TYPE',     width:15, align:'center', codeCategory:'APMD_SCREEN_TYPE'}
				  , {name:'VIEW_TYPE',  width:15, align:'center'}
				  , {name:'LOGIN_CHECK_YN',  width:15, align:'center'}
				  , {name:'REG_DATETIME',  width:30, align:'center'}
				 // , {name:'downXmlBtn',  width:15, align:'center', formatter:setXmlDownBtn}
			]
			, autowidth:true
			, sortname: 'REG_DATETIME'
			, sortorder: 'DESC'
			, height: 261
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SCREEN_ID=" + selectedRow.SCREEN_ID;
				uxl.moveLocation(uxl.getScreenURL('APM0002') + param);
			}
		};
		uxl.grid('list', options);
	
	
	$('#search').click(function(){
		uxl.grid.init('list');
		fnSearch();
	});

	/* div영역 resize기능 바인딩 */
     $( "#resizeTest" ).resizable({
/*      	minHeight: 200,
    	//maxHeight: 500,
        maxWidth: 1220 */
    });
 
	
	$(".ui-resizable-handle.ui-icon").mouseup(function(){
		
		/* 현재 div영역 높이 */
		var nowDivHeight = $('#resizeTest')[0].clientHeight;
		
		/* 원래 div영역 높이와 큭릭하고 나서의 div영역 높이가 동일 할때 => 드래그가 아닌 클릭으로 판단 */
	//	if(preDivHeight==nowDivHeight){

		//	if(resizeStatus=="Y"){ // 해당 div영역을 줄일때
		 	//	$('#resizeTest').css("height","200px");
		 		//resizeStatus = "N";
		 //	}else{// 해당 div영역을 늘릴때
		 	//	$('#resizeTest').css("height","400px");
		 		//resizeStatus = "Y";
		 	//}
		//}
		
		preDivHeight = $('#resizeTest')[0].clientHeight;
		
	});

	
});


function fnSearch(){		
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{}		
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}


</script>