<%--
#*
 *  파 일 명 :  SYS0301.jsp
 *  설    명 :  게시판 관리 목록
 *  작 성 자 :  유기태
 *  작 성 일 :  2015-05-11
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
// 	DataList _dl_FLAG_YN = ViewUtil.getResult().getDataList("Code.FLAG_YN");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0301R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 관리 목록</h1>
<div class="ub-layout button top">
	<span class="ub-control button top icon" id="boardCloneBtn">
	    <a href="#none" title="Clone">게시판 복제</a>
	</span>
	<span class="ub-control button top icon" id="registBtn">
	    <a href="#none" title="Register"><span class="ico-register"></span>신규등록</a>
	</span>
</div>
<form id="searchForm" name="searchForm"><div class="ub-layout search">
    <span class="search-ltbg"></span>
    <span class="search-rtbg"></span>
    <span class="search-lbbg"></span>
    <span class="search-rbbg"></span>
<table class="ub-control table normal ">
<colgroup>
<col width="125px"/>
<col />
</colgroup>
<tbody>
	<tr id="layout-1_1">
		<th id="layout-1_1_1"><label class="ub-control label">게시판ID</label></th>
		<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ID_BOARD" name="ID_BOARD" value="${paramMap.ID_BOARD}" style="text-align:left;width:100px;"></td>
	</tr>
	<tr id="layout-1_2">
		<th id="layout-1_2_3"><label class="ub-control label">게시판타이틀</label></th>
		<td id="layout-1_2_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE" value="${paramMap.DS_TITLE}" style="text-align:left;width:400px;"></td>
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
		colNames:['선택', '게시판 ID', '게시판템플릿', '타이틀','사용여부', '바로가기', '등록자ID', '등록자', '등록일']
		
		//mapping column
		, colModel:[
		        {name:'RADIO_BTN',      width:5, align:'center', formatter:setRadioBtn}
			  , {name:'ID_BOARD',       width:18, align:'center'}
			  , {name:'ID_BOARD_TYPE',  width:20, align:'center'}
			  , {name:'DS_TITLE',       width:80, align:'left'}
			  , {name:'FG_USE',         width:10, align:'center'}
			  , {name:'LINK_BTN', 		width:15, align:'center', formatter:setLinkBoardBtn, sortable:false}
			  , {name:'REG_USER_ID',    hidden:true}
			  , {name:'REG_USER_NM',    width:15, align:'center'}
			  , {name:'REG_DATETIME',  	width:15, align:'center'}
		]
		, autowidth:true
		, sortname: 'ID_BOARD'
		, sortorder: 'ASC'
		, height: 261
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			var param = "?ID_BOARD=" + selectedRow.ID_BOARD;
			uxl.moveLocation(uxl.getScreenURL('UBS0004') + param);
		}
	};
	uxl.grid('list', options);
	
	// 등록버튼 클릭 이벤트 바인딩
	$('#registBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('UBS0003'));
	});
	
	// 검색버튼 클릭 이벤트 바인딩
	$('#searchBtn').click(function(){
		uxl.grid.init('list');
		fnSearch();
	}).click();
	
	// 복제버튼 클릭 이벤트 바인딩
	$('#boardCloneBtn').click(function(){
		var index = $("input[name='rdoBoard']").index($("input[name='rdoBoard']:checked"));
		var boardId = $("input[name='rdoBoard']:checked").val();
		var data = $('#list').jqGrid('getRowData', index);
		 
		if (uxl.isNull(boardId)) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		} else {
			//복제창호출	
			uxl.openWindow('cloneBoardPop', uxl.getScreenURL('UBS0002') + "?boardId=" + boardId, {width:420, height:190}, callbackClone);
		}
	});

});

//검색
function fnSearch(){		
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')	
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}
//라디오버튼 포맷
function setRadioBtn(cellValue, opts, rowObject) {
	return "<input type='radio' name='rdoBoard' value='" + rowObject.ID_BOARD + "'>";
}

//게시판 바로가기 버튼 포맷
function setLinkBoardBtn(cellValue, opts, rowObject) {
	var html = "<span class='ub-control button inner icon' name='linkBoardBtn'>";
	html += "<a href='javascript:fnMoveBoard(\"" + rowObject.ID_BOARD + "\", \""+rowObject.ID_BOARD_TYPE+"\");' title='Link'>";
	html += "바로가기</a></span>";
	
	return html;
}

//게시판 바로가기
function fnMoveBoard(boardId, boardTypeId){
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'USERDEFINED1');
	var option = {
		data:{ID_BOARD_TYPE:boardTypeId}
	  , success:function(result) {
		  var dataSet = result.getDataList("urlInfo").rows[0];
		  
		  uxl.openWindow('boardPop', uxl.getScreenURL(dataSet.LIST_SCREEN_ID) + "?ID_BOARD=" + boardId, {width:1250, height:650, scrollbars:'yes'});
		}
	  , async:true
	};
	uxl.callFunction(url, option);
}

function callbackClone(){
	fnSearch();
}

</script>