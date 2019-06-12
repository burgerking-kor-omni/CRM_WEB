<%--
#*
 *  파 일 명 :  SYS0311.jsp
 *  설    명 :  게시판 선택 팝업
 *  작 성 자 :  유기태
 *  작 성 일 :  2015.06.19
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
 
   - PAGE ID : SYS0311R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">게시판 선택</h1>
<div class="ub-layout button top"></div>
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
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label">게시판ID</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="ID_BOARD" name="ID_BOARD"       value="${paramMap.ID_BOARD}"                style="text-align:left;width:100px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">게시판명</label></th>
<td id="layout-1_1_4"><input type=text  class="ub-control input-text " id="DS_TITLE" name="DS_TITLE"       value="${paramMap.DS_TITLE}"                style="text-align:left;width:100px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="searchBtn" title="검색">
<a href="#none" title="검색">검색</a>
</span>
</form>

</div>
<div class="ub-layout list"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;"><h3 style="padding-top:120px;">Grid Control</h3></div>
<table class="ub-control grid" id="list" name="list"></table> 
	
</div>
<div class="ub-layout pagging"><div class="ub-control temp" style="border:2px solid gray;width:100%;height:30px;text-align:center;"><h3 style="padding-top:3px;">Paging Navigation</h3></div>
<div class="ub-control pagging" for="list" formId="searchForm" function="fnSearch"></div>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="confirmBtn">
    <a href="#none" title="확인"><span class="ico-add"></span>확인</a>
</span>
</div>

<!-- layout-1 End -->


<script type="text/javascript">
uxl.onLoad(function(){	
	$('#confirmBtn').click(function() {
		var index = $("input[name='rdoBoard']").index($("input[name='rdoBoard']:checked"));
		var boardId = $("input[name='rdoBoard']:checked").val();
		var data = $('#list').jqGrid('getRowData', index);
		 
		if (uxl.isNull(boardId)) {
			alert(uxl.getMessage('@message.common.noselected'));
			return;
		} else {
			var type = '${paramMap.ID_BOARD_TYPE}';
			if(type != null && type != '' && type != data.ID_BOARD_TYPE){
				uxl.showMessage('같은 유형의 게시판만 선택할 수 있습니다.');
				return;
			}
			
			var returnData = {"ID_BOARD" : boardId, "DS_TITLE" : data.DS_TITLE};

			uxl.pushToParent(returnData);
			self.close();
		}
	});
	
	/*
	그리드 옵션
	colNames : 그리드 Header 정보,
	colModel : 그리드 Contents 의 바인딩 정보
	*/
	
	var options = {
		//header name
		colNames:['선택', '게시판ID', '게시판명', '게시판템플릿', '등록일', 'ID_BOARD_TYPE']
		//mapping column
	  , colModel:[
	  		{name:'radioButton', width:3,  align:'center', formatter:setRadioButton, sortable:false}
		  , {name:'ID_BOARD',   	width:10, align:'center'}
		  , {name:'DS_TITLE',       width:20, align:'left'}
		  , {name:'NM_BOARD_TYPE',  width:10, align:'center'}
		  , {name:'REG_DATETIME',   width:10, align:'center'}
		  , {name:'ID_BOARD_TYPE',  hidden:true}
		]
	  , autowidth:true
	  , multiselect:false
	  , sortname: 'REG_DATETIME'
	  , sortorder: 'DESC'
	  , onSelectRow: function(rowid){
		    $("input[name='rdoBoard']").removeAttr("checked");
			$("input[name='rdoBoard']")[rowid].checked = true;
		}
	};
	uxl.grid('list', options);

	//조회 이벤트
	$('#searchBtn').click(function() {
		uxl.grid.init('list');
		fnSearch();
	});	
});

function setRadioButton(cellValue, opts, rowObject) {
	return "<input type='radio' name='rdoBoard' value='" + rowObject.ID_BOARD + "'>";
}

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