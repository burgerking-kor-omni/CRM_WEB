<%--
#*
 *  파 일 명 : CUP0013.jsp
 *  설    명 : 리워드 쿠폰 현황 
 *  작 성 자 : 강현준
 *  작 성 일 : 2018.11.16
 *  버    전 : 1.0
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
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ page import="com.ubone.standard.common.encrypto.IwtCrypt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUP0013R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	
	
	var options = {
			//header name
			colNames:['쿠폰명','유효기간','발급 쿠폰 수','발급 회원 수'
			          ,'쿠폰 수','회원 수','쿠폰 수','회원 수']
	
			//mapping column
			,colModel:[
					  {name:'NM_COUPON'	,width:20 ,align:'center'}
					 ,{name:'DT_EXPIRY'	,width:15,align:'center'}
					 ,{name:'ALL_CUP'	,width:10,align:'center' ,formatter:fnSetComma}
					 ,{name:'ALL_MEM'	,width:10,align:'center' ,formatter:fnSetComma}

					 ,{name:'CNT_A'		,width:10 ,align:'center' ,formatter:fnSetComma}
			         ,{name:'CNT_A_M'	,width:10 ,align:'center' ,formatter:fnSetComma}
			         ,{name:'CNT_N'		,width:10 ,align:'center' ,formatter:fnSetComma}
			         ,{name:'CNT_N_M'	,width:10 ,align:'center' ,formatter:fnSetComma}
			]
			, height:360
			,autowidth:true
		};
		uxl.grid('list', options);
		
		$("#list").jqGrid('setGroupHeaders', {
			useColSpanStyle: true,
			  groupHeaders:[
				{ startColumnName: 'ALL_CUP', numberOfColumns: 2, titleText: '전체' }
				,{ startColumnName: 'CNT_A', numberOfColumns: 2, titleText: '사용' }
				,{ startColumnName: 'CNT_N', numberOfColumns: 2, titleText: '미 사용' }
			  ]
	    });

// 		fnSearch();	
		
	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
});

// 목록 조회
function fnSearch(){
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_START').val());
	var dtEnd = new Date($('#DT_END').val());
	
	if(dtStart > dtEnd ){
		alert('가입일의 검색일자가 유효하지 않습니다.');
		return;
	};

	// 목록 초기화
	uxl.grid.init('list');

	var data = {};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}

// 콤마 붙이기
function fnSetComma(cellValue, options, rowdata, action){
	return uxl.setComma(cellValue);
}
</script>