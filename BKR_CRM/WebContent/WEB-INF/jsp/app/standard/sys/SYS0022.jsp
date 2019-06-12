
<%--
#*
 *  파 일 명 :  SYS0022.jsp
 *  설    명 :  담당업무 목록 
 *  작 성 자 :  안진철
 *  작 성 일 :  2013-05-13
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
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0022R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<!-- layout-1 Start -->
<h1 class="ub-control title">권한관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="register">
    <a href="#none" title="Register"><span class="ico-register"></span>신규등록</a>
</span>
</div>
<div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<form id="searchForm" name="searchForm"><table class="ub-control table normal ">
<colgroup>
<col width="15%"/>
<col width="35%"/>
<col width="15%"/>
<col width="35%"/>
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">권한코드</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ROLE_ID" name="ROLE_ID"       value="${paramMap.ROLE_ID}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">권한명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="ROLE_NAME" name="ROLE_NAME"       value="${paramMap.ROLE_NAME}"                style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="search">
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
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
		var options = {
			
		//header name
		colNames:['권한코드','권한명','설명','상태','관리자여부','코드매핑여부']

		//mapping column
		,colModel:[
			 	  {name:'ROLE_ID' ,width:30, align:'center'}
				 ,{name:'ROLE_NAME',width:60}
				 ,{name:'DESCRIPTION',width:100, classes:'ellipsis'}
				 ,{name:'STATUS',width:30, codeCategory:'STATUS', align:'center'}
				 ,{name:'ADMIN_YN',width:30, align:'center', codeCategory:'FLAG_YN'}
				 ,{name:'EXCEPT_MAP_YN',width:30, align:'center', codeCategory:'FLAG_YN'}
			]
		,autowidth:true
		,height:231
		,rowNum:10
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('SYS0023') + '?ROLE_ID='+selectedRow.ROLE_ID);
		}
	};
	uxl.grid('list', options);

	//조회 이벤트
	$('#search').click(function(event){
	   uxl.grid.init('list');
	   fnSearch();
	});	
	
	 //목록화면으로 이동
	$('#listb').click(function(){
		uxl.moveLocation('SYS0022');
	});
	
	//신규등록 이벤트
	$('#register').click(function(event){
	   uxl.moveLocation(uxl.getScreenURL('SYS0024'));
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
			
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				//opener.uxl.reload();
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}
</script>
