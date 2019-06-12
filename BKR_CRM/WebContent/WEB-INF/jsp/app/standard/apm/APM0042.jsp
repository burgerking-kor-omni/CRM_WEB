<%--
#*
 *  파 일 명 :  APM0042.jsp
 *  설    명 :  다국어 리소스 목록
 *  작 성 자 :  이창섭
 *  작 성 일 :  2016.09.28
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2016 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ubqone.com/tags" prefix="ub" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_RES_TP = ViewUtil.getResult().getDataList("Code.RES_TP");
	
	String defaltLang 	= ConfigHolder.LOCALE_DEFAULT_LANGUAGE;
	boolean isMultiLang = ConfigHolder.LOCALE_USE_MULTI_LANGUAGE;
	String[] listLang 	= ConfigHolder.LOCALE_USE_LANGUAGE_CODE;
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0042R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">다국어 리소스 관리</h1>
<div class="ub-layout button top">
<span class="ub-control button top icon" id="register">
    <a href="#none" title="Register"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
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
<th id="layout-1_1_1"><label class="ub-control label">리소스ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="RES_ID" name="RES_ID"       value="${paramMap.RES_ID}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">리소스명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="RES_NM" name="RES_NM"       value="${paramMap.RES_NM}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">리소스유형</label></th>
<td id="layout-1_2_6">
	<select id="RES_CATEGORY" name="RES_CATEGORY" class="ub-control select "     style="width:112px;" size="1" defaultvalue="${paramMap.RES_CATEGORY}">
		<option value="">전체</option>
		<option value="message">message</option>
		<option value="label">label</option>
		<option value="button">button</option>
		<option value="title">title</option>
	</select>
</td>
<th id="layout-1_2_7"><label class="ub-control label">언어별검색</label></th>
<td id="layout-1_2_8">
	<select id="LANG_TP" name="LANG_TP" class="ub-control select "     style="width:112px;" size="1" defaultvalue="${paramMap.LANG_TP}">
		<option value="">전체</option>
<%
	for (int i = 0; i < listLang.length; i++) {
%>
		<option value="<%=listLang[i]%>"><%=listLang[i]%></option>
<%
	}
%>
	</select>
</td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch">
<a href="#none" title="Search">검색</a>
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
	//hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	var options = {
			colNames	: [
			        	   	'리소스ID'
			        	  , '리소스명'
			        	  , '등록일시'
			        	  , '리소스유형'	// hidden
			]
		  , colModel	: [
		                	{name:'RES_ID', width:10, align:'left'}
		                  , {name:'RES_NM', width:10, align:'left'}
		                  , {name:'REG_DT', width:5, align:'center'}
		                  , {name:'RES_TP', hidden:true}	// hidden
			]
		  , autowidth	: true
		  , height		: 444
		  , sortname	: 'REG_DT'
		  , sortorder	: 'DESC'
		  , multiselect	: false
		  , onSelectRow	: function(rowId) {
				var selectedRow = $(this).getRowData(rowId);
				var param = "?FUNCTION_ID=" + selectedRow.FUNCTION_ID;
				
				var url = uxl.getScreenURL('APM0041');
				url = uxl.addQueryToUrl(url, 'RES_ID', selectedRow.RES_ID);
				url = uxl.addQueryToUrl(url, 'RES_TP', selectedRow.RES_TP);
				
				uxl.openWindow('APM0041', url, {
					width : 540,
					height : 300
				});
		  }
	};
	
	uxl.grid('list', options);

	fnSearch();
	
	//조회 이벤트
	$('#btnSearch').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
	
	// 신규등록 버튼
	$('#register').click(function() {
		var url = uxl.getScreenURL('APM0040');
		url = uxl.addQueryToUrl(url, 'isNew', 'Y');
		
		uxl.openWindow('APM0040', url, {
			width : 540,
			height : 300
		});
	});

	$('#RES_ID, #RES_NM, #RES_TP').keypress(function(event) {
		if (event.keyCode == 13) fnSearch();
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