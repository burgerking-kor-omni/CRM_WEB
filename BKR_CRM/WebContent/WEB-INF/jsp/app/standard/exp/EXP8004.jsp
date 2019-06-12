<%--
#*
 *  파 일 명 :  EXP8004.jsp
 *  설    명 :  
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
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

<h1 class="ub-control title">Multiple Pivot</h1>

<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col />
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
	<th id="layout-1_1_1"><label class="ub-control label">카테고리명</label></th>
	<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_CATEGORY" name="NM_CATEGORY"       value=""style="text-align:left;width:106px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="searchBtn">
	<a href="#none" title="Search">검색</a>
</span>

</div>
</form>

<h2 class="ub-control title">기본 그리드</h2>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 	
</div>

<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="page" name="page" class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<h2 class="ub-control title">Multiple Pivot</h2>

<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="multipleList" name="multipleList"></table> 
</div>

<script type="text/javascript">
uxl.onLoad(function(){	
	
	var options = {
		//header name
		colNames:['카테고리명', '제품명', '국가', '가격'] // , '수량'
		
		//mapping column
		, colModel:[
			    {name:'CATEGORYNAME',  	width:15, align:'left'}
			  , {name:'PRODUCTNAME',    width:15, align:'left'}
			  , {name:'COUNTRY',    	width:15, align:'center'}
			  , {name:'PRICE', 			width:15, align:'right'}
// 			  , {name:'QUANTITY',    	width:15, align:'right'}
		]
		, autowidth:true
		, sortname: ''
		, sortorder: ''
		, height:261
		, onSelectRow: function(rowid){
			
		}
	};
	uxl.grid('list', options);
	
	$('#searchBtn').click(function(event){
		fnSearch();
	}).click();
});

function fnSetPivotGrid(dataSet){
	var pivotOptions = {
		  xDimension: [{dataName: 'CATEGORYNAME', label: '카테고리명' , width:80}
      		          ,{dataName: 'PRODUCTNAME', label: '제품명', width: 50}]
		, yDimension: [{dataName: 'COUNTRY', label: '국가', width : 40}]
        , aggregates: [{
        	member: 'PRICE',
            aggregator: 'sum',
            width: 80,
            label: '가격',
            formatter: setComma,
            align: 'right',
//             summaryType: 'sum'
        },{
            formatter: setComma,
            label: "수량",
            width: 80,
            align: "right",
            aggregator: "sum",
//             summaryType: "sum",
            member: "QUANTITY"
        }]
	    , rowTotals: true
	    , colTotals: true
	    , groupSummaryPos: "footer"
    };	
	var gridOptions = {
		  autowidth:true
        , rowNum : 100
        , height : 261
//         , caption: "Multiple aggregates"
	};
	uxl.grid.pivot('multipleList', gridOptions, pivotOptions, dataSet);
}
function setComma(cellValue, opts, rowObject){
	return uxl.setComma(cellValue);
}
function fnSearch() {
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'INQUIRY');
	var option = {
		data:{}
	  , success:function(result) {
		  	uxl.grid.appendData('list' ,result , true );
			fnSearch2();
	    }
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}

function fnSearch2(){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{}
	  , success:function(result) {
		  fnSetPivotGrid(result.getDataList(0).rows);
	    }
	  , async:true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}

</script>