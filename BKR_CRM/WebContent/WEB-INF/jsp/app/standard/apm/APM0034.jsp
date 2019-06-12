<%--
#*
 *  파 일 명 :  APM0034.jsp
 *  설    명 :  서비스쿼리 등록 (팝업)
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
	DataList _dl_QUERY_TYPE = ViewUtil.getResult().getDataList("Code.APMD_QUERY_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0034R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">서비스쿼리 등록</h1>
<form id="detailForm" name="detailForm"><div class="ub-layout details"><table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"             for="QUERY_ID">쿼리 ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="QUERY_ID" name="QUERY_ID" maxLength="50" metalength="50"            metaessential="1"           style="text-align:left;width:300px;"><input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"             for="QUERY_TYPE">쿼리유형</label></th>
<td id="layout-1_2_4"><select id="QUERY_TYPE" name="QUERY_TYPE" class="ub-control select "     style="width:314px;" size="1" datacid="APMD_QUERY_TYPE"      metaessential="1"><%    if(!"선택안됨".equals("")){        out.println("<OPTION VALUE=\"\">선택안됨</OPTION>\r\n");    }    if(_dl_QUERY_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_QUERY_TYPE.getRowCount(); codeIdx++){            String code = _dl_QUERY_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_QUERY_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"             for="RUN_ORDER">실행순서</label></th>
<td id="layout-1_3_6"><input type=text  class="ub-control input-text " id="RUN_ORDER" name="RUN_ORDER" maxLength="2" metalength="2"      metaformat="99"      metaessential="1"           style="text-align:left;width:300px;"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label"             for="DATALIST_ID">DATALIST ID</label></th>
<td id="layout-1_4_8"><input type=text  class="ub-control input-text " id="DATALIST_ID" name="DATALIST_ID" maxLength="50" metalength="50"                       style="text-align:left;width:300px;"></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnInsert"        title="저장">
    <a href="#none" title="Save"><span class="ico-save"></span>저장</a>
</span>
</div>
</div>
</form>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){

	$('#btnInsert').click(function() {
		checkServiceQuery();
	});
	
});

function checkServiceQuery(){
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
			var resultCnt = result.getDataList(0).rows[0].COUNT;
			if(resultCnt == 0){
				insertServiceQuery();
			}else{
				uxl.showMessage("중복된 쿼리 ID 입니다.");
			}
		}
	  , async:true
	};
	uxl.callSubmitFunction('detailForm', url, option);
}

function insertServiceQuery() {
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