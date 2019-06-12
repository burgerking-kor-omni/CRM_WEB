<%--
#*
 *  파 일 명 :  APM0031.jsp
 *  설    명 :  SCREEN 상세 (팝업)
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
	DataList _dl_FUNCTION_ALIAS = ViewUtil.getResult().getDataList("Code.APMD_FUNCTION_ALIAS");
	DataList _dl_LAYOUT_TYPE = ViewUtil.getResult().getDataList("Code.APMD_LAYOUT_TYPE");
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
	DataList _dl_ScreenManageInquiry_getScreen = ViewUtil.getResult().getDataList("ScreenManageInquiry.getScreen");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0031R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">화면 상세</h1>
<div class="ub-layout button top"></div>
<h2 class="ub-control title">기본정보</h2>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal " id="tblScrInfo">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="SCREEN_ID">화면ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID" maxLength="7" metalength="7"       value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnId") %>"  readonly   metaessential="1"           style="text-align:left;width:186px;"><select id="funcAlsIdItems" name="funcAlsIdItems" class="ub-control select "     style="width:120px;" size="1" datacid="APMD_FUNCTION_ALIAS"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_FUNCTION_ALIAS != null){        for(int codeIdx=0; codeIdx < _dl_FUNCTION_ALIAS.getRowCount(); codeIdx++){            String code = _dl_FUNCTION_ALIAS.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FUNCTION_ALIAS.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_1_3"><label class="ub-control label"             for="CATEGORY_CODE">분류</label></th>
<td id="layout-1_1_4"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:200px;" size="1"    disabled   metaessential="1"></select><input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "appCateCd") %>"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"             for="SCREEN_TYPE">화면유형</label></th>
<td id="layout-1_2_6"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select "     style="width:200px;" size="1" datacid="APMD_SCREEN_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnTpCd") %>"     metaessential="1"><%    if(!"".equals("")){        out.println("<OPTION VALUE=\"\"></OPTION>\r\n");    }    if(_dl_SCREEN_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnTpCd"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_2_7"><label class="ub-control label"             for="LAYOUT_TYPE">레이아웃</label></th>
<td id="layout-1_2_8"><select id="LAYOUT_TYPE" name="LAYOUT_TYPE" class="ub-control select "     style="width:200px;" size="1" datacid="APMD_LAYOUT_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnLaytTpCd") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_LAYOUT_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_LAYOUT_TYPE.getRowCount(); codeIdx++){            String code = _dl_LAYOUT_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_LAYOUT_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnLaytTpCd"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_9"><label class="ub-control label"             for="VIEW_TYPE">View유형</label></th>
<td id="layout-1_3_10"><select id="VIEW_TYPE" name="VIEW_TYPE" class="ub-control select "     style="width:200px;" size="1" datacid="APMD_SCREEN_VIEW_TYPE" defaultvalue="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnViewTpCd") %>"     metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_SCREEN_VIEW_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_VIEW_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnViewTpCd"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<th id="layout-1_3_11"><label class="ub-control label">로그인 체크 여부</label></th>
<td id="layout-1_3_12"><input class="ub-control input-checkbox" type="checkbox" id="chkLoginYn" name="chkLoginYn"><label></label></input><input type=hidden id="loginChkYn" name="loginChkYn"    value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "LOGIN_CHECK_YN") %>"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_13"><label id="LBL_PID" name="LBL_PID" class="ub-control label"             for="PID">메타ID</label></th>
<td id="layout-1_4_14"><select id="PID" name="PID" class="ub-control select "     style="width:414px;" size="1"  defaultvalue="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "metaPageId") %>"></select><input type=hidden id="PID_VALUE" name="PID_VALUE"    value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "metaPageId") %>"></td>
<td id="layout-1_4_15"></td>
<td id="layout-1_4_16"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_17"><label class="ub-control label"             for="SCREEN_NAME">화면명</label></th>
<td id="layout-1_5_18" colspan=3><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME" maxLength="100" metalength="100"       value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnNm") %>"     metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_19"><label id="filePathNm" name="filePathNm" class="ub-control label">파일경로</label></th>
<td id="layout-1_6_20" colspan=3><input type=text  class="ub-control input-text " id="FILE_PATH" name="FILE_PATH" maxLength="1000" metalength="1000"       value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "filePathNm") %>"     metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_21"><label class="ub-control label"             for="FILE_NAME">파일명</label></th>
<td id="layout-1_7_22" colspan=3><input type=text  class="ub-control input-text " id="FILE_NAME" name="FILE_NAME" maxLength="100" metalength="100"       value="<%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "fileNm") %>"     metaessential="1"           style="text-align:left;width:400px;"></td>
</tr>
<tr id="layout-1_8">
<th id="layout-1_8_23"><label class="ub-control label">설명</label></th>
<td id="layout-1_8_24" colspan=3><textarea class="ub-control textarea " id="DESCRIPTION" name="DESCRIPTION"  metalength="2000"      style="width:412px;" rows="5"                  rows="5"><%=JspUtils.getDefaultValue(_dl_ScreenManageInquiry_getScreen, "scrnDscp") %></textarea></td>
</tr>
</tbody>
</table>
 
</div>
</form>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button bottom icon" id="btnUpdate">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>
<h2 class="ub-control title">기능<div class="ub-layout button inner"  style="text-align:right;"><label class="ub-control label">검색 : </label>
<input type=text  class="ub-control input-text " id="searchKeyword" name="searchKeyword"                       style="text-align:left;width:100px;">
<label class="ub-control label">ID  </label>
<input type=text  class="ub-control input-text " id="FUNCTION_ID" name="FUNCTION_ID"         readonly              style="text-align:left;width:100px;">
<label class="ub-control label">Name  </label>
<input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME"         readonly              style="text-align:left;width:100px;">
<input class="ub-control input-checkbox" type="checkbox" id="START_FUNCTION_YN_CK" name="START_FUNCTION_YN_CK"><label>동기</label></input>
<span class="ub-control button inner icon" id="btnMap">
    <a href="#none" title="매핑"><span></span>매핑</a>
</span>
<span class="ub-control button inner icon" id="btnSearch">
    <a href="#none" title="찾기"><span></span>찾기</a>
</span>
<span class="ub-control button inner icon" id="btnAddFunction">
    <a href="#none" title="신규"><span></span>신규</a>
</span>
</div>
</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="funcList" name="funcList"></table> 
	
</div>
<h2 class="ub-control title">초기 파라미터<div class="ub-layout button inner"  style="text-align:right;"><label class="ub-control label">Name  </label>
<input type=text  class="ub-control input-text " id="PARAMETER_NAME" name="PARAMETER_NAME" maxLength="50" metalength="50"                       style="text-align:left;width:100px;">
<span class="ub-control button inner icon" id="btnAddParameter">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
</div>
</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="paramList" name="paramList"></table> 
	
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
 	var loginChkYn = $("#loginChkYn").val();
	if (loginChkYn == "Y") $("#chkLoginYn").attr("checked", true);
 
	var scrnViewTpCd = $("#VIEW_TYPE").val();
	
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"선택안됨", selectValue:$("#CATEGORY_CODE_VALUE").val()} );
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'선택안됨'});
	hsqlData.getPidListDetail("PID", {blankOption:"선택안됨", selectValue:$("#PID_VALUE").val()});
 	
	$("#PID").setRequired(false);
	$("#tblScrInfo #layout-1_4").hide();
	if (scrnViewTpCd == "M") {
		$("#PID").setRequired(true);
		$("#tblScrInfo #layout-1_4").show();
	}
	
	var pidValue = $("#PID_VALUE").val(); 
	if( pidValue == null || pidValue == ''){
		$("#tblScrInfo #layout-1_4").hide();
	}
	
	$("#VIEW_TYPE").change(function() {
		var scrnViewTpCd = $(this).val();
		$("#PID").setRequired(false);
		$("#tblScrInfo #layout-1_4").hide();
		$("#PID option").remove();
		if (scrnViewTpCd == "M") {
			$("#PID").setRequired(true);
			hsqlData.getPidList("PID", {blankOption:"선택안됨", categoryCode:$("#CATEGORY_CODE").val()});
			$("#tblScrInfo #layout-1_4").show();
		}
	});
	
	// jqGrid Cell 내부의 콤보에 Option을 추가하기 위한 원본데이터 콤보 Hide
	$("#funcAlsIdItems").hide();
	
	$('#btnUpdate').click(function() {
		updateScreen();
	});
	
	$('#btnMap').click(function() {
		var funcId = $("#FUNCTION_ID").val();
		
		if($.trim(funcId) == "") {
			alert('기능을 선택하십시오.');
			return;
		}
		
		insertScreenFunction();
	});
	
	$('#btnSearch').click(function() {
		uxl.openWindow('searchPopup', uxl.getScreenURL('APM0004'), {width:1000, height:520}, callBackFunction);
	});
	
	$('#btnAddFunction').click(function() {
		var param = "?SCREEN_ID=" + $("#SCREEN_ID").val();
		uxl.openWindow('addFuncPopup', uxl.getScreenURL('APM0011') + param, {width:780, height:325}, callBackAddFunction);
	});
	
	$('#btnAddParameter').click(function() {
		insertScreenParameter();
	});
	
	$('#PARAMETER_NAME').keyup(function(event) {
		if (event.which == 13) insertScreenParameter();
	});

	$('#btnUpdateParameter').click(function() {
		updateScreenParameter();
	});
	
	$("#VIEW_TYPE").change(function() {
		var scrnViewTpCd = $(this).val();
		
		$("#PID").setRequired(false);
		if (scrnViewTpCd == "M") {
			$("#PID").setRequired(true);
		}
	});
	
	$("#chkLoginYn").change(function() {
		$("#loginChkYn").val(((this.checked) ? "Y" : "N"));
	});
	
	var funcOptions = {
			//header name
			colNames:[
				'Function ID'
			  , 'Function Name'
			  , 'Function Type'
			  , 'Alias'
			  , '동기'
			  , '연결모듈'
			  , '삭제'
			]

			//mapping column
		  , colModel:[
				{name:'FUNCTION_ID',       width:10, align:'center'}
			  , {name:'FUNCTION_NAME',       width:20, align:'left'}
			  , {name:'FUNCTION_TYPE',     width:10, align:'center', codeCategory:'APMD_FUNCTION_TYPE'}
			  , {name:'FUNCTION_ALIAS_ID',    width:20, align:'center', formatter:setfunctionAliasCombo,  title:false}
			  , {name:'START_FUNCTION_YN',   width:5, align:'center', formatter:setStartFunctionYnCheck, title:false}
			  , {name:'SERVICE_ID',        width:10, align:'center'}
			  , {name:'deleteButton', width:7, align:'center', formatter:setDeleteButton}
			]
		  , autowidth:true
		  , multiselect:false
		  , onCellSelect:function(rowId, iCol, cellContent, e) {
				var selectedRow = $(this).getRowData(rowId);
				
				if (iCol == 0) { // Function 상세팝업 호출
					var param = "?FUNCTION_ID=" + selectedRow.FUNCTION_ID;
					uxl.openWindow('functionPopup', uxl.getScreenURL('APM0021') + param, {width:780, height:380});
				} else if (iCol == 1) { // Function 상세팝업 호출
					var param = "?FUNCTION_ID=" + selectedRow.FUNCTION_ID;
					uxl.openWindow('functionPopup', uxl.getScreenURL('APM0021') + param, {width:780, height:380});
				} else if (iCol == 2) { // Function 상세팝업 호출
					var param = "?FUNCTION_ID=" + selectedRow.FUNCTION_ID;
					uxl.openWindow('functionPopup', uxl.getScreenURL('APM0021') + param, {width:780, height:380});
				} else if (iCol == 5) { // Service 상세팝업 호출
					var param = "?SERVICE_ID=" + selectedRow.SERVICE_ID;
					uxl.openWindow('servicePopup', uxl.getScreenURL('APM0006') + param, {width:1000, height:660, scrollbars:'yes'});	
				}  
		    }
		};
			
		uxl.grid('funcList', funcOptions);
		fnSearch();

		var paramOptions = {
			//header name
			colNames:[
				'Name'
			  , 'Value'
			  , '사용'
			  , '저장'
			  , '삭제'
			]

			//mapping column
		  , colModel:[
				{name:'PARAMETER_NAME',      width:15, align:'center'}
			  , {name:'DEFAULT_VALUE',      width:30, align:'left',   formatter:setValueTextBox,      title:false}
			  , {name:'USE_YN',        width:10, align:'center',      formatter:setUseYnCheckBox,     title:false}
			  , {name:'saveButton',   width:10, align:'center',       formatter:setUpdateParamButton, title:false}
			  , {name:'deleteButton', width:10, align:'center',       formatter:setDeleteParamButton, title:false}
			]
		  , autowidth:true
		  , multiselect:false
		};
				
		uxl.grid('paramList', paramOptions);
		fnSearchParameter();
		
		
		//자동완성 기능
		uxl.autocomplete('searchKeyword', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2') ,{
			minLength : 2
		  , itemExtractor : function(row) {
				var item = {
					id : row.FUNCTION_ID
				  , value : row.FUNCTION_NAME
				  , label : '[' + row.FUNCTION_ID + ']  ' + row.FUNCTION_NAME
				};
				return item;
			}
		  , select: function(event, ui) {
				$("#FUNCTION_ID").val(ui.item.id);
				$("#FUNCTION_NAME").val(ui.item.value);
			}
		});

});

function callBackAddFunction(returnData){
	if (returnData.funcId == null) return;
	if (returnData.scrnId == null) return;

	if (confirm('저장된 Function을 화면에 매핑하시겠습니까?')) {
		insertCallBackScreenFunction(returnData.scrnId, returnData.funcId);		
  	}
}

function callBackFunction(returnData) {
	if (returnData.checkedFuncIds == null) return;
	if (returnData.checkedFuncIds.length == 0) return;
	
	// Function 중복체크 (팝업에서 Multi로 Function ID 넘어옴)
	var data = $('#funcList').jqGrid('getRowData');
	var allFuncIds = new Array();
	$.each(data, function(index, item) {
		allFuncIds.push(item.FUNCTION_ID);
	});

	var funcIds = new Array();
	var funcIdString = allFuncIds.join(",");
	
	$.each(returnData.checkedFuncIds, function(index, item) {
		if (funcIdString.indexOf(item) < 0) {
			funcIds.push(item);
		}
	});
	
	var scrnId = $("#SCREEN_ID", detailForm).val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED4');
	var option = {
		data:{"SCREEN_ID" : scrnId, "FUNCTION_IDS" : funcIds}
	  , validator:function(data,targetForm) {
			var returnVal = true;
			
			return returnVal;
		}
	  , success:function(result) {
			fnSearch();
		}
	  , async:true
	};
	uxl.callFunction(url, option);
	
}


function setChangeEvent() {
	$("select[name='FUNCTION_ALIAS_ID']").unbind("change").bind("change", function() {
		var pos = $("select[name='FUNCTION_ALIAS_ID']").index($(this));
		updateScreenFunction(pos, event.srcElement);
	});

	$("input[name='START_FUNCTION_YN']").unbind("change").bind("change", function() {
		var pos = $("input[name='START_FUNCTION_YN']").index($(this));
		updateScreenFunction(pos, event.srcElement);
	});
}

function setfunctionAliasCombo(cellValue, opts, rowObject) {
	var html = "<select style='width:100%' name='FUNCTION_ALIAS_ID'>";

	html += "<option value=''></option>";
	
	$("#funcAlsIdItems option", detailForm).each(function() {
		html += "<option value='" + $(this).val() + "' " + ((cellValue==$(this).val()) ? "selected" : "") + " >" + $(this).text() + "</option>";
	});
	
	html += "</select>";
	html += "<input type='hidden' name='funcAlsIdOrigin' value='" + cellValue + "' >";
	
	return html;
}

function setStartFunctionYnCheck(cellValue, opts, rowObject) {
	var html = "<input type='checkbox' name='START_FUNCTION_YN' " + ((cellValue=='Y') ? "checked" : "") + ">";
	html += "<input type='hidden' name='strtFuncYnOrigin' value='" + cellValue + "' >";
	return html;
}

function setDeleteButton(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='btnDeleteFunction'>";
	html += "<a href='javascript:deleteScreenFunction(\"" + rowObject.FUNCTION_ID + "\");' title='삭제'>";
	html += "삭제</span>";
	
	return html;
}

function setValueTextBox(cellValue, opts, rowObject) {
	var html = "<input type='text' class='ub-control input-text' name='DEFAULT_VALUE' value='" + rowObject.DEFAULT_VALUE + "' style='width:95%'>";
	return html;
}

function setUseYnCheckBox(cellValue, opts, rowObject) {
	var html = "<input type='checkbox' name='USE_YN' " + ((cellValue=='Y') ? "checked" : "") + ">";
	return html;
}

function setUpdateParamButton(cellValue, opts, rowObject) {
	var rowId = opts.rowId;
	var html = "<span class='ub-control button inner icon' name='btnUpdateParameter'>";
	html += "<a href='javascript:updateScreenParameter(" + rowId + ", \"" + rowObject.PARAMETER_NAME + "\");' title='저장'>";
	html += "저장</a></span>";

	return html;
}

function setDeleteParamButton(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='btnDeleteParameter'>";
	html += "<a href='javascript:deleteScreenParameter(\"" + rowObject.PARAMETER_NAME + "\");' title='삭제'>";
	html += "삭제</a></span>";
	
	return html;
}


function fnSearch() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:{}//uxl.grid.getParam('funcList')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('funcList', result, true);
			setChangeEvent();
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);		
}

function fnSearchParameter() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:uxl.grid.getParam('paramList')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('paramList', result, true);
			setChangeEvent();
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);		
}

function updateScreen() {
	var scrnId = $("#SCREEN_ID").val();
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
			uxl.moveLocation(uxl.getScreenURL(_SCREEN_ID) + '?SCREEN_ID=' + scrnId);
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


function deleteScreen() {
	var scrnId = $("#SCREEN_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"SCREEN_ID" : scrnId}
	  , success:function(result) {
			uxl.returnToList('APM0001');	
		}
	  , async:true
	  , message : {
		  	confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}

function insertScreenFunction() {
	var scrnId = $("#SCREEN_ID").val();
	var funcId = $("#FUNCTION_ID").val();
	var strtFuncYn = "N";
	var isChecked = $("#START_FUNCTION_YN_CK").is(":checked"); 
	if (isChecked) strtFuncYn = "Y";
	var isExist = false;
	
	// Function 중복체크
	var data = $('#funcList').jqGrid('getRowData');
	$.each(data, function(index, item) {
		if (funcId == item.FUNCTION_ID) {
			alert('등록된 기능입니다.');
			isExist = true;
			return false;
		}
	});

	if (!isExist) {
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
		var option = {
			data:{
				"SCREEN_ID" : scrnId,
			    "FUNCTION_ID" : funcId,
			    "START_FUNCTION_YN" : strtFuncYn
			}
		  , validator:function(data,targetForm) {
				var returnVal = true;
				return returnVal;
			}
		  , success:function(result) {
				fnSearch();
				
				$("#searchKeyword").val("");
				$("#FUNCTION_ID").val("");
				$("#FUNCTION_NAME").val("");
				$("#START_FUNCTION_YN_CK").removeAttr("checked");
			}
		  , async:true
		  , message : {
			    confirm : uxl.getMessage('@message.common.insert.confirm'),
				success : uxl.getMessage('@message.common.insert.success'),
				fail : uxl.getMessage('@message.common.insert.fail')
			}
		};
		uxl.callFunction(url, option);
	}
}

function updateScreenFunction(pos, srcElement) {
	var data = $('#funcList').jqGrid('getRowData', pos);
	var funcAlsId = $("select[name='FUNCTION_ALIAS_ID']").eq(pos).val();
	var scrnId = $("#SCREEN_ID").val();
	var funcId = data.FUNCTION_ID;
	var strtFuncYn = "N";
	var isChecked = $("input[name='START_FUNCTION_YN']").eq(pos).is(":checked"); 
	if (isChecked) strtFuncYn = "Y";
	var isExist = false;
	
	// Function Alias 중복체크
	var data = $('#funcList').jqGrid('getRowData');
	$.each(data, function(index, item) {
		if (funcAlsId == $(item.FUNCTION_ALIAS_ID)[1].value) {
			alert('등록된 기능명칭입니다.');
			isExist = true;
			// jqGrid내 Combo or Checkbox Original value로 reset
			if ($(srcElement).attr("name") == "FUNCTION_ALIAS_ID") {
				var originalValue = $("input[name='funcAlsIdOrigin']").eq(pos).val();
				$(srcElement).val(originalValue);
			} else {
				var originalValue = $("input[name='strtFuncYnOrigin']").eq(pos).val();
				
				if (originalValue == "Y") {
					$(srcElement).attr("checked", "checked");
				} else {
					$(srcElement).removeAttr("checked");
				}
			}
			return false;
		}
	});
	
	if(!isExist){
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED9');
		var option = {
			data:{
				"SCREEN_ID" : scrnId
			  , "FUNCTION_ID" : funcId
			  , "FUNCTION_ALIAS_ID" : funcAlsId
			  , "START_FUNCTION_YN" : strtFuncYn
			}
		  , validator:function(data,targetForm) {
				var returnVal = false;
				
				if (confirm(uxl.getMessage('@message.common.insert.confirm'))) {
					returnVal = true;
				} else {
					// jqGrid내 Combo or Checkbox Original value로 reset
					if ($(srcElement).attr("name") == "FUNCTION_ALIAS_ID") {
						var originalValue = $("input[name='funcAlsIdOrigin']").eq(pos).val();
						$(srcElement).val(originalValue);
					} else {
						var originalValue = $("input[name='strtFuncYnOrigin']").eq(pos).val();
						
						if (originalValue == "Y") {
							$(srcElement).attr("checked", "checked");
						} else {
							$(srcElement).removeAttr("checked");
						}
					}
				}
				
				return returnVal;
			}
		  , success:function(result) {
				fnSearch();
			}
		  , async:true
		};
		uxl.callFunction(url, option);	
	}
}

function deleteScreenFunction(funcId) {
	var scrnId = $("#SCREEN_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3');
	var option = {
		data:{"SCREEN_ID" : scrnId, "FUNCTION_ID" : funcId}
	  , success:function(result) {
			fnSearch();
		}
	  , async:true
	  , message : {
		  	confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}

function insertScreenParameter() {
	var scrnId = $("#SCREEN_ID").val();
	var paramNm = $.trim($("#PARAMETER_NAME").val());
	var isExist = false;

	if (paramNm == "") {
		alert('파라미터명을 입력하십시오.');
		return;
	}
	
	// Function 중복체크
	var data = $('#paramList').jqGrid('getRowData');
	$.each(data, function(index, item) {
		if (paramNm == item.PARAMETER_NAME) {
			alert('등록된 파라미터입니다.');
			isExist = true;
			return false;
		}
	});

	if (!isExist) {
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED6');
		var option = {
			data:{"SCREEN_ID" : scrnId, "PARAMETER_NAME" : paramNm, "USE_YN" : "Y"}
		  , success:function(result) {
				fnSearchParameter();
			}
		  , async:true
		  , message : {
			  	confirm : uxl.getMessage('@message.common.confirm','추가'),
				success : uxl.getMessage('@message.common.success','추가'),
				fail : uxl.getMessage('@message.common.fail','추가')
			}
		};
		uxl.callFunction(url, option);
	}
}

function updateScreenParameter(rowId, paramNm) {
	var scrnId = $("#SCREEN_ID").val();
	var dfltVal = $("input[name='DEFAULT_VALUE']").eq(rowId).val();
	var useYn = "N";
	var isChecked = $("input[name='USE_YN']").eq(rowId).is(":checked"); 
	if (isChecked) useYn = "Y";

	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED7');
	var option = {
		data:{"SCREEN_ID" : scrnId, "PARAMETER_NAME" : paramNm, "DEFAULT_VALUE" : dfltVal, "USE_YN" : useYn}
	  , validator:function(data,targetForm) {
			var returnVal = false;

			if (confirm(uxl.getMessage('@message.common.update.confirm'))) {
				returnVal = true;
			}
			
			return returnVal;
		}
	  , success:function(result) {
			fnSearchParameter();
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.update.success'),
			fail : uxl.getMessage('@message.common.update.fail')
		}
	};
	uxl.callFunction(url, option);
}

function deleteScreenParameter(paramNm) {
	var scrnId = $("#SCREEN_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED8');
	var option = {
		data:{"SCREEN_ID" : scrnId, "PARAMETER_NAME" : paramNm}
	  , success:function(result) {
			fnSearchParameter();
		}
	  , async:true
	  , message : {
		  	confirm : uxl.getMessage('@message.common.delete.confirm'),
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}

function insertCallBackScreenFunction(scrnId, funcId) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	
	var option = {
		data:{
			"SCREEN_ID" : scrnId
		  , "FUNCTION_ID" : funcId
		  , "START_FUNCTION_YN" : "N"
		}
	  , validator:function(data,targetForm) {
			var returnVal = true;
			return returnVal;
		}
	  , success:function(result) {
			fnSearch();
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	};
	uxl.callFunction(url, option);
}
</script>