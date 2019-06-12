<%--
#*
 *  파 일 명 :  APM0030.jsp
 *  설    명 :  Screen 메타연동 (팝업)
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.02.23
 *  버    전 :  1.0
 *  기타사항 :
 *  수정이력 :  2016-10-07 다국어 호환 작업 - by 이창섭
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0030R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0030.title" text="메타연동"/></h1>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col width="150px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="label.APM.page.id" text="페이지ID"/></label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="PID" name="PID"                       style="text-align:left;width:136px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label"><ub:message code="label.APM.page.name" text="페이지명"/></label></th>
<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DESCRIPTION" name="DESCRIPTION"                       style="text-align:left;width:136px;"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_3_6"><select id="PCLASS" name="PCLASS" class="ub-control select "     style="width:150px;" size="1"></select></td>
</tr>
</tbody>
</table>

<span class="ub-control button search" id="btnSearch">
<a href="#none" title="Search"><ub:message code="button.common.search" text="검색"/></a>
</span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="btnSave">
    <a href="#none" title="Save"><span class="ico-save"></span><ub:message code="button.common.add" text="추가"/></a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	hsqlData.getCategoryCode("PCLASS", {blankOption:"전체"});
	
	$('#btnSave').click(function() {
		var checkedRows = $("#list").jqGrid('getGridParam','selarrrow');
		var checkedPageIds = new Array();
		
		if (checkedRows.length == 0) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		}
		
		if (confirm(uxl.getMessage('@message.common.confirm','추가'))) {
			$.each(checkedRows, function(index, item) {
				var data = $('#list').jqGrid('getRowData', item);
				checkedPageIds.push(data.PID);
			});

			//화면 등록 서비스 호출
			fnRegist(checkedPageIds);
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
				  , '<%=MessageUtils.getMessage("label.APM.page.id", "페이지ID") %>'
				  , '<%=MessageUtils.getMessage("label.APM.page.name", "페이지명") %>'
		         ]

		//mapping column
	  , colModel:[
		    {name:'PCLASS',    width:10, align:'center'}
		  , {name:'PID',       width:10, align:'center'}
		  , {name:'DESCRIPTION',       width:50, align:'left'}
		]
	  , autowidth:true
	  , multiselect:true
	  , height:262
	};
	uxl.grid('list', options);
	fnSearch();
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

//등록
function fnRegist(checkedDatas){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		data:{"CHECKED_DATAS":checkedDatas}
		
	    /*
		 * 조회한 데이터를 그리드에 추가함.
		 * @param {String} 그리드로 변환할 테이블ID
		 * @param {Result} 조회된 데이터 객체 result
		 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
		 */
	  , success:function(result) {
		  opener.fnSearch();
		  self.close();
		}
	  , message : {
			success : uxl.getMessage('@message.common.insert.success'),
			fail : uxl.getMessage('@message.common.insert.fail')
		}
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);		
}
</script>