<%--
#*
 *  파 일 명 :  EXP8009.jsp
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

<h1 class="ub-control title">FooterSum Grid Test</h1>

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
	<th id="layout-1_1_1"><label class="ub-control label">^-^</label></th>
	<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="" name=""       value=""style="text-align:left;width:106px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="">
	<a href="#none" title="Search">검색</a>
</span>

</div>
</form>
<div class="ub-layout button inner"  style="text-align:right;"><span class="ub-control button bottom icon" id="addBtn">
    <a href="#none" title="Save"><span class="ico-save"></span>추가</a>
</span>
<span class="ub-control button bottom icon" id="delBtn">
    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
</span>
</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
</div>

<script type="text/javascript">
uxl.onLoad(function(){	
	
	var options = {
		  colNames:['테스트', '데이터', 'COUNT', '가격']		
		, colModel:[
			    {name:'TEST',  			width:15, align:'left'}
			  , {name:'DATA',    		width:15, align:'left'}
			  , {name:'COUNT',          width:15, align:'center', formatter:'number', formatoptions:{decimalPlaces:0}}
			  , {name:'PRICE', 			width:15, align:'right', formatter:'number', formatoptions:{decimalPlaces:0}}
		]
		, autowidth:true
		, sortname: ''
		, sortorder: ''
		, height:261
		, footerrow:true
		, ubPlugins :{
			footerSum :{
				  sumTitle : {index:1, title:'합계 : '}
				, sumColumns :['COUNT','PRICE']
			}
		}
	};
	uxl.grid('list', options);
	
	$("#list").jqGrid('addRowData',1,{TEST:'A', DATA:'AAAA', COUNT:'한글은', PRICE:'1000'});
	$("#list").jqGrid('addRowData',2,{TEST:'B', DATA:'BBBB', COUNT:'2', PRICE:'500'});
	$("#list").jqGrid('addRowData',3,{TEST:'C', DATA:'CCCC', COUNT:'8000', PRICE:'2000'});
	$("#list").jqGrid('addRowData',4,{TEST:'D', DATA:'DDDD', COUNT:'1,000', PRICE:'2000'});
	
	
	$('#addBtn').click(function(event){
		var rowCnt = $("#list").getGridParam("records")+1;
		$("#list").jqGrid('addRowData',rowCnt,{TEST:'C', DATA:'CCCC', COUNT:'8', PRICE:'2000'});
	});
	
	$('#delBtn').click(function(event){
		var rowCnt = $('#list').getGridParam("records");
		$('#list').jqGrid('delRowData', rowCnt);
	});
});


</script>