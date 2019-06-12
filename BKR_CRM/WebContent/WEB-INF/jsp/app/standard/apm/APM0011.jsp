<%--
#*
 *  파 일 명 :  APM0011.jsp
 *  설    명 :  Function 등록 (팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-10 다국어 호환 작업 - by 이창섭
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
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_FUNCTION_TYPE = ViewUtil.getResult().getDataList("Code.APMD_FUNCTION_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0011R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0011.title" text="Function 등록"/></h1>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal " id="tblFunc">
<colgroup>
<col width="170px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2">
	<ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:180px;" blankType="2" essential="true"/>
	<input type=hidden id="THIS_SCREEN_ID" name="THIS_SCREEN_ID"    value="${paramMap.SCREEN_ID}">
</td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="FUNCTION_TYPE"><ub:message code="label.APM.function.type" text="기능유형"/></label></th>
<td id="layout-1_2_4">
	<ub:code-select codeCategory="APMD_FUNCTION_TYPE" id="FUNCTION_TYPE" style="width:180px;" blankType="2" essential="true"/>
</td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label id="lblLinkedType" name="lblLinkedType" class="ub-control label"><ub:message code="label.APM.connected.service" text="연결서비스"/></label></th>
<td id="layout-1_3_6">
<input type=text  class="ub-control input-text " id="SERVICE_NAME" name="SERVICE_NAME"         readonly              style="text-align:left;width:400px;">
	<span class="ub-control button inner icon" id="btnSearch">    
		<a href="#none" title="찾기"><span></span><ub:message code="button.APM0011.find" text="찾기"/></a>
	</span>
	<span class="ub-control button inner icon" id="btnRegistService">    
		<a href="#none" title="신규"><span></span><ub:message code="button.APM0011.new" text="신규"/></a>
	</span>
	<input type=hidden id="SERVICE_ID" name="SERVICE_ID">
	<input type=hidden id="SCREEN_ID" name="SCREEN_ID">
</td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="FUNCTION_NAME"><ub:message code="label.APM.function.name" text="기능명"/></label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME" maxLength="200" metalength="200"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label"><ub:message code="label.APM.description" text="설명"/></label></th>
<td id="layout-1_5_10"><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span><ub:message code="button.common.save" text="저장"/></a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	$("#tblFunc #layout-1_3").hide();
	
// 	hsqlData.getCategoryCode("CATEGORY_CODE",{blankOption:"선택안됨"});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});
	
	$('#btnList').click(function() {
		uxl.returnToList('APM0012');
	});

	$('#btnInsert').click(function() {
		insertFunction();
	});

	$('#btnSearch').click(function() {
		var funcTpCd = $("#FUNCTION_TYPE").val();
		
		if (funcTpCd == "SE") {
			uxl.openWindow('Popup', uxl.getScreenURL('APM0022'), {width:987, height:530}, serviceEventCallBack);	
		} else {
			uxl.openWindow('Popup', uxl.getScreenURL('APM0023'), {width:900, height:530}, clientEventCallBack);
		}
		
	});
	
	$('#btnRegistService').click(function(){
		var funcTpCd = $("#FUNCTION_TYPE").val();
		
		if (funcTpCd == "SE") {
			uxl.openWindow('apmdServiceRegistPop', uxl.getScreenURL('APM0036'), {width:1000, height:660}, serviceEventCallBack);
		}
	});
	
	$("#FUNCTION_TYPE").change(function() {
		var value = $(this).val();
		$('#btnRegistService').hide();
		if ($.trim(value) != "") {
			if (value == "SE") {
				$("#lblLinkedType").text(uxl.getMessage('@label.APM.connected.service', '연결서비스'));	
				$('#btnRegistService').show();
			} else {
				$("#lblLinkedType").text(uxl.getMessage('@label.APM.connected.screen', '연결화면'));
			}

			$("#tblFunc #layout-1_3").show();
		} else {
			$("#tblFunc #layout-1_3").hide();
		}
		
		$("#SERVICE_ID").val("");
		$("#SCREEN_ID").val("");
		$("#SERVICE_NAME").val("");
	});
});

function serviceEventCallBack(returnData) {
	$("#SERVICE_ID").val(returnData.SERVICE_ID);
	$("#SERVICE_NAME").val("[" + returnData.SERVICE_ID + "] " + returnData.SERVICE_NAME);
	$("#FUNCTION_NAME").val(returnData.SERVICE_NAME + " 호출");
	$("#DESCRIPTION").val(returnData.SERVICE_NAME + " 호출");
}

function clientEventCallBack(returnData) {
	$("#SCREEN_ID").val(returnData.SCREEN_ID);
	$("#SERVICE_NAME").val("[" + returnData.SCREEN_ID + "] " + returnData.SCREEN_NAME);
	$("#FUNCTION_NAME").val(returnData.SCREEN_NAME + " 호출");
	$("#DESCRIPTION").val(returnData.SCREEN_NAME + " 호출");
}

function insertFunction() {
	// 앞뒤 스페이스 제거
	$("input[type='text'], textarea").each(function() {
		var value = $(this).val();
		$(this).val($.trim(value));
	});
	
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		data:{}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				returnVal = true;
			}
			return returnVal;
		}
	  , success:function(result) {
		  var funcId = result.getResultKey();
		  var scrnId = $("#THIS_SCREEN_ID").val();
		  var returnData = {
				"funcId" : funcId.toString(),
				"scrnId" : scrnId
		  };
		  	uxl.pushToParent(returnData);
		  	window.close();
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.insert.confirm'),
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

</script>