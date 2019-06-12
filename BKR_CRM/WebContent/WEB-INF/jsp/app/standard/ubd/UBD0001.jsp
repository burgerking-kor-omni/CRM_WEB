<%--
#*
 *  파 일 명 :  UBD0001.jsp
 *  설    명 :  게시물 조회로그 이력 조회 
 *  작 성 자 :  유기태
 *  작 성 일 :  
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

<!-- layout-1 Start -->
<h1 class="ub-control title">게시물 조회 로그 이력</h1>
<div class="ub-layout button top">

</div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col width="100px"/>
<col />
</colgroup>
<tbody>
	<tr>
		<th><label class="ub-control label">사용자명</label></th>
		<td><input type=text  class="ub-control input-text " id="USER_NM" name="USER_NM" value="" style="text-align:left;width:100px;"></td>
	</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="searchBtn">
	<a href="#none" title="Search">검색</a>
</span>

</div>
</form>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div id="page" name="page" class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){
	
	var options = {
		//header name
		colNames:['게시판 ID', '게시물 ID', '조회이력 ID', '조회일시', '사용자 ID', '사용자명', '부서명']
		
		//mapping column
		, colModel:[
		        {name:'ID_BOARD',      	hidden:true}
			  , {name:'ID_ARTICLE',     hidden:true}
			  , {name:'ID_HISTORY',  	hidden:true}
			  , {name:'DT_INQUIRY', 	width:20, align:'center'}
			  , {name:'ID_USER',       	width:20, align:'center'}
			  , {name:'NM_USER',       	width:20, align:'center'}
			  , {name:'NM_DEPT',		width:20, align:'center'}		
		]
		, autowidth:true
		, sortname: 'DT_INQUIRY'
		, sortorder: 'DESC'
		, height: 261
	};
	uxl.grid('list', options);

	// 검색버튼 클릭 이벤트 바인딩
	$('#searchBtn').click(function(){
		uxl.grid.init('list');
		fnSearch();
	}).click();

});

//검색
function fnSearch(){		
	var boardId = opener.$('#ID_BOARD').val();
	var articleId = opener.$('#ID_ARTICLE').val();
	var subId = opener.$('#ID_SUB').val();
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{ID_BOARD:boardId, ID_ARTICLE:articleId, ID_SUB:subId}
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}

</script>