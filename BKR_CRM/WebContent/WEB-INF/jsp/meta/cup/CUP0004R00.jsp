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
 
   - PAGE ID : CUP0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">쿠폰 마스터 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<form id="registForm" name="registForm"><h2 class="ub-control title" for="basicLayout" hfold="1">기본 정보</h2>
<div class="ub-layout " id="basicLayout" name="basicLayout"><table class="ub-control table normal " id="basicInfo">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CD_COUPON_OBJ">쿠폰 대상</label></th>
<td id="layout-1_1_2"><input class="ub-control radio" type=radio  id="CD_COUPON_OBJ" name="CD_COUPON_OBJ"    checked value="1"      metaessential="1"><label> 킹오더</label><input class="ub-control radio" type=radio  id="CD_COUPON_OBJ" name="CD_COUPON_OBJ"     value="2"      metaessential="1"><label> 딜리버리</label><input class="ub-control radio" type=radio  id="CD_COUPON_OBJ" name="CD_COUPON_OBJ"     value="3"      metaessential="1"><label> 매장</label><input class="ub-control radio" type=radio  id="CD_COUPON_OBJ" name="CD_COUPON_OBJ"     value="4"      metaessential="1"><label> 리워드</label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label">다우 쿠폰 정보</label></th>
<td id="layout-1_2_4"><span class="ub-control button inner icon"     onclick="fnPopupDau()">    <a href="#none" title="쿠폰 상품 선택"><span></span>쿠폰 상품 선택</a></span><input type=hidden id="NO_REQ" name="NO_REQ"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="NM_COUPON">쿠폰명</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="NM_COUPON" name="NM_COUPON" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:600px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7" rowspan=3><label class="ub-control label">쿠폰 이미지</label></th>
<td id="layout-1_4_8"><label id="lbl_App" name="lbl_App" class="ub-control label">OMNI 이미지(APP용)</label><br/><label class="ub-control label">&nbsp;</label><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_IMG_APP'></div>   	<div class="filefieldset" id='uploadProgress_IMG_APP' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_IMG_APP'></span> </span></td>
</tr>
<tr id="layout-1_5">
<td id="layout-1_5_9"><label id="lbl_Web" name="lbl_Web" class="ub-control label">OMNI 이미지(WEB용)</label><br/><label class="ub-control label">&nbsp;</label><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_IMG_WEB'></div>   	<div class="filefieldset" id='uploadProgress_IMG_WEB' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_IMG_WEB'></span> </span></td>
</tr>
<tr id="layout-1_6">
<td id="layout-1_6_10"><label id="lbl_Reward" name="lbl_Reward" class="ub-control label">리워드 이미지</label><br/><label class="ub-control label">&nbsp;</label><div class="ub-control temp" style="border:2px solid gray;width:100%;height:80px;text-align:center;"><h3 style="padding-top:30px;padding-left:10px;padding-right:10px;">Attach File Control</h3></div><span class="ub-control attachFile">   	<div class="filefieldset" id='uploadedFiles_IMG_REWARD'></div>   	<div class="filefieldset" id='uploadProgress_IMG_REWARD' style="display:none;">   		<span class="legend">Uploading...</span>   	</div>	<span id='btnUpload_IMG_REWARD'></span> </span></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_11"><label class="ub-control label">유의사항</label></th>
<td id="layout-1_7_12"><textarea class="ub-control textarea " id="DS_COUPON" name="DS_COUPON"       style="width:600px;" rows="3"                  rows="3"></textarea></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="detailLayout" hfold="1">세부 정보</h2>
<div class="ub-layout " id="detailLayout" name="detailLayout"><table class="ub-control table normal " id="detailInfo">
<colgroup>
<col width="150px"/>
<col width="120px"/>
<col />
<col />
<col />
<col width="550px"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CD_COUPON_TARGET">쿠폰 적용 대상</label></th>
<td id="layout-1_1_2" colspan=5><input class="ub-control radio" type=radio  id="CD_COUPON_TARGET" name="CD_COUPON_TARGET"    checked value="1"><label> 금액</label><input class="ub-control radio" type=radio  id="CD_COUPON_TARGET" name="CD_COUPON_TARGET"     value="2"><label> 상품</label></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="VAL_SALE_POLICY">할인 정책</label></th>
<td id="layout-1_2_4" colspan=5><input class="ub-control radio" type=radio  id="CD_SALE_POLICY" name="CD_SALE_POLICY"    checked value="1"      metaessential="1"><label> 정액할인</label><input class="ub-control radio" type=radio  id="CD_SALE_POLICY" name="CD_SALE_POLICY"     value="2"      metaessential="1"><label> 정율할인</label><input type=text  class="ub-control input-text " id="VAL_SALE_POLICY" name="VAL_SALE_POLICY" maxLength="7" metalength="7"      metaformat="number" value="0"                style="text-align:left;width:100px;"><label id="LBL_POLICY" name="LBL_POLICY" class="ub-control label"> 원</label></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="VAL_LIMIT_PRICE">최소 주문 금액</label></th>
<td id="layout-1_3_6" colspan=5><input type=text  class="ub-control input-text " id="VAL_LIMIT_PRICE" name="VAL_LIMIT_PRICE" maxLength="7" metalength="7"      metaformat="number" value="0"     metaessential="1"           style="text-align:left;width:100px;"><label class="ub-control label"> 원 이상 주문에만 적용 (0 이면 제한 없음)</label></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7" rowspan=2><label class="ub-control label">적용 상품</label></th>
<th id="layout-1_4_8"><label class="ub-control label"             for="PRODUCT_PK">할인 상품</label></th>
<td id="layout-1_4_9" colspan=3><input type=text  class="ub-control input-text " id="PRODUCT_PK" name="PRODUCT_PK"         readonly   metaessential="1"           style="text-align:left;width:50px;"><input type=text  class="ub-control input-text " id="MENU_NM" name="MENU_NM" maxLength="20" metalength="20"                       style="text-align:left;width:100px;"><span class="ub-control button inner icon"     onclick="fnPopupMenu();">    <a href="#none" title="상품찾기"><span></span>상품찾기</a></span></td>
<td id="layout-1_4_10" rowspan=2><label class="ub-control label"     style="color:#db482b;;">※ 할인 상품을 주문하면 연계로 전송 시 실제 상품 정보를 전송한다.</label><br/><label class="ub-control label"     style="color:#db482b;;">※ 할인 상품과 같은 카테고리여야 하고, 컨디먼트도 동일해야 한다.</label><br/><label class="ub-control label"     style="color:#db482b;;">※ 회원 화면에 나오면 안되므로 판매중지(미 노출)로 설정해야 한다.</label></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_11"><label class="ub-control label"             for="PRODUCT_PK_REAL">실제 판매상품</label></th>
<td id="layout-1_5_12" colspan=3><input type=text  class="ub-control input-text " id="PRODUCT_PK_REAL" name="PRODUCT_PK_REAL"         readonly   metaessential="1"           style="text-align:left;width:50px;"><input type=text  class="ub-control input-text " id="MENU_NM_REAL" name="MENU_NM_REAL" maxLength="20" metalength="20"                       style="text-align:left;width:100px;"><span class="ub-control button inner icon"     onclick="fnPopupMenuReal()">    <a href="#none" title="상품찾기"><span></span>상품찾기</a></span></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_13" class="lbl_import" rowspan=3><label class="ub-control label">쿠폰 뷰</label></th>
<th id="layout-1_6_14"><label class="ub-control label"             for="NM_CUP_MENU">쿠폰 상품명</label></th>
<td id="layout-1_6_15" colspan=4><input type=text  class="ub-control input-text " id="NM_CUP_MENU" name="NM_CUP_MENU" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:245px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_16" class="lbl_import" rowspan=2><label class="ub-control label">실 판매금액</label></th>
<th id="layout-1_7_17"><label class="ub-control label"             for="REAL_CUP_PRICE">실제판매금액</label></th>
<th id="layout-1_7_18"><label class="ub-control label"             for="SALE_CUP_PRICE">할인판매금액</label></th>
<th id="layout-1_7_19"><label class="ub-control label"             for="SALE_CUP_RATE">할인율</label></th>
<td id="layout-1_7_20"></td>
</tr>
<tr id="layout-1_8">
<td id="layout-1_8_21"><input type=text  class="ub-control input-text " id="REAL_CUP_PRICE" name="REAL_CUP_PRICE" maxLength="7" metalength="7"      metaformat="number"      metaessential="1"           style="text-align:left;width:100px;"><label class="ub-control label"> 원</label></td>
<td id="layout-1_8_22"><input type=text  class="ub-control input-text " id="SALE_CUP_PRICE" name="SALE_CUP_PRICE" maxLength="7" metalength="7"      metaformat="number"      metaessential="1"           style="text-align:left;width:100px;"><label class="ub-control label"> 원</label></td>
<td id="layout-1_8_23"><input type=text  class="ub-control input-text " id="SALE_CUP_RATE" name="SALE_CUP_RATE" maxLength="3" metalength="3"      metaformat="number"      metaessential="1"           style="text-align:left;width:20px;"><label class="ub-control label">%</label></td>
<td id="layout-1_8_24"></td>
</tr>
<tr id="layout-1_9">
<th id="layout-1_9_25"><label class="ub-control label"             for="DT_EXPIRY_START,DT_EXPIRY_END">쿠폰 유효기간</label></th>
<td id="layout-1_9_26" colspan=5><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_START" name="DT_EXPIRY_START"       metaformat="date" value="${paramMap.DT_TODAY}"     metaessential="1"           style="text-align:left;width:75px;"><label class="ub-control label"> ~ </label><input type=text class="ub-control input-text calendar " id="DT_EXPIRY_END" name="DT_EXPIRY_END"       metaformat="date" value="${paramMap.DT_WEEK}"     metaessential="1"           style="text-align:left;width:75px;"></td>
</tr>
<tr id="layout-1_10">
<th id="layout-1_10_27"><label class="ub-control label"             for="TP_EXPIRY_DATE">쿠폰 핀 유효기간</label></th>
<td id="layout-1_10_28" colspan=5><select id="TP_EXPIRY_DATE" name="TP_EXPIRY_DATE" class="ub-control select "     style="width:150px;" size="1"       metaessential="1"></select><label class="ub-control label"     style="color:#db482b;;">※ 지정유효기간일때 쿠폰의 유효기간과 동일하게 설정된다.</label></td>
</tr>
<tr id="layout-1_11">
<th id="layout-1_11_29"><label class="ub-control label"             for="TP_MEMBER">대상 회원</label></th>
<td id="layout-1_11_30" colspan=5><input class="ub-control radio" type=radio  id="TP_MEMBER" name="TP_MEMBER"    checked value="1"      metaessential="1"><label> 회원 전용</label><input class="ub-control radio" type=radio  id="TP_MEMBER" name="TP_MEMBER"     value="2"      metaessential="1"><label></label><label id="lbl_all" name="lbl_all" class="ub-control label">전체</label><input class="ub-control radio" type=radio  id="TP_MEMBER" name="TP_MEMBER"     value="4"      metaessential="1"><label> 발행 회원</label></td>
</tr>
<tr id="layout-1_12">
<th id="layout-1_12_31"><label class="ub-control label"             for="FG_PUB">발행 여부</label></th>
<td id="layout-1_12_32" colspan=5><input class="ub-control radio" type=radio  id="FG_PUB" name="FG_PUB"    checked value="Y"      metaessential="1"><label> 발행</label><input class="ub-control radio" type=radio  id="FG_PUB" name="FG_PUB"     value="N"      metaessential="1"><label> 중지</label></td>
</tr>
</tbody>
</table>
 
</div>
<h2 class="ub-control title" for="exceptLayout" hfold="1">제외 매장 설정</h2>
<div class="ub-layout " id="exceptLayout" name="exceptLayout"><table class="ub-control table normal " id="StoreExLayout">
<colgroup>
<col width="150px"/>
<col width="280px"/>
<col width="200px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1" rowspan=3><label class="ub-control label">제외 매장 설정</label></th>
<td id="layout-1_1_2"><br/><h4 class="ub-control title">전체 매장</h4><br/><select id="TP_STOR_ALL" name="TP_STOR_ALL" class="ub-control select "     style="width:200px;" size="1"></select></td>
<td id="layout-1_1_3" rowspan=3 style='text-align:Center vertical-align:Top'><span class="ub-control button inner icon" id="addExcept"     onclick="fnAddAll()">    <a href="#none" title="전체 등록>>"><span></span>전체 등록>></a></span><br/><br/><span class="ub-control button inner icon" id="addExcept"     onclick="fnAddEx()">    <a href="#none" title="선택 등록>>"><span></span>선택 등록>></a></span><br/><br/><br/><br/><span class="ub-control button inner icon" id="delExcept"     onclick="fnDelAll();">    <a href="#none" title="<<전체 삭제"><span></span><<전체 삭제</a></span><br/><br/><span class="ub-control button inner icon" id="delExcept"     onclick="fnDelEx();">    <a href="#none" title="<<선택 삭제"><span></span><<선택 삭제</a></span></td>
<td id="layout-1_1_4"><h4 class="ub-control title">제외 매장</h4></td>
</tr>
<tr id="layout-1_2">
<td id="layout-1_2_5"><input type=text  class="ub-control input-text " id="NM_STORE_SEARCH" name="NM_STORE_SEARCH" maxLength="20" metalength="20"                       style="text-align:left;width:125px;"><span class="ub-control button inner icon"     onclick="searchStore();">    <a href="#none" title="검색"><span></span>검색</a></span></td>
<td id="layout-1_2_6"></td>
</tr>
<tr id="layout-1_3">
<td id="layout-1_3_7"><select id="CD_STOR_ALL" name="CD_STOR_ALL" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
<td id="layout-1_3_8"><select id="CD_STOR_EX" name="CD_STOR_EX" multiple class="ub-control select-multiple"     style="width:200px;"  size="15"></select></td>
</tr>
</tbody>
</table>
 
</div>
<input type=hidden id="CD_GOODS" name="CD_GOODS">
<input type=hidden id="NM_GOODS" name="NM_GOODS">
<input type=hidden id="IMG_GOODS" name="IMG_GOODS">
</form>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon"     onclick="fnSave();">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->
