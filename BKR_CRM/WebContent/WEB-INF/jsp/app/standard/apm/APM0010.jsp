<%--
#*
 *  파 일 명 :  APM0010.jsp
 *  설    명 :  서비스 실행 에러로그 목록
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
 
   - PAGE ID : APM0010R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h2 class="ub-control title">에러로그</h2>
<div class="ub-layout button inner"  style="text-align:right;"><form id="searchForm" name="searchForm"><input type=hidden id="SERVICE_ID" name="SERVICE_ID"    value="${paramMap.SERVICE_ID}">
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
		colNames:[
			'실행일시'
		  , 'Requested By'
		  , 'Client IP'
		  , '소요시간'
		  , '실행결과'
		  , '예외'
		]

		//mapping column
	  , colModel:[
            {name:'RUN_DATETIME',     width:15, align:'center'}
	  	  , {name:'USER_NM',       width:10, align:'center'}
		  , {name:'CLIENT_IP_ADDR',   width:15, align:'center'}
		  , {name:'RUN_ELAPSE_TIME', width:10, align:'center'}
		  , {name:'RUN_RESULT_CODE',   width:15, align:'center'}
		  , {name:'ERROR_CLASS_NAME',      width:40, align:'left'}
		]
	  , autowidth:true
	  , height:261
	  , multiselect:false
	};
	
	uxl.grid('list', options);
	fnSearch();

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
	uxl.callSubmitFunction("searchForm", url, option);		
}

</script>