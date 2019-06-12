<%--
#*
 *  파 일 명 :  APM0016.jsp
 *  설    명 :  Function Alias 목록
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
 
   - PAGE ID : APM0016R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0016.title" text="기능 별칭 목록"/></h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnRegister">
    <a href="#none" title="등록"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="label.APM.function.alias" text="기능별칭"/></label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_ID" name="FUNCTION_ALIAS_ID"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"><ub:message code="label.APM.function.alias.name" text="기능별칭명"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="FUNCTION_ALIAS_NAME" name="FUNCTION_ALIAS_NAME"                       style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch"        title="검색">
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

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name
		colNames:[
			'ID'
		  , 'Name'
		  , '정렬 순서'
		  , '작성일'
		  , '삭제'
		]

		//mapping column
	  , colModel:[
	  		{name:'FUNCTION_ALIAS_ID',    width:10, align:'center', sortable:true}
		  , {name:'FUNCTION_ALIAS_NAME',    width:30, align:'left', sortable:true}
		  , {name:'SORT_ORDER',      width:10, align:'center', sortable:true}
		  , {name:'REG_DATETIME',  width:10, align:'center', sortable:true}
		  , {name:'deleteButton', width:10, align:'center', sortable:false, formatter:setDeleteButton}
		]
	  , autowidth:true
	  , autoheight:true
	  , height:261
	  , multiselect:false
	  , sortname: 'SORT_ORDER'
	  , sortorder: 'ASC'
      , onSelectRow:function(rowId) {
			var selectedRow = $(this).getRowData(rowId);
			var param = "?FUNCTION_ALIAS_ID=" + selectedRow.FUNCTION_ALIAS_ID;
			uxl.openWindow('detailPopup', uxl.getScreenURL('APM0018') + param, {width:500, height:335});
		}
	  ,loadComplete: function (gridData) {
			 $("#jqgh_list_deleteButton").css("cursor", "default");
			 $("#jqgh_list_deleteButton").removeClass("ui-jqgrid-sortable");
		}
	};
	
	uxl.grid('list', options);
	fnSearch();
	
	$('#btnRegister').click(function() {
		uxl.openWindow('registerPopup', uxl.getScreenURL('APM0017'), {width:500, height:230});
	});
	
	$('#btnSearch').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
	
	$('#FUNCTION_ALIAS_ID, #FUNCTION_ALIAS_NAME').keypress(function(event) {
		if (event.keyCode == 13) fnSearch();
	});

});

function setDeleteButton(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='btnDeleteFunctionAlias'>";
	html += "<a href='javascript:deleteFunctionAlias(\"" + rowObject.FUNCTION_ALIAS_ID + "\");' title='삭제'>";
	html += uxl.getMessage('button.common.remove', '삭제');
	html += "</a></span>";

	return html;
}

function deleteFunctionAlias(FUNCTION_ALIAS_ID) {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
	var option = {
		data:{"FUNCTION_ALIAS_ID" : FUNCTION_ALIAS_ID}
	  , validator:function(data,targetForm) {
			var returnVal = false;

			if (confirm(uxl.getMessage('@message.common.delete.confirm'))) {
				returnVal = true;
			}
			
			return returnVal;
		}
	  , success:function(result) {
			fnSearch();
		}
	  , async:true
	  , message : {
			success : uxl.getMessage('@message.common.delete.success'),
			fail : uxl.getMessage('@message.common.delete.fail')
		}
	};
	uxl.callFunction(url, option);
}

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