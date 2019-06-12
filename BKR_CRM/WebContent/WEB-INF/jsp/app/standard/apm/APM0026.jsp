<%--
#*
 *  파 일 명 :  APM0026.jsp
 *  설    명 :  Mask Column 추가 (팝업)
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0026R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">데이터 변환 등록</h1>
<div class="ub-layout details"    style="height:200px;"><form id="registForm" name="registForm"><table class="ub-control table normal " id="tblMask">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="POINTCUT_CD">적용위치</label></th>
<td id="layout-1_1_2" style='text-align:Left'></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="DATALIST_ID">DataList ID</label></th>
<td id="layout-1_2_4" style='text-align:Left'><input type=text  class="ub-control input-text " id="DATALIST_ID" name="DATALIST_ID" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:286px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="COLUMN_NAME">Column Name</label></th>
<td id="layout-1_3_6" style='text-align:Left'><input type=text  class="ub-control input-text " id="COLUMN_NAME" name="COLUMN_NAME" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:286px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="MASK_ID">Mask</label></th>
<td id="layout-1_4_8" style='text-align:Left'><select id="MASK_ID" name="MASK_ID" class="ub-control select "     style="width:300px;" size="1"       metaessential="1"></select></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnAdd"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){	
	$('#btnAdd').click(function() {
		validatorCheck();
	});
	
	fnGetPointCutList();
	fnGetMaskComboList();
	
	//자동완성 기능
	/* uxl.autocomplete('NM_MASK', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.ID_MASK
			  , value : row.NM_MASK
			  , label : '[' + row.ID_MASK + ']  ' + row.NM_MASK
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#MASK_ID").val(ui.item.id);
			$("#NM_MASK").val(ui.item.value);
		}
	}); */
});

function validatorCheck(){
	var pointCut = $("input[name='POINTCUT_CD']:checked").val();
	if(pointCut == '' || pointCut == null){
		alert(uxl.getMessage('@message.common.validation.noselect','적용위치'));
		return;
	}
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
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
		  var dt = result.getDataList();
		  var maskCount = dt.rows[0].MASK_COUNT;
		  
		  if(maskCount == 0){
			  insertMaskColumn();
		  }else{
			  alert(uxl.getMessage('@message.common.validation.duplicated'));
			  return;
		  }
		}
	  , async:true
	  , message : {
			confirm : uxl.getMessage('@message.common.insert.confirm'),
		}
	};
	uxl.callSubmitFunction("registForm", url, option);
}

function insertMaskColumn() {
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
			opener.fnSearch();
			window.close();
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	};
	uxl.callSubmitFunction("registForm", url, option);
}

function fnGetPointCutList(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2');
	var option = {
		data:{}
	  , success:function(result) {
			var dataSet = result.getDataList(0);
			if(dataSet.rowCount != 0){
				for(var i = 0; i < dataSet.rowCount; i++){
					var radioBtn = '<input class="ub-control radio" type="radio" id="POINTCUT_CD" name="POINTCUT_CD" value="'+dataSet.rows[i].CODE+'"><label>'+dataSet.rows[i].CODE_NAME+'</label>';
					$("#tblMask #layout-1_1_2").append(radioBtn);
				}
			}
		}
	  , async:true
	};
	uxl.callFunction(url, option);
}

function fnGetMaskComboList(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3');
	var option = {
		data:{}
	  , success:function(result) {
			var dataSet = result.getDataList(0);
			if(dataSet.rowCount != 0){
				$("#MASK_ID").append("<option value>선택안됨</option>");
				for(var i = 0; i < dataSet.rowCount; i++){
					var comboOption = "<option value='"+dataSet.rows[i].ID_MASK+"'>"+dataSet.rows[i].LABEL+"</option>";
					$("#MASK_ID").append(comboOption);
				}
			}
		}
	  , async:true
	};
	uxl.callFunction(url, option);
}
	
</script>