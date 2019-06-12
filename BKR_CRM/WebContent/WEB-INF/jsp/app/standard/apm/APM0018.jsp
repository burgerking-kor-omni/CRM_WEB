<%--
#*
 *  파 일 명 :  APM0018.jsp
 *  설    명 :  Function Alias 상세
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
	DataList _dl_FunctionManageInquiry_getFuncAlias = ViewUtil.getResult().getDataList("FunctionManageInquiry.getFuncAlias");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0018R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">기능 별칭 상세</h1>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="FUNCTION_ALIAS_ID">기능별칭</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_ID" name="FUNCTION_ALIAS_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "FUNCTION_ALIAS_ID") %>"  readonly   metaessential="1"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="FUNCTION_ALIAS_NAME">기능별칭명</label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_NAME" name="FUNCTION_ALIAS_NAME" maxLength="100" metalength="100"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "FUNCTION_ALIAS_NAME") %>"     metaessential="1"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="SORT_ORDER">정렬순서</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="SORT_ORDER" name="SORT_ORDER" maxLength="2" metalength="2"      metaformat="99" value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "SORT_ORDER") %>"     metaessential="1"       onkeypress="allowOnly('0..9');"    style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label">등록자</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="REG_USER_ID" name="REG_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "REG_USER_ID") %>"  readonly              style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_5">
<th id="layout-1_5_9"><label class="ub-control label">등록일</label></th>
<td id="layout-1_5_10"><input type=text  class="ub-control input-text " id="REG_DATETIME" name="REG_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "REG_DATETIME") %>"  readonly              style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_6">
<th id="layout-1_6_11"><label class="ub-control label">수정자</label></th>
<td id="layout-1_6_12"><input type=text  class="ub-control input-text " id="UPD_USER_ID" name="UPD_USER_ID"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "UPD_USER_ID") %>"  readonly              style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_7">
<th id="layout-1_7_13"><label class="ub-control label">수정일</label></th>
<td id="layout-1_7_14"><input type=text  class="ub-control input-text " id="UPD_DATETIME" name="UPD_DATETIME"       value="<%=JspUtils.getDefaultValue(_dl_FunctionManageInquiry_getFuncAlias, "UPD_DATETIME") %>"  readonly              style="text-align:left;width:200px;"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnUpdate"        title="수정">
    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
</span>
<span class="ub-control button bottom icon" id="btnDelete"        title="삭제">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	$('#btnUpdate').click(function() {
		updateFunctionAlias();
	});
	
	$('#btnDelete').click(function() {
		deleteFunctionAlias();
	});
	
});

function updateFunctionAlias() {
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
		  	opener.fnSearch();
		  	window.close();
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

function deleteFunctionAlias() {
	var funcAlsId = $("#FUNCTION_ALIAS_ID").val();
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"FUNCTION_ALIAS_ID" : funcAlsId}
	  , success:function(result) {
			opener.fnSearch();
		  	window.close();
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

	
</script>