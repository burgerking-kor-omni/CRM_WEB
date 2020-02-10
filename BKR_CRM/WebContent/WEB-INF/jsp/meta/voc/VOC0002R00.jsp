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
	DataList _dl_VocManage_getVocDetail = ViewUtil.getResult().getDataList("VocManage.getVocDetail");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : VOC0002R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title" id="DS_TITLE" name="DS_TITLE">VOC 상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="list">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<div class="ub-layout "><form id="detailForm" name="detailForm"><h2 class="ub-control title">주문정보</h2>
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
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ORDER_NO" name="ORDER_NO"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "ORDER_NO") %>"  readonly              style="text-align:left;width:150px;"><span class="ub-control button inner icon" id="popupDetail"     onclick="fnShowDetail()">    <a href="#none" title="상세보기"><span></span>상세보기</a></span></td>
<th id="layout-1_1_3"><label class="ub-control label">접수채널</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="BIZ_CHNN_NM" name="BIZ_CHNN_NM"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_CHNN") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">결재방법</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="PAYMENT_TYPE_SUB" name="PAYMENT_TYPE_SUB"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_PAYMENT_TYPE") %>"  readonly              style="text-align:left;width:150px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">주문일자</label></th>
<td id="layout-1_2_8"><input type=text class="ub-control input-text calendar "        value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DT_ORDER") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label">결재금액</label></th>
<td id="layout-1_3_10"><input type=text  class="ub-control input-text "      metaformat="number" value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "PAYMENT_PRC") %>"  readonly              style="text-align:left;width:100px;"><label class="ub-control label">원</label></td>
<th id="layout-1_3_11"><label class="ub-control label">상품코드</label></th>
<td id="layout-1_3_12"><input type=text  class="ub-control input-text " id="MENU_CODE" name="MENU_CODE"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "MENU_CD") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label class="ub-control label"             for="STOR_NM">매장</label></th>
<td id="layout-1_4_14"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_STORE") %>"  readonly              style="text-align:left;width:150px;"></td>
<th id="layout-1_4_15"><label class="ub-control label">상품명</label></th>
<td id="layout-1_4_16"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "MENU_NM") %>"  readonly              style="text-align:left;width:240px;"></td>
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
<td id="layout-1_1_2"><input class="ub-control radio" type=radio  id="YN_MEMBER" name="YN_MEMBER"     value="Y"   disabled><label> Y</label><input class="ub-control radio" type=radio  id="YN_MEMBER" name="YN_MEMBER"     value="N"   disabled><label> N</label></td>
<th id="layout-1_1_3"></th>
<td id="layout-1_1_4"></td>
<td id="layout-1_1_5"></td>
<td id="layout-1_1_6"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label">이름</label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="NM_CUST" name="NM_CUST"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_CUST") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_2_9"><label class="ub-control label">전화번호</label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text "       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NO_PHONE") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_2_11"><label class="ub-control label">이메일</label></th>
<td id="layout-1_2_12"><input type=text  class="ub-control input-text " id="DS_EMAIL" name="DS_EMAIL"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DS_EMAIL") %>"  readonly              style="text-align:left;width:200px;"></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">등록정보</h2>
<div class="ub-layout "><table class="ub-control table normal " id="regInfo">
<colgroup>
<col width="120px"/>
<col width="360px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">VOC번호</label></th>
<td id="layout-1_1_2" colspan=3><input type=text class="ub-control input-text calendar "        value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "ID_VOC") %>"                style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="CD_VOC_CAUSE_2">유형</label></th>
<td id="layout-1_2_4" colspan=3><input type=text  class="ub-control input-text " id="NM_CAUSE" name="NM_CAUSE" maxLength="15" metalength="15"                       style="text-align:left;width:100px;"><select id="CD_VOC_CAUSE_1" name="CD_VOC_CAUSE_1" class="ub-control select "     style="width:115px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "CD_VOC_CAUSE_1") %>"></select><select id="CD_VOC_CAUSE_2" name="CD_VOC_CAUSE_2" class="ub-control select "     style="width:160px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "CD_VOC_CAUSE_2") %>"     metaessential="1"></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="DT_VOC_REG">발생일자</label></th>
<td id="layout-1_3_6"><input type=text class="ub-control input-text calendar " id="DT_VOC_REG" name="DT_VOC_REG"       metaformat="date" value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DT_VOC_REG") %>"     metaessential="1"           style="text-align:left;width:70px;"></td>
<th id="layout-1_3_7"><label class="ub-control label">등록일시</label></th>
<td id="layout-1_3_8"><input type=text class="ub-control input-text calendar "        value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DT_REG") %>"                style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label"             for="DS_TITLE">제목</label></th>
<td id="layout-1_4_10" colspan=3><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DS_TITLE") %>"     metaessential="1"           style="text-align:left;width:600px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_11"><label class="ub-control label"             for="DS_CONT">내용</label></th>
<td id="layout-1_5_12" colspan=3><textarea class="ub-control textarea " id="DS_CONT" name="DS_CONT"       style="width:600px;" rows="5"      metaessential="1"            rows="5"><%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DS_CONT") %></textarea></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_13"><label class="ub-control label">첨부파일</label></th>
<td id="layout-1_6_14" colspan=3></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title">처리정보</h2>
<div class="ub-layout details" id="vocInfoDtl" name="vocInfoDtl"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col width="280px"/>
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CD_ACT_CAUSE">처리유형</label></th>
<td id="layout-1_1_2"><select id="CD_ACT_CAUSE" name="CD_ACT_CAUSE" class="ub-control select "     style="width:120px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "CD_ACT_CAUSE") %>"     metaessential="1"></select></td>
<th id="layout-1_1_3"><label class="ub-control label">처리상태</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="NM_VOC_STATUS" name="NM_VOC_STATUS"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_VOC_STATUS") %>"  readonly              style="text-align:left;width:100px;"><input type=hidden id="CD_STATUS" name="CD_STATUS"    value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "CD_VOC_STATUS") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="DS_ACT_CONT">처리내용</label></th>
<td id="layout-1_2_6" colspan=3><textarea class="ub-control textarea " id="DS_ACT_CONT" name="DS_ACT_CONT"       style="width:600px;" rows="4"      metaessential="1"            rows="4"><%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DS_ACT_CONT") %></textarea></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label class="ub-control label"             for="DS_DISPATCH_CONT">고객통보내용</label></th>
<td id="layout-1_3_8"><input class="ub-control radio" type=radio  id="FG_SEND" name="FG_SEND"    checked value="Y"><label> 발송 </label><input class="ub-control radio" type=radio  id="FG_SEND" name="FG_SEND"     value="N"><label> 미발송</label><br/><label class="ub-control label">&nbsp;<br /></label><textarea class="ub-control textarea " id="DS_DISPATCH_CONT" name="DS_DISPATCH_CONT"       style="width:600px;" rows="4"      metaessential="1"            rows="4"><%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DS_DISPATCH_CONT") %></textarea></td>
<td id="layout-1_3_9" colspan=2><label id="TXT_LABEL" name="TXT_LABEL" class="ub-control label"><b>※  VOC 완료 시, 해당 고객에게 고객통보내용으로 이메일이 발송됩니다.<br />&nbsp;&nbsp;&nbsp;고객 통보 내용을 다시 한번 확인하시기 바랍니다.</b></label></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_10"><label class="ub-control label">처리일자</label></th>
<td id="layout-1_4_11"><input type=text  class="ub-control input-text " id="DT_VOC_ACT" name="DT_VOC_ACT"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "DT_VOC_ACT") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_4_12"><label class="ub-control label">처리자</label></th>
<td id="layout-1_4_13"><input type=text  class="ub-control input-text " id="NM_ACT_EMP" name="NM_ACT_EMP"       value="<%=JspUtils.getDefaultValue(_dl_VocManage_getVocDetail, "NM_ACT_EMP") %>"  readonly              style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</div>
<input type=hidden id="ID_VOC" name="ID_VOC"    value="${paramMap.ID_VOC}">
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="delBtn"     onclick="fnDel();">
    <a href="#none" title="삭제"><span></span>삭제</a>
</span>
<span class="ub-control button bottom icon" id="saveBtn"     onclick="fnSave();">
    <a href="#none" title="임시저장"><span></span>임시저장</a>
</span>
<span class="ub-control button bottom icon" id="completeBtn"     onclick="fnComplete();">
    <a href="#none" title="완료"><span></span>완료</a>
</span>
</div>
</div>

<!-- layout-1 End -->
