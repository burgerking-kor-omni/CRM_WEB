<%--
#*
 *  파 일 명 :  APM0061.jsp
 *  설    명 :  코드 유형 등록(다국어용)
 *  작 성 자 :  김병기
 *  작 성 일 :  2016-09-30
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
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

<!--  ========================================================================
  This page is generated with the UB-META™ ver5.0 
 
   - PAGE ID : APM0061R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">코드 유형 등록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="listBtn">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
</span>
</div>
<h2 class="ub-control title">기본정보</h2>
<div class="ub-layout details"></div>
<form id="insertForm" name="insertForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px" />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CODE_CATEGORY_ID">코드유형ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"            metaessential="1"           style="text-align:left;width:150px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="CODE_CATEGORY_NM">코드유형명</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_NM" name="CODE_CATEGORY_NM"            metaessential="1"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="CODE_TP">코드구분</label></th>
<td id="layout-1_3_6"><ub:code-select id="CODE_TP" codeCategory="CODE_TP" style="width:120px;" essential="true"/></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">ENUM 클래스</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="ENUM_CLASS_NAME" name="ENUM_CLASS_NAME"                       style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label"             for="CONSTANT_REG_YN">상수등록여부</label></th>
<td id="layout-1_5_10"><ub:code-select id="CONSTANT_REG_YN" codeCategory="FLAG_YN" style="width:120px;" essential="true" defaultValue=""/></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_11"><label class="ub-control label"             for="CACHE_YN">캐쉬여부</label></th>
<td id="layout-1_6_12"><ub:code-select id="CACHE_YN" codeCategory="FLAG_YN" style="width:120px;" essential="true" defaultValue=""/></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_13"><label class="ub-control label">코드정의쿼리</label></th>
<td id="layout-1_7_14"><textarea class="ub-control textarea " id="CODE_QUERY_CONTENT" name="CODE_QUERY_CONTENT"       style="width:600px;"></textarea></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_15"><label class="ub-control label"             for="STATUS">상태</label></th>
<td id="layout-1_8_16"><ub:code-select id="STATUS" codeCategory="STATUS" style="width:120px;" essential="true" defaultValue=""/></td>
</tr>
<tr id="layout-1_9">
<th id="layout-1_9_17"><label class="ub-control label">상위코드</label></th>
<td id="layout-1_9_18"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID_UP" name="CODE_CATEGORY_ID_UP"                       style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_10">
<th id="layout-1_10_19"><label class="ub-control label">코드맵핑사용여부</label></th>
<td id="layout-1_10_20"><input class="ub-control radio" type=radio  id="MAPPING_YN" name="MAPPING_YN"     value="Y"><label>사용</label><input class="ub-control radio" type=radio  id="MAPPING_YN" name="MAPPING_YN"    checked value="N"><label>미사용</label></td>
</tr>
<tr id="layout-1_11">
<th id="layout-1_11_21"><label class="ub-control label"             for="TABLE_ID">원천코드테이블ID</label></th>
<td id="layout-1_11_22"><input type=text  class="ub-control input-text " id="TABLE_ID" name="TABLE_ID"                       style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_12">
<th id="layout-1_12_23"><label class="ub-control label"             for="CODE_COLUMN_ID">원천코드컬럼ID</label></th>
<td id="layout-1_12_24"><input type=text  class="ub-control input-text " id="CODE_COLUMN_ID" name="CODE_COLUMN_ID"                       style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_13">
<th id="layout-1_13_25"><label class="ub-control label"             for="NAME_COLUMN_ID">원천명칭컬럼ID</label></th>
<td id="layout-1_13_26"><input type=text  class="ub-control input-text " id="NAME_COLUMN_ID" name="NAME_COLUMN_ID"                       style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="insertBtn">
    <a href="#none"><span class="ico-register"></span>등록</a>
</span>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	// 리스트
	$('#listBtn').click(function(){
		uxl.returnToList(uxl.getScreenURL('APM0060'));
	});
	
	// 코드 유형 등록
	$('#insertBtn').click(function(){
		insertCodeCategory();
	});
	
	// Dynamic 버튼 초기화
	if($('#CODE_TP').val()!="DN"){
		$('#viewCodeBtn').parent().hide();
		$('label[for=TABLE_ID]').find('span').remove();
		$('label[for=CODE_COLUMN_ID]').find('span').remove();
		$('label[for=NAME_COLUMN_ID]').find('span').remove();
		$('#TABLE_ID').removeAttr('metaessential').parent().parent().hide();
		$('#CODE_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
		$('#NAME_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
		$('#CODE_QUERY_CONTENT').parent().parent().hide();
	}
	
	if($('#CODE_TP').val()!="EN"){
		$('#ENUM_CLASS_NAME').parent().parent().hide();
	}
	
	// Dynamic 버튼 이벤트
	$('#CODE_TP').change(function(){
		if($(this).val()=="DN"){
			if($('input[name=MAPPING_YN]:checked').val()=="Y"){
				$('#viewCodeBtn').parent().show();
				$('label[for=TABLE_ID]').append('<span class="required">*</span>');
				$('label[for=CODE_COLUMN_ID]').append('<span class="required">*</span>');
				$('label[for=NAME_COLUMN_ID]').append('<span class="required">*</span>');
				$('#TABLE_ID').attr('metaessential','1').parent().parent().show();
				$('#CODE_COLUMN_ID').attr('metaessential','1').parent().parent().show();
				$('#NAME_COLUMN_ID').attr('metaessential','1').parent().parent().show();
			}
			$('#ENUM_CLASS_NAME').parent().parent().hide();
		}else if($(this).val()=="EN"){
			$('#ENUM_CLASS_NAME').parent().parent().show();
			$('label[for=TABLE_ID]').find('span').remove();
			$('label[for=CODE_COLUMN_ID]').find('span').remove();
			$('label[for=NAME_COLUMN_ID]').find('span').remove();
			$('#TABLE_ID').removeAttr('metaessential').parent().parent().hide();
			$('#CODE_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
			$('#NAME_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
			$('#TABLE_ID').val('');
			$('#CODE_COLUMN_ID').val('');
			$('#NAME_COLUMN_ID').val('');
		}else{
			$('#viewCodeBtn').parent().hide();
			$('label[for=TABLE_ID]').find('span').remove();
			$('label[for=CODE_COLUMN_ID]').find('span').remove();
			$('label[for=NAME_COLUMN_ID]').find('span').remove();
			$('#TABLE_ID').removeAttr('metaessential').parent().parent().hide();
			$('#CODE_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
			$('#NAME_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
			$('#ENUM_CLASS_NAME').parent().parent().hide();
			$('#TABLE_ID').val('');
			$('#CODE_COLUMN_ID').val('');
			$('#NAME_COLUMN_ID').val('');
		} 
	});
	
	// 코드맵핑사용여부
	$('input[name=MAPPING_YN]').change(function(){
			if($(this).val()=="Y"){
				if($('#CODE_TP').val()=="DN"){
					if(!$('label[for=TABLE_ID]').find('span').is('span')){
						$('label[for=TABLE_ID]').append('<span class="required">*</span>');
						$('label[for=CODE_COLUMN_ID]').append('<span class="required">*</span>');
						$('label[for=NAME_COLUMN_ID]').append('<span class="required">*</span>');
					}
					$('#TABLE_ID').attr('metaessential','1').parent().parent().show();
					$('#CODE_COLUMN_ID').attr('metaessential','1').parent().parent().show();
					$('#NAME_COLUMN_ID').attr('metaessential','1').parent().parent().show();					
				}
			}else{
				$('label[for=TABLE_ID]').find('span').remove();
				$('label[for=CODE_COLUMN_ID]').find('span').remove();
				$('label[for=NAME_COLUMN_ID]').find('span').remove();
				$('#TABLE_ID').removeAttr('metaessential').parent().parent().hide();
				$('#CODE_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
				$('#NAME_COLUMN_ID').removeAttr('metaessential').parent().parent().hide();
				$('#TABLE_ID').val('');
				$('#CODE_COLUMN_ID').val('');
				$('#NAME_COLUMN_ID').val('');
			}
	});
});	

// 코드 유형 등록
function insertCodeCategory(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.moveLocation(uxl.getScreenURL('APM0060'));
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.insert.confirm'),
				 success : uxl.getMessage('@message.common.insert.success'),
				 fail : uxl.getMessage('@message.common.insert.fail')
			  }
			
	};
	uxl.callSubmitFunction('insertForm' , url , option );
}
</script>