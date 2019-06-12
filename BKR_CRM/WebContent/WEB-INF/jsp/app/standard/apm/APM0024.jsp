<%--
#*
 *  파 일 명 :  APM0024.jsp
 *  설    명 :  서비스 마스킹 목록
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
 
   - PAGE ID : APM0024R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h2 class="ub-control title">데이터 변환</h2>
<div class="ub-layout button inner"  style="text-align:right;"><form id="searchForm" name="searchForm"><input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
<span class="ub-control button inner icon" id="btnAdd">
    <a href="#none" title="추가"><span></span>추가</a>
</span>
<span class="ub-control button inner icon" id="btnDelete">
    <a href="#none" title="삭제"><span></span>삭제</a>
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
			colNames:['SERVICE_MASK_ID', '적용위치', 'DataList 명', '컬럼명', '마스크 ID', '마스크명']

			//mapping column
		  , colModel:[
				{name:'SERVICE_MASK_ID',     width:15, hidden:true}
		  	  , {name:'POINTCUT_CD',     width:15, align:'center'}
			  , {name:'DATALIST_ID',          width:15, align:'center'}
			  , {name:'COLUMN_NAME',     width:15, align:'center'}
			  , {name:'MASK_ID',    width:10, align:'center'}
			  , {name:'MASK_NAME',      width:20, align:'left'}
			]
		  , autowidth:true
		  , height:261
		  , multiselect:true
	      , onSelectRow:function(rowid) {
				var svcId = $("#SERVICE_ID").val();
				var selectedRow = $(this).getRowData(rowid);
				var param = "?SERVICE_ID=" + svcId + "&SERVICE_MASK_ID=" + selectedRow.SERVICE_MASK_ID;
				
				//uxl.openWindow('Popup', uxl.getScreenURL('APM0025') + param, {width:550, height:245});
			}
		};
		
		uxl.grid('list', options);
		fnSearch();

		$('#btnAdd').click(function() {
			var svcId = $("#SERVICE_ID").val();
			var param = "?SERVICE_ID=" + svcId;
			uxl.openWindow('Popup', uxl.getScreenURL('APM0026') + param, {width:550, height:303});
		});
		
		$('#btnDelete').click(function(){
			var svcId = $("#SERVICE_ID").val();
			var checkedRows = $("#list").jqGrid('getGridParam','selarrrow');
			var checkedMaskIds = new Array();
			
			if (checkedRows.length == 0) {
				alert(uxl.getMessage('@message.common.noselected'));
				return;
			}
			
			$.each(checkedRows, function(index, item) {
				var data = $('#list').jqGrid('getRowData', item);
				checkedMaskIds.push(data.SERVICE_MASK_ID);
			});
			
			fnDeleteMask(svcId, checkedMaskIds);
		});
	});

	//조회
	function fnSearch() {
		//필수정보 체크
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
		var option = {
			data:{}
			
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

	function fnDeleteMask(svcId, checkedMaskIds) {
		var url = uxl.getFunctionUrl(_SCREEN_ID, 'REMOVE');
		var option = {
			data:{"SERVICE_ID" : svcId, "SERVICE_MASK_IDS" : checkedMaskIds}
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
</script>