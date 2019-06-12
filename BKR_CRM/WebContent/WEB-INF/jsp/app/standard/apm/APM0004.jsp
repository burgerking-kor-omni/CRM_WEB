<%--
#*
 *  파 일 명 :  APM0004.jsp
 *  설    명 :  Function 목록(팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-10 다국어 호환 작업 - by 이창섭
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
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
 
   - PAGE ID : APM0004R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0004.title" text="기능 선택"/></h1>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="120px"/>
<col />
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_1_2"><ub:code-select codeCategory="CATEGORY_CODE" id="CATEGORY_CODE" style="width:200px;" blankType="1"/></td>
<th id="layout-1_1_3"><label class="ub-control label"><ub:message code="label.APM.function.type" text="기능유형"/></label></th>
<td id="layout-1_1_4"><ub:code-select codeCategory="APMD_FUNCTION_TYPE" id="FUNCTION_TYPE" style="width:140px;" blankType="1" defaultValue="${paramMap.FUNCTION_TYPE}"/></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label"><ub:message code="label.APM.function.id" text="기능ID"/></label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="FUNCTION_ID" name="FUNCTION_ID" maxLength="10" metalength="10"       value="${paramMap.FUNCTION_ID}"                style="text-align:left;width:186px;"></td>
<th id="layout-1_2_7"><label class="ub-control label"><ub:message code="label.APM.function.name" text="기능명"/></label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME"       value="${paramMap.FUNCTION_NAME}"                style="text-align:left;width:126px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch"        title="RSC:l.button.com.search">
<a href="#none" title="Search"><ub:message code="button.common.search" text="검색"/></a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnConfirm">
    <a href="#none" title="Add"><span class="ico-add"></span><ub:message code="button.common.add" text="추가"/></a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체"});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'전체'});
	
	$('#btnConfirm').click(function() {
		var checkedRows = $("#list").jqGrid('getGridParam','selarrrow');
		var checkedFuncIds = new Array();
		
		if (checkedRows.length == 0) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		}
		
		if (confirm(uxl.getMessage('@message.common.confirm', uxl.getMessage('@message.common.add','추가')))) {
			$.each(checkedRows, function(index, item) {
				var data = $('#list').jqGrid('getRowData', item);
				checkedFuncIds.push(data.FUNCTION_ID);
			});

			var returnData = {
				"checkedFuncIds" : checkedFuncIds
			};

			uxl.pushToParent(returnData);
			self.close();
		}
	});
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name

		colNames:[
				'<%=MessageUtils.getMessage("label.APM.category", "분류") %>'
			  , '<%=MessageUtils.getMessage("label.APM.function.id", "기능ID") %>'
			  , '<%=MessageUtils.getMessage("label.APM.function.name", "기능명") %>'
			  , '<%=MessageUtils.getMessage("label.APM.function.type", "기능유형") %>'
			  , '<%=MessageUtils.getMessage("label.APM.connected.service", "연결서비스") %>'
		]

		//mapping column
	  , colModel:[
		    {name:'CATEGORY_CODE',    width:10, align:'center'}
		  , {name:'FUNCTION_ID',       width:10, align:'center'}
		  , {name:'FUNCTION_NAME',       width:50, align:'left'}
		  , {name:'FUNCTION_TYPE',     width:10, align:'center', codeCategory:'APMD_FUNCTION_TYPE'}
		  , {name:'MODULE_NAME', width:30, align:'left'}
		]
	  , autowidth:true
	  , height:261
	  , multiselect:true
	};
	uxl.grid('list', options);

	//자동완성 기능
	uxl.autocomplete('FUNCTION_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 3
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
			return false;
		}
	});

	//자동완성 기능
	uxl.autocomplete('FUNCTION_NAME', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
		minLength : 3
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
			return false;
		}
	});

	//조회 이벤트
	$('#btnSearch').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
	
});

//조회
function fnSearch() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:uxl.grid.getParam('list')
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
			uxl.grid.appendData('list', result, true);
		}
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);		
}

</script>