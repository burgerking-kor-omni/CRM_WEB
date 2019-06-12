<%--
#*
 *  파 일 명 :  APM0009.jsp
 *  설    명 :  서비스코드 목록
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
 
   - PAGE ID : APM0009R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h2 class="ub-control title">서비스코드</h2>
<div class="ub-layout button inner"  style="text-align:right;"><form id="searchForm" name="searchForm"><label class="ub-control label">빠른 추가</label>
<input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"                       style="text-align:left;width:100px;">
<span class="ub-control button inner icon" id="btnAdd"        title="추가">
    <a href="#none" title="Add"><span class="ico-add"></span>추가</a>
</span>
<input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
<input type=hidden id="ALIAS" name="ALIAS">
</form>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->


<style>
	.ub-layout.button.inner{position:relative;margin-right:1px;margin-bottom:5px;background-color:#ffffff;}
</style>
<script type="text/javascript">
uxl.onLoad(function(){
		/*
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
		*/
		
		var options = {
			//header name
			colNames:['코드ID', '코드타입', '코드구분 ID', 'Alias', '코드구분명', '비활성포함', '필터정보', '코드확인', '삭제']

			//mapping column
		  , colModel:[
				{name:'SERVICE_CODE_ID',     width:15, hidden:true}
			  , {name:'CODE_TYPE', hidden:true}
		  	  , {name:'CODE_CATEGORY_ID',     width:15, align:'center'}
			  , {name:'ALIAS',          width:15, align:'center'}
			  , {name:'CODE_CATEGORY_NM',     width:15, align:'center'}
			  , {name:'SLEEP_INCLUDE_YN',    width:10, align:'center', codeCategory:'FLAG_YN'}
			  , {name:'FILTER_VALUE',      width:20, align:'left'}
			  , {name:'codeViewButton', width:10,  align:'center', formatter:setCodeViewButton}
			  , {name:'deleteButton', width:10,  align:'center', formatter:setDeleteButton}
			]
		  , autowidth:true
		  , height:261
		  , multiselect:false
	      , onSelectRow:function(rowid) {
				var svcId = $("#SERVICE_ID").val();
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SERVICE_ID=" + svcId + "&SERVICE_CODE_ID=" + selectedRow.SERVICE_CODE_ID;
				
				uxl.openWindow('Popup', uxl.getScreenURL('APM0020') + param, {width:640, height:514});
			},loadComplete: function (gridData) {
				 $("#jqgh_list_deleteButton").css("cursor", "default");
				 $("#jqgh_list_deleteButton").removeClass("ui-jqgrid-sortable");
			}
		};
		
		uxl.grid('list', options);
		fnSearch();

		$('#btnAdd').click(function() {
			var svcId = $("#SERVICE_ID").val();
			var param = "?SERVICE_ID=" + svcId;
			uxl.openWindow('Popup', uxl.getScreenURL('APM0019') + param, {width:640, height:514});
		});
		
		//자동완성 기능
		uxl.autocomplete('CODE_CATEGORY_ID', uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1') ,{
			minLength : 2
		  , position: { my : "right top", at: "right bottom" }
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
				$("#ALIAS").val(ui.item.value);
				
				insertServiceCode();
				
				return false;
			}
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
		uxl.callSubmitFunction("searchForm", url, option);		
	}

	function setDeleteButton(cellValue, opts, rowObject) {
		var html = "<span class='ub-control button inner icon' name='btnServiceCode'>";
		html += "<a href='javascript:deleteServiceCode(\"" + rowObject.SERVICE_CODE_ID + "\");' title=\"삭제\" >";
		html += "삭제</a></span>";
		
		return html;
	}
	
	function setCodeViewButton(cellValue, opts, rowObject) {
		var html = "<span class='ub-control button inner icon' name='btnCodeView'>";
		html += "<a href='javascript:fnCodeView(\"" + rowObject.CODE_CATEGORY_ID + "\", \""+rowObject.CODE_TYPE+"\");' title=\"코드보기\" >";
		html += "코드보기</a></span>";
		
		return html;
	}
	
	function insertServiceCode() {
		var svcId = $("#SERVICE_ID").val();
		var cdCateCd = $("#CODE_CATEGORY_ID").val();
		
		// 중복체크
		var rows = $('#list').jqGrid('getRowData');
		
		for(var i=0; i<rows.length; i++) {
			var rowData = $('#list').jqGrid('getRowData', i);
			
			if (cdCateCd == rowData.CODE_CATEGORY_ID) {
				alert('등록된 코드유형입니다.');
				
				$("#searchKeyword").val("");
				$("#CODE_CATEGORY_ID").val("");
				
				return;
			}
		}

		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
		var option = {
			data:{"SERVICE_ID" : svcId, "CODE_CATEGORY_ID" : cdCateCd, "ALIAS" : cdCateCd, "FILTER_VALUE" : "", "SLEEP_INCLUDE_YN" : "N"}
		  , success:function(result) {
				$("#searchKeyword").val("");
				$("#CODE_CATEGORY_ID").val("");
			  
				fnSearch();
			}
		  , async:true
		};
		uxl.callFunction(url, option);
	}

	function deleteServiceCode(SERVICE_CODE_ID) {
		var svcId = $("#SERVICE_ID").val();
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
		var option = {
			data:{"SERVICE_ID" : svcId, "SERVICE_CODE_ID" : SERVICE_CODE_ID}
		  , success:function(result) {
				fnSearch();
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
	
	function fnCodeView(CODE_CATEGORY_ID, CODE_TYPE){
		var param = "?CODE_CATEGORY_ID="+CODE_CATEGORY_ID+"&CODE_TP="+CODE_TYPE;
		var url = uxl.getScreenURL('APM0035') + param;
		uxl.openWindow('codeViewPop', url, {width:600,height:415}, {});
	}
</script>