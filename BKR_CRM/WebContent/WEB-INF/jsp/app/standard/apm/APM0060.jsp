<%--
#*
 *  파 일 명 :  APM0060.jsp
 *  설    명 :  코드 유형 목록 (다국어용)
 *  작 성 자 :  김병기
 *  작 성 일 :  2016-09-30
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2016 by ㈜ 유비원. All right reserved.
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
	DataList _dl_CODE_TP = ViewUtil.getResult().getDataList("Code.CODE_TP");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver5.0 
 
   - PAGE ID : APM0060R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<!-- layout-1 Start -->
<h1 class="ub-control title">코드 유형 목록</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="insertBtn">
    <a href="#none" title="신규등록"><span class="ico-register"></span>신규등록</a>
</span>
</div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">코드유형ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_ID" name="CODE_CATEGORY_ID"       value="${paramMap.CODE_CATEGORY_ID}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">코드유형명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="CODE_CATEGORY_NM" name="CODE_CATEGORY_NM"       value="${paramMap.CODE_CATEGORY_NM}"                style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">코드명</label></th>
<td id="layout-1_2_6"><input type=text  class="ub-control input-text " id="CODE_NAME" name="CODE_NAME"       value="${paramMap.CODE_NAME}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_2_7"><label class="ub-control label">코드유형</label></th>
<td id="layout-1_2_8"><ub:code-select id="CODE_TP" codeCategory="CODE_TP" style="width:120px;" blankType="1" defaultValue="${paramMap.CODE_TP}"/></td>
</tr>
</tbody>
</table>
 
<div class="ub-layout button top"></div>
<span class="ub-control button search" id="search">
<a href="#none" title="Search">검색</a>
</span>

</div>
</form>
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
		colNames:['코드유형ID','코드유형명','코드유형','상수등록여부','캐쉬여부','상태','상위코드','MAPPING여부','등록자','등록일시'] 
		
		//mapping column
		,colModel:[
		          {name:'CODE_CATEGORY_ID' ,width:100},
		          {name:'CODE_CATEGORY_NM',width:100},
		          {name:'CODE_TP',width:50 , codeCategory:'CODE_TP',align:'center'},
		          {name:'CONSTANT_REG_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'CACHE_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'STATUS',width:50, codeCategory:'STATUS' ,align:'center'},
		          {name:'CODE_CATEGORY_ID_UP',width:70},
		          {name:'MAPPING_YN',width:50 , codeCategory:'FLAG_YN' ,align:'center'},
		          {name:'USER_NM',width:50 ,align:'center'},
		          {name:'REG_DT',width:120 ,align:'center'}
		         ]
        ,autowidth:true
        /*
        ,loadComplete:function(){
	       	if(records = $(this).jqGrid('getGridParam','records') < 1){
        		fnSearch();
	       	}
        }*/
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('APM0062') + '?CODE_CATEGORY_ID='+selectedRow.CODE_CATEGORY_ID);
		}
		,rowNum: 10
        ,height: 261
	};
	uxl.grid('list', options);
	
	//조회 이벤트
	$('#search').click(function(){
		uxl.grid.init('list');
		fnSearch();
	});
	
	//신규 등록
	$('#insertBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('APM0061'));
	});
	
	$(':text').keydown(function(event) {
		if(event.keyCode == '13') {
			$(this).val($(this).val().toUpperCase());
			$('#search').click();
		}
	});
	
	$('#CODE_TP').change(function(){
		$('#search').click();
	});
	
	fnSearch();
	
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
				  data:{}
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
					var dataSet = result.getDataList(0).rows;
					var rowCount = result.getDataList(0).rowCount;
					uxl.grid.appendData('list' ,result , true );
				}
				, async:true
		};
		uxl.callSubmitFunction('searchForm' , url , option );		
	}
</script>