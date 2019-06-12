<%--
#*
 *  파 일 명 :  APM0019.jsp
 *  설    명 :  Service Code 등록 팝업
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
	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0019R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">서비스코드등록</h1>
<div class="ub-layout pagging"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="CODE_CATEGORY_ID">코드</label></th>
<td id="layout-1_1_2" style='text-align:Left'><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID" maxLength="40" metalength="40"            metaessential="1"           style="text-align:left;width:285px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="ALIAS">Alias</label></th>
<td id="layout-1_2_4" style='text-align:Left'><input type=text  class="ub-control input-text " id="ALIAS" name="ALIAS" maxLength="100" metalength="100"            metaessential="1"           style="text-align:left;width:285px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="FILTER_VALUE">필터</label></th>
<td id="layout-1_3_6" style='text-align:Left'><input type=text  class="ub-control input-text " id="FILTER_VALUE" name="FILTER_VALUE" maxLength="500" metalength="500"                       style="text-align:left;width:285px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="SLEEP_INCLUDE_YN">비활성코드 포함</label></th>
<td id="layout-1_4_8" style='text-align:Left'><select id="SLEEP_INCLUDE_YN" name="SLEEP_INCLUDE_YN" class="ub-control select "     style="width:100px;" size="1" datacid="FLAG_YN"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_FLAG_YN != null){        for(int codeIdx=0; codeIdx < _dl_FLAG_YN.getRowCount(); codeIdx++){            String code = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FLAG_YN.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_5">
<td id="layout-1_5_9" colspan=2 style='text-align:Left'><label class="ub-control label"><span style="font-weight:bold;">*</span>. 필터 설정시 각 항목(컬럼명, 연산자, 비교값) 사이에 가급적 <span style="font-weight:bold;">공백</span>으로 구분해야 한다.<br>&nbsp; <span style="font-weight:bold;">CODE = Y</span> : 코드값이 지정된 값(Y)과 <span style="font-weight:bold;">동일한</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE != Y</span> : 코드값이 지정된 값(Y)과 <span style="font-weight:bold;">상이한</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE ^= Y</span> : 코드값이 지정된 값(Y)으로 <span style="font-weight:bold;">시작하는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE !^= Y</span> : 코드값이 지정된 값(Y)으로 <span style="font-weight:bold;">시작하지 않는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE $= Y</span> : 코드값이 지정된 값(Y)으로 <span style="font-weight:bold;">끝나는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE !$= Y</span> : 코드값이 지정된 값(Y)으로 <span style="font-weight:bold;">끝나지 않는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE *= Y</span> : 코드값이 지정된 값(Y)을 <span style="font-weight:bold;">포함하고</span> 있는 코드<br>&nbsp; <span style="font-weight:bold;">CODE !*= Y</span> : 코드값이 지정된 값(Y)으로 <span style="font-weight:bold;">포함하지 않는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE in A,B,C</span> : 코드값이 지정된 값(A,B,C)에 <span style="font-weight:bold;">포함된</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE !in A,B,C</span> : 코드값이 지정된 값(A,B,C)에 <span style="font-weight:bold;">포함되지 않는</span> 코드<br>&nbsp; <span style="font-weight:bold;">CODE = {PARAMETER_NAME}</span> : 코드값이 특정 <span style="font-weight:bold;">파라미터의 값</span>과 동일한 코드<br>&nbsp; <span style="font-weight:bold;">CODE = {user.id(name|partCode...)}</span> : 코드값이 특정 세션의 사용자 정보값과 동일한 코드<br>&nbsp; <span style="font-weight:bold;">PARENT_CODE = Y</span> : 부모코드값이 지정된 값(Y)과 동일한 코드<br>&nbsp; <span style="font-weight:bold;">CODE_NAME = Y</span> : 코드명이 지정된 값(Y)과 동일한 코드<br>&nbsp; <span style="font-weight:bold;">GROUP = Y</span> : 코드그룹ID가 지정된 값(Y)과 동일한 코드</label></td>
</tr>
</tbody>
</table>
 
<input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	$('#btnInsert').click(function() {
		insertServiceCode();
	});
	
	// 코드유형이 콤보일 때
	/* $("#CODE_CATEGORY_ID").change(function() {
		$("#ALIAS").val($(this).val());
	}); */
	
	//자동완성 기능
	uxl.autocomplete('CODE_CATEGORY_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.CODE_CATEGORY_ID
			  , value : row.CODE_CATEGORY_NM
			  , label : row.CODE_CATEGORY_NM +' [' + row.CODE_CATEGORY_ID + ']'
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#CODE_CATEGORY_ID").val(ui.item.id);
			$("#ALIAS").val(ui.item.id);			
			return false;
		}
	});
});

function insertServiceCode() {
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
	uxl.callSubmitFunction("detailForm", url, option);
}

	
</script>