<%--
#*
 *  파 일 명 :  CUS0019.jsp
 *  설    명 :  킹스템프 이력 목록
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
 
   - PAGE ID : CUS0019R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['구분','증/차감일자','증/차감사유','구입상품','스탬프갯수','누적스탬프갯수','가용스탬프갯수']
	  
			//mapping column
			,colModel:[
			          {name:'CD_INCREMENT', width:10,align:'center', codeCategory:'CD_INCREMENT'}
			         ,{name:'DT_REG', width:15,align:'center'}
			         ,{name:'NM_INCREMENT', width:15,align:'center'}
			         ,{name:'MENU_NM', width:30,align:'center'}
			         ,{name:'CNT_STAMP_INCRE', width:10,align:'center'}
			         ,{name:'CNT_STAMP_STACK', width:10,align:'center'}
			         ,{name:'CNT_AVAIL', width:10,align:'center'}
			]
			, height:290
			,autowidth:true
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
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				$('.select-pagging').hide();
			}
			, async:true
	};
	uxl.callSubmitFunction( 'listForm', url , option );
}

function fnSetComma(cellValue,rowObject,options){
	return uxl.setComma(cellValue) + " 원";
}
</script>