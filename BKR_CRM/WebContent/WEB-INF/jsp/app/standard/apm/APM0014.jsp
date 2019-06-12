<%--
#*
 *  파 일 명 :  APM0014.jsp
 *  설    명 :  Function 상세
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
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
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_FUNCTION_TYPE = ViewUtil.getResult().getDataList("Code.APMD_FUNCTION_TYPE");
	DataList _dl_FunctionManageInquiry_getFunc = ViewUtil.getResult().getDataList("FunctionManageInquiry.getFunc");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0014R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">기능상세</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnList"        title="목록">
    <a href="#none" title="목록"><span class="ico-list"></span>목록</a>
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
<th id="layout-1_1_1"><label class="ub-control label">Function ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="FUNCTION_ID" name="FUNCTION_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "FUNCTION_ID") %>"  readonly   metaessential="1"           style="text-align:left;width:106px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="CATEGORY_CODE">분류</label></th>
<td id="layout-1_1_4"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:200px;" size="1"    disabled            disabled></select><input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "CATEGORY_CODE") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="FUNCTION_TYPE">Function Type</label></th>
<td id="layout-1_2_6" colspan=3><select id="FUNCTION_TYPE" name="FUNCTION_TYPE" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_FUNCTION_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "FUNCTION_TYPE") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FUNCTION_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_FUNCTION_TYPE.getRowCount(); codeIdx++){            String code = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "FUNCTION_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_7"><label id="lblLinkedType" name="lblLinkedType" class="ub-control label">연결서비스</label></th>
<td id="layout-1_3_8" colspan=3><input type=text  class="ub-control input-text " id="SEARCH_SERVICE" name="SEARCH_SERVICE"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "SERVICE_NAME") %>"                style="text-align:left;width:400px;"><span class="ub-control button inner icon" id="btnSearchService"        title="찾기">    <a href="#none" title="찾기"><span></span>찾기</a></span><span class="ub-control button inner icon" id="btnViewService"        title="상세">    <a href="#none" title="상세"><span></span>상세</a></span><input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "SERVICE_ID") %>"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_9"><label class="ub-control label">연결화면</label></th>
<td id="layout-1_4_10" colspan=3><input type=text  class="ub-control input-text " id="SEARCH_SCREEN" name="SEARCH_SCREEN"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "SCREEN_NAME") %>"                style="text-align:left;width:400px;"><span class="ub-control button inner icon" id="btnSearchScreen">    <a href="#none" title="찾기"><span></span>찾기</a></span><span class="ub-control button inner icon" id="btnViewScreen">    <a href="#none" title="상세"><span></span>상세</a></span><input type=hidden id="SCREEN_ID" name="SCREEN_ID"    value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "SCREEN_ID") %>"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_11"><label class="ub-control label"             for="FUNCTION_NAME">Function Name</label></th>
<td id="layout-1_5_12" colspan=3><input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME" maxLength="200" metalength="200"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "FUNCTION_NAME") %>"     metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_13"><label class="ub-control label">설명</label></th>
<td id="layout-1_6_14" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "DESCRIPTION") %></textarea></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_15"><label class="ub-control label">작성자</label></th>
<td id="layout-1_7_16"><input type=text  class="ub-control input-text " id="REG_USER_ID" name="REG_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "REG_USER_ID") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_7_17"><label class="ub-control label">작성일시</label></th>
<td id="layout-1_7_18"><input type=text  class="ub-control input-text " id="REG_DATETIME" name="REG_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "REG_DATETIME") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_19"><label class="ub-control label">수정자</label></th>
<td id="layout-1_8_20"><input type=text  class="ub-control input-text " id="UPD_USER_ID" name="UPD_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "UPD_USER_ID") %>"  readonly              style="text-align:left;width:100px;"></td>
<th id="layout-1_8_21"><label class="ub-control label">수정일시</label></th>
<td id="layout-1_8_22"><input type=text  class="ub-control input-text " id="UPD_DATETIME" name="UPD_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFunc, "UPD_DATETIME") %>"  readonly              style="text-align:left;width:120px;"></td>
</tr>
</tbody>
</table>
 
</form>
</div>

<div class="ub-layout button bottom"  style="text-align:right;"><span class="ub-control button bottom icon" id="btnUpdate"        title="수정">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="btnDelete"        title="삭제">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>

<h2 class="ub-control title">연결 화면 목록</h2>
<div class="ub-layout list">
	<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;">
		<h3 style="padding-top:120px;">Grid Control</h3>
	</div>
	<table class="ub-control grid" id="list" name="list"></table> 
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"선택안됨", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});

	if ($("#FUNCTION_TYPE").val() == "SE") {
		$("#tblFunc #layout-1_4").hide();
	} else {
		$("#tblFunc #layout-1_3").hide();
	}
	
	$('#btnList').click(function() {
		uxl.returnToList('APM0012');
	});

	$('#btnUpdate').click(function() {
		updateFunction();
	});
	
	$('#btnDelete').click(function() {
		deleteFunction();
	});
	
	$('#btnSearchService').click(function() {
		uxl.openWindow('Popup', uxl.getScreenURL('APM0022'), {width:987, height:520}, serviceEventCallBack);		
	});
	
	$('#btnSearchScreen').click(function() {
		uxl.openWindow('Popup', uxl.getScreenURL('APM0023'), {width:900, height:520}, clientEventCallBack);
	});

	$('#btnViewService').click(function() {
		var svcId = $("#SERVICE_ID").val();
		
		if (uxl.isEmpty(svcId)) {
			alert('연결된 모듈이 없습니다.');
			return;
		} else {
			var param = "?SERVICE_ID=" + svcId;
			uxl.openWindow('servicePopup', uxl.getScreenURL('APM0006') + param, {width:1000, height:660, scrollbars:'yes'});	
		}
	});
	
	$('#btnViewScreen').click(function() {
		var trgScrnId = $("#SCREEN_ID").val();
		
		if (uxl.isEmpty(trgScrnId)) {
			alert('연결된 모듈이 없습니다.');
			return;
		} else {
			var param = "?SCREEN_ID=" + trgScrnId;
			uxl.openWindow('screenPopup', uxl.getScreenURL('APM0031') + param, {width:1000, height:660, scrollbars:'yes'});
		}
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
	
	var options = {
			//header name
			colNames:['분류', '화면ID', '기능ID', '화면명', '화면유형', 'View유형', '연결제거']

			//mapping column
		  , colModel:[
			    {name:'CATEGORY_CODE',    width:10, align:'center'}
			  , {name:'SCREEN_ID',       width:15, align:'center'}
			  , {name:'FUNCTION_ID' , hidden:true}
			  , {name:'SCREEN_NAME',       width:55, align:'left'}
			  , {name:'SCREEN_TYPE',     width:10, align:'center', codeCategory:'APMD_SCREEN_TYPE'}
			  , {name:'VIEW_TYPE', width:10, align:'center', codeCategory:'APMD_SCREEN_VIEW_TYPE'}
			  , {name:'disconnectBtn', width:10, align:'center', formatter:setDisconnectBtn, sortable:false}
			]
		  , autowidth:true
		  , height:131
		  , multiselect:false
		};
		uxl.grid('list', options);
		fnSearch();
});

function setDisconnectBtn(cellValue, opts, rowObject){
	var html = "<span class='ub-control button inner icon' name='btnDisconnect'>";
	html += "<a href='javascript:fnDisconnectScreen(\"" + rowObject.SCREEN_ID + "\", \"" + rowObject.FUNCTION_ID + "\");' title='연결제거'>";
	html += "연결제거</span>";
	
	return html;	
}

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

function updateFunction() {
	var funcId = $("#FUNCTION_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'MODIFY');
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
			uxl.moveLocation(uxl.getScreenURL(_SCREEN_ID) + '?FUNCTION_ID=' + funcId);
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.update.confirm'),
			success : uxl.getMessage('@message.common.update.success'),
			fail : uxl.getMessage('@message.common.update.fail')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

function deleteFunction() {
	//연결화면이 존재할 경우 경고문 표시
	var confirmMessage = '';
	if(uxl.grid.rowCount($('#list')) != 0){
		confirmMessage += '기능 삭제시 연결 화면 정보도 모두 삭제됩니다.\n';
	}
	confirmMessage += uxl.getMessage('@message.common.delete.confirm');
	if(!confirm(confirmMessage)){
		return null;
	}	
	
	var funcId = $("#FUNCTION_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"FUNCTION_ID" : funcId}
	  , validator:function(data,targetForm) {
		  	var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				returnVal = true;
			}
			return returnVal;
		}
	  , success:function(result) {
			uxl.returnToList('APM0012');
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.delete.success'),
			fail    : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}

// 연결화면 목록 조회
function fnSearch(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');	
	var option = {
		data:uxl.grid.getParam('list')
	  , success:function(result) {
			uxl.grid.appendData('list', result, true);
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);	
}

//연결화면 매핑정보 삭제
function fnDisconnectScreen(SCREEN_ID, FUNCTION_ID){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3');	
	var option = {
		data:{SCREEN_ID:SCREEN_ID, FUNCTION_ID:FUNCTION_ID}
	  , success:function(result) {
		  fnSearch();
      }
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.confirm', '연결제거'),
			success : uxl.getMessage('@message.common.success', '연결제거'),
			fail : uxl.getMessage('@message.common.fail', '연결제거')
	  }
	};
	uxl.callFunction(url, option);	
}

</script>