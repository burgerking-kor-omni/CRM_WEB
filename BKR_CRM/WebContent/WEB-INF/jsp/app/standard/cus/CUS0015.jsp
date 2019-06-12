<%--
#*
 *  파 일 명 :  CUS0015.jsp
 *  설    명 :  주문매장 이력 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.20
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
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUS1002R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['매장코드','매장명','구입횟수','금액']

			//mapping column
			,colModel:[
			          {name:'STOR_CD',width:15,align:'center'}
			         ,{name:'STOR_NM',width:15,align:'center'}
			         ,{name:'SALE_CNT', width:20,align:'center' }
			         ,{name:'SALE_AMT', width:20,align:'center' ,formatter:setComma}
			]
			, height:290
			,autowidth:true
			,onSelectRow: function(rowid){
				var selRow = $('#list').jqGrid('getRowData', rowid);
				uxl.openWindow('POP1002',  uxl.getScreenURL('POP1002')+"?STOR_CD="+selRow.STOR_CD+"&ID_MEMBER="+parent.$('#ID_MEMBER').val(), {width:1200, height:550});
			}
		};
		uxl.grid('list', options);
		

		fnSearch();	
		
});

function fnSearch(){
	
	$("#list").clearGridData();
	
	var data = {
			ID_MEMBER : parent.$('#ID_MEMBER').val()
		};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data: $.extend(data, uxl.grid.getParam('list'))
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				$('.select-pagging').hide();
			}
			, async:true
	};
	uxl.callSubmitFunction( 'listForm', url , option );		
}

function setComma(cellValue, opts, rowObject){
	return uxl.setComma(cellValue) + " 원";
}

</script>