<%--
#*
 *  파 일 명 :  SYS0051.jsp
 *  설    명 :  Screen 조회 팝업
 *  작 성 자 :  강영운
 *  작 성 일 :  2013-06-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
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
	DataList _dl_SCREEN_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_TYPE");
	DataList _dl_SCREEN_VIEW_TYPE = ViewUtil.getResult().getDataList("Code.APMD_SCREEN_VIEW_TYPE");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0051R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">Screen 검색</h1>
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
<th id="layout-1_1_1"><label class="ub-control label">Screen Id</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="SCREEN_ID" name="SCREEN_ID"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">Screen Type</label></th>
<td id="layout-1_1_4"><select id="SCREEN_TYPE" name="SCREEN_TYPE" class="ub-control select "     style="width:100px;" size="1" datacid="APMD_SCREEN_TYPE"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_SCREEN_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">Screen Name</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="SCREEN_NAME" name="SCREEN_NAME"                       style="text-align:left;width:100px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">View Type</label></th>
<td id="layout-1_2_8"><select id="SCREEN_VIEW_TYPE" name="SCREEN_VIEW_TYPE" class="ub-control select "     style="width:100px;" size="1" datacid="APMD_SCREEN_VIEW_TYPE"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_SCREEN_VIEW_TYPE != null){        for(int codeIdx=0; codeIdx < _dl_SCREEN_VIEW_TYPE.getRowCount(); codeIdx++){            String code = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_SCREEN_VIEW_TYPE.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
</tbody>
</table>
 
</form>
<span class="ub-control button search" id="btnSearch">
<a href="#none" title="Search">검색</a>
</span>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<div class="ub-layout button bottom">
	<span class="ub-control button bottom icon" id="btnSelect">
	    <a href="#none" title="선택"><span></span>선택</a>
	</span>
	<span class="ub-control button bottom icon" id="btnClose">
	    <a href="#none" title="닫기"><span></span>닫기</a>
	</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	var options = {
		//header name
		colNames:['Category', 'Screen Id', 'Screen Name', 'Screen Type', 'View Type', '등록일시']
		
		//mapping column
		, colModel:[
			{name:'CATEGORY_CODE' ,width:80},
			{name:'SCREEN_ID',width:80},
			{name:'SCREEN_NAME'},
			{name:'SCREEN_TYPE',width:80, align:'center', codeCategory:'APMD_SCREEN_TYPE'},
			{name:'VIEW_TYPE',width:80, align:'center', codeCategory:'APMD_SCREEN_VIEW_TYPE'},
			{name:'REG_DATETIME',width:120, align:'center', formatter:'date'}
		]
		, autowidth:true
		, multiselect: true
	};
	uxl.grid('list', options);
	
	//조회 이벤트
	$('#btnSearch').click(function(event){
		fnSearch();
	});
	
	$('#btnClose').click(function(event){
		uxl.close();
	});

	$('#btnSelect').click(function(event){
		fnSetReturnData();
	});
	
	//엔터키 검색 전체적용
	$('#searchForm').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
			return false;
		}
	});
});

//조회
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
					}
					
					return returnVal;
			}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

function fnSetReturnData(){
	var rowIds = $('#list').jqGrid('getGridParam','selarrrow');
	if(rowIds.length==0){
		alert("선택된 항목이 없습니다. 확인후 다시 실행하십시오.");
		return;
	}
	
	var selectData = [];
	for(var i=0; i<rowIds.length; i++){
		rowdata = $('#list').jqGrid('getRowData',rowIds[i]);
		var data = {
				SCREEN_ID			: rowdata.SCREEN_ID					// 화면ID
			,	SCREEN_NAME			: rowdata.SCREEN_NAME 				// 화면명
			,	SCREEN_TYPE			: rowdata.SCREEN_TYPE				// 화면유형
		};
		selectData.push(data);		
	}
	uxl.pushToParent(selectData);				
	self.close();
}

</script>
		 