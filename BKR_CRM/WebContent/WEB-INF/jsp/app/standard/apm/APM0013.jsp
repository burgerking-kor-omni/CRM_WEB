<%--
#*
 *  파 일 명 :  APM0013.jsp
 *  설    명 :  Function 등록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-07 다국어 호환 작업 - by 이창섭
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
 
   - PAGE ID : APM0013R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0013.title" text="기능 등록" /></h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnList"        title="목록">
    <a href="#none" title="목록"><span class="ico-list"></span><ub:message code="button.common.list" text="목록" /></a>
</span>
</div>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal " id="tblFunc">
<colgroup>
<col width="150px"/>
<col width="40%"/>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CATEGORY_CODE"><ub:message code="label.APM.category" text="분류" /></label></th>
<td id="layout-1_1_2"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:200px;" size="1"       metaessential="1"></select></td>
<td id="layout-1_1_3"></td>
<td id="layout-1_1_4"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="FUNCTION_TYPE"><ub:message code="label.APM.function.type" text="기능 유형" /></label></th>
<td id="layout-1_2_6" colspan=3><select id="FUNCTION_TYPE" name="FUNCTION_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_FUNCTION_TYPE"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FUNCTION_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_FUNCTION_TYPE.getRowCount(); codeIdx++){            String code = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label id="lblLinkedType" name="lblLinkedType" class="ub-control label"><ub:message code="label.APM.connected.service" text="연결 서비스" /></label></th>
<td id="layout-1_3_8" colspan=3><input type=text  class="ub-control input-text " id="SEARCH_SERVICE" name="SEARCH_SERVICE"                       style="text-align:left;width:400px;"><span class="ub-control button inner icon" id="btnSearchService">    <a href="#none" title="찾기"><span></span><ub:message code="button.APM0013.search.service" text="찾기" /></a></span><input type=hidden id="SERVICE_ID" name="SERVICE_ID"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label"><ub:message code="label.APM.connected.screen" text="연결 화면" /></label></th>
<td id="layout-1_4_10" colspan=3><input type=text  class="ub-control input-text " id="SEARCH_SCREEN" name="SEARCH_SCREEN"                       style="text-align:left;width:400px;"><span class="ub-control button inner icon" id="btnSearchScreen">    <a href="#none" title="찾기"><span></span><ub:message code="button.APM0013.search.screen" text="찾기" /></a></span><input type=hidden id="SCREEN_ID" name="SCREEN_ID"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_11"><label class="ub-control label"             for="FUNCTION_NAME"><ub:message code="label.APM.function.name" text="기능명" /></label></th>
<td id="layout-1_5_12" colspan=3><input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME" maxLength="200" metalength="200"            metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_13"><label class="ub-control label"><ub:message code="label.APM.function.description" text="섦명" /></label></th>
<td id="layout-1_6_14" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"></textarea></td>
</tr>
</tbody>
</table>
 
</form>
</div>
<div class="ub-layout button bottom"  style="text-align:right;"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span><ub:message code="button.common.save" text="저장" /></a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	$("#tblFunc #layout-1_3").hide();
	$("#tblFunc #layout-1_4").hide();
	
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"선택안됨"});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});
	
	$('#btnList').click(function() {
		uxl.returnToList('APM0012');
	});

	$('#btnInsert').click(function() {
		insertFunction();
	});

	$('#btnSearchService').click(function() {
		uxl.openWindow('Popup', uxl.getScreenURL('APM0022'), {width:987, height:520}, serviceEventCallBack);		
	});
	
	$('#btnSearchScreen').click(function() {
		uxl.openWindow('Popup', uxl.getScreenURL('APM0023'), {width:900, height:520}, clientEventCallBack);
	});
	
	$("#FUNCTION_TYPE").change(function() {
		var value = $(this).val();
		
		if ($.trim(value) != "") {
			if (value == "SE") {
				$("#tblFunc #layout-1_3").show();
				$("#tblFunc #layout-1_4").hide();
			} else {
				$("#tblFunc #layout-1_3").hide();
				$("#tblFunc #layout-1_4").show();
			}
		} else {
			$("#tblFunc #layout-1_3").hide();
			$("#tblFunc #layout-1_4").hide();
		}
		
		$("#SERVICE_ID").val("");
		$("#SCREEN_ID").val("");
		$("#SEARCH_SERVICE").val("");
		$("#SEARCH_SCREEN").val("");
	});
	
	//자동완성 기능 
	uxl.autocomplete('SEARCH_SERVICE', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
	    minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.SERVICE_ID
			  , value : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
			  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
			  , text  : row.SERVICE_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SERVICE_ID").val(ui.item.id);
			$("#FUNCTION_NAME").val(ui.item.text + " 호출");
			$("#DESCRIPTION").val(ui.item.text + " 호출");
		}
	});
	
	//자동완성 기능
	uxl.autocomplete('SEARCH_SCREEN', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2') ,{
	    minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.SCREEN_ID
			  , value : '[' + row.SCREEN_ID + ']  ' + row.SCREEN_NAME
			  , label : '[' + row.SCREEN_ID + ']  ' + row.SCREEN_NAME
			  , text  : row.SERVICE_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SCREEN_ID").val(ui.item.id);
			$("#FUNCTION_NAME").val(ui.item.text + " 호출");
			$("#DESCRIPTION").val(ui.item.text + " 호출");
		}
	});
});

function serviceEventCallBack(returnData) {
	$("#SERVICE_ID").val(returnData.SERVICE_ID);
	$("#SEARCH_SERVICE").val("[" + returnData.SERVICE_ID + "] " + returnData.SERVICE_NAME);
	$("#FUNCTION_NAME").val(returnData.SERVICE_NAME + " 호출");
	$("#DESCRIPTION").val(returnData.SERVICE_NAME + " 호출");
}

function clientEventCallBack(returnData) {
	$("#SCREEN_ID").val(returnData.SCREEN_ID);
	$("#SEARCH_SCREEN").val("[" + returnData.SCREEN_ID + "] " + returnData.SCREEN_NAME);
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
		  	uxl.moveLocation(uxl.getScreenURL('APM0014') + '?FUNCTION_ID=' + funcId);
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