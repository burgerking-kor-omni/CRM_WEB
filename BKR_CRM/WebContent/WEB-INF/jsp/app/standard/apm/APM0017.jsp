<%--
#*
 *  파 일 명 :  APM0017.jsp
 *  설    명 :  Function Alias 등록
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0017R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0017.title" text="기능 별칭 등록"/></h1>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="FUNCTION_ALIAS_ID"><ub:message code="label.APM.function.alias" text="기능별칭"/></label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_ID" name="FUNCTION_ALIAS_ID" maxLength="20" metalength="20"            metaessential="1"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="FUNCTION_ALIAS_NAME"><ub:message code="label.APM.function.alias.name" text="기능별칭명"/></label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_NAME" name="FUNCTION_ALIAS_NAME" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:200px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="SORT_ORDER"><ub:message code="label.APM.sort.order" text="정렬 순서"/></label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="SORT_ORDER" name="SORT_ORDER" maxLength="2" metalength="2"      metaformat="99"      metaessential="1"       onkeypress="allowOnly('0..9');"    style="text-align:left;width:200px;"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span><ub:message code="button.common.save" text="저장"/></a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	$('#btnInsert').click(function() {
		insertFunctionAlias();
	});
	
});

function insertFunctionAlias() {
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
			opener.fnSearch();
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