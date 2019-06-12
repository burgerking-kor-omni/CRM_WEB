<%--
#*
 *  파 일 명 :  APM0012.jsp
 *  설    명 :  Function 목록
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
	DataList _dl_FUNCTION_TYPE = ViewUtil.getResult().getDataList("Code.APMD_FUNCTION_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0012R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title"><ub:message code="title.APM0012.title" text="기능 관리"/></h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnRegister">
    <a href="#none" title="신규등록"><span class="ico-register"></span><ub:message code="button.common.new" text="신규등록"/></a>
</span>
</div>
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
<col width="120px"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"><ub:message code="label.APM.function.id" text="기능ID"/></label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="FUNCTION_ID" name="FUNCTION_ID" maxLength="10" metalength="10"       value="${paramMap.FUNCTION_ID}"                style="text-align:left;width:126px;"></td>
<th id="layout-1_1_3"><label class="ub-control label"><ub:message code="label.APM.function.name" text="기능명"/></label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="FUNCTION_NAME" name="FUNCTION_NAME"       value="${paramMap.FUNCTION_NAME}"                style="text-align:left;width:126px;"></td>
<th id="layout-1_1_5"></th>
<td id="layout-1_1_6"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_7"><label class="ub-control label"><ub:message code="label.APM.connected.service" text="연결 서비스"/></label></th>
<td id="layout-1_2_8"><input type=text  class="ub-control input-text " id="SEARCH_SERVICE" name="SEARCH_SERVICE" maxLength="10" metalength="10"       value="${paramMap.SEARCH_SERVICE}"                style="text-align:left;width:126px;"></td>
<th id="layout-1_2_9"><label class="ub-control label"><ub:message code="label.APM.connected.screen" text="연결 화면"/></label></th>
<td id="layout-1_2_10"><input type=text  class="ub-control input-text " id="SEARCH_SCREEN" name="SEARCH_SCREEN" maxLength="7" metalength="7"       value="${paramMap.SEARCH_SCREEN}"                style="text-align:left;width:126px;"></td>
<th id="layout-1_2_11"></th>
<td id="layout-1_2_12"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_13"><label class="ub-control label"><ub:message code="label.APM.category" text="분류"/></label></th>
<td id="layout-1_3_14"><select id="CATEGORY_CODE" name="CATEGORY_CODE" class="ub-control select "     style="width:140px;" size="1"></select><input type=hidden id="CATEGORY_CODE_VALUE" name="CATEGORY_CODE_VALUE"    value="${paramMap.CATEGORY_CODE}"></td>
<th id="layout-1_3_15"><label class="ub-control label"><ub:message code="label.APM.function.type" text="기능 유형"/></label></th>
<td id="layout-1_3_16"><select id="FUNCTION_TYPE" name="FUNCTION_TYPE" class="ub-control select "     style="width:140px;" size="1" datacid="APMD_FUNCTION_TYPE" defaultvalue="${paramMap.FUNCTION_TYPE}"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_FUNCTION_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_FUNCTION_TYPE.getRowCount(); codeIdx++){            String code = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_FUNCTION_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            String selected = code.equals(ViewUtil.getParameter().getValue("FUNCTION_TYPE"))?"selected":"";            out.println("<option VALUE=\""+code+"\" "+selected+">"+name+"</option>\r\n");        }    }%></select></td>
<td id="layout-1_3_17"></td>
<td id="layout-1_3_18"></td>
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

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
// 	hsqlData.getCategoryCode("CATEGORY_CODE", {blankOption:"전체", selectValue:$("#CATEGORY_CODE_VALUE").val()});
	uxl.bindComboCode('CATEGORY_CODE', 'CATEGORY_CODE', {emptyOption:'전체'});
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:[
	          	 	'분류ID'
	          	  , uxl.getMessage('label.APM.category', '분류')
	          	  , uxl.getMessage('label.APM.function.id', '기능ID')
	          	  , uxl.getMessage('label.APM.function.name', '기능명')
	          	  , uxl.getMessage('label.APM.function.type', '기능유형')
	          	  , uxl.getMessage('label.APM.connected.service', '연결 서비스')
	          	  , uxl.getMessage('label.APM.mapping.count', '매핑수')
	          	  , uxl.getMessage('label.APM.reg.date', '작성일')
	          	 ]

		//mapping column
	  , colModel:[
		    {name:'CATEGORY_CODE',    width:8,     align:'center', hidden:true}
		  , {name:'CATEGORY_CODE',    width:10,    align:'center'}
		  , {name:'FUNCTION_ID',       width:10,   align:'center'}
		  , {name:'FUNCTION_NAME',       width:50, align:'left'}
		  , {name:'FUNCTION_TYPE',     width:10,   align:'center', codeCategory:'APMD_FUNCTION_TYPE'}
		  , {name:'MODULE_NAME', width:30, align:'left'}
		  , {name:'SCREEN_MAPPING_CNT',    width:5,    align:'center'}
		  , {name:'REG_DATETIME',  width:20, align:'center'}
		]
	  , autowidth:true
	  , autoheight:true
	  , height:261
	  , sortname: 'REG_DATETIME'
	  , sortorder: 'DESC'
	  , multiselect:false
	  , onSelectRow:function(rowId) {
			var selectedRow = $(this).getRowData(rowId);
			var param = "?FUNCTION_ID=" + selectedRow.FUNCTION_ID;
			uxl.moveLocation(uxl.getScreenURL('APM0014') + param);
		}
	};
	uxl.grid('list', options);

	//fnSearch();
	
	//조회 이벤트
	$('#btnSearch').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});
	
	$('#btnRegister').click(function() {
		uxl.moveLocation(uxl.getScreenURL('APM0013'));
	});

	//자동완성 기능
	uxl.autocomplete('FUNCTION_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
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
			return false;
		}
	});

	//자동완성 기능
	uxl.autocomplete('FUNCTION_NAME', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
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
			return false;
		}
	});

	//자동완성 기능
	uxl.autocomplete('SEARCH_SCREEN', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED2') ,{
		minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.SCREEN_ID
			  , value : row.SCREEN_NAME
			  , label : '[' + row.SCREEN_ID + ']  ' + row.SCREEN_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SEARCH_SCREEN").val(ui.item.id);
			return false;
		}
	});

	//자동완성 기능
	uxl.autocomplete('SEARCH_SERVICE', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED3') ,{
		minLength : 2
	  , itemExtractor : function(row) {
			var item = {
				id : row.SERVICE_ID
			  , value : row.SERVICE_NAME
			  , label : '[' + row.SERVICE_ID + ']  ' + row.SERVICE_NAME
			};
			return item;
		}
	  , select: function(event, ui) {
			$("#SEARCH_SERVICE").val(ui.item.id);
			return false;
		}
	});

	$('#FUNCTION_ID, #SEARCH_SERVICE, #SEARCH_SCREEN').keypress(function(event) {
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