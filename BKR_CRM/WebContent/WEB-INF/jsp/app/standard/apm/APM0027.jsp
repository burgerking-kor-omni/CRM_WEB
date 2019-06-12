<%--
#*
 *  파 일 명 :  APM0027.jsp
 *  설    명 :  마스크관리 목록 
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
	DataList _dl_TP_MASK = ViewUtil.getResult().getDataList("Code.TP_MASK");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : APM0027R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">개인정보 관리</h1>
<div class="ub-layout button top"><span class="ub-control button top icon" id="btnRegister">
    <a href="#none" title="신규등록"><span class="ico-register"></span>신규등록</a>
</span>
</div>
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
<th id="layout-1_1_1"><label class="ub-control label">마스크명</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="NM_MASK" name="NM_MASK"                       style="text-align:left;width:300px;"></td>
<th id="layout-1_1_3"><label class="ub-control label">유형</label></th>
<td id="layout-1_1_4"><select id="TP_MASK" name="TP_MASK" class="ub-control select "     style="width:120px;" size="1" datacid="TP_MASK"><%    if(!"전체".equals("")){        out.println("<OPTION VALUE=\"\">전체</OPTION>\r\n");    }    if(_dl_TP_MASK != null){        for(int codeIdx=0; codeIdx < _dl_TP_MASK.getRowCount(); codeIdx++){            String code = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_CODE);            String name = _dl_TP_MASK.getString(codeIdx, ConstantHolder.CODE_COLUMN_NAME);            out.println("<option VALUE=\""+code+"\">"+name+"</option>\r\n");        }    }%></select></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_5"><label class="ub-control label">클래스명</label></th>
<td id="layout-1_2_6" colspan=3><input type=text  class="ub-control input-text " id="DS_CLASS" name="DS_CLASS"                       style="text-align:left;width:300px;"></td>
</tr>
</tbody>
</table>
 
<span class="ub-control button search" id="btnSearch">
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
		colNames:['마스크 ID', '마스크명', '마스크유형', '입력문자열', '출력문자열', '클래스명']

		//mapping column
	  , colModel:[
		    {name:'ID_MASK',    width:15, align:'center'}
		  , {name:'NM_MASK',       width:30, align:'center'}
		  , {name:'TP_MASK',       width:15, align:'center'}
		  , {name:'DS_INPUT',       width:25, align:'left'}
		  , {name:'DS_OUTPUT',       width:25, align:'left'}
		  , {name:'DS_CLASS',       width:40, align:'left'}
		]
	  , autowidth:true
	  , height:261
	  , multiselect:false
	  , onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			var param = "?ID_MASK=" + selectedRow.ID_MASK;
			uxl.moveLocation(uxl.getScreenURL('APM0028') + param);
		}
	};
	
	uxl.grid('list', options);
	
	fnSearch();
	
	$("#btnSearch").click(function(){
		fnSearch();
	});
	
	$("#btnRegister").click(function(){
		uxl.moveLocation(uxl.getScreenURL('APM0029'));
	});
	
	$('#NM_MASK, #DS_CLASS').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
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
	uxl.callSubmitFunction('searchForm', url, option);		
}

</script>