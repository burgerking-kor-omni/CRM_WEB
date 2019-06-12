<%--
#*
 *  파 일 명 :  CUS0018.jsp
 *  설    명 :  쿠폰 사용이력 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.27
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
 
   - PAGE ID : CUS1003R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['쿠폰명','대상','쿠폰대상'
			          
			          ,'실제 판매금액','할인 판매금액','할인율'
			          
			          ,'쿠폰유효기간','쿠폰핀PK']
			//mapping column
			,colModel:[
			          {name:'NM_COUPON',width:40,align:'center'}
			         ,{name:'CD_COUPON_OBJ',width:10,align:'center',codeCategory:'CD_COUPON_OBJ'}
					 ,{name:'CD_COUPON_TARGET' ,width:10,align:'center',codeCategory:'CD_COUPON_TARGET'}

					 ,{name:'REAL_CUP_PRICE',width:10,align:'center',formatter:'integer'}
					 ,{name:'SALE_CUP_PRICE',width:10,align:'center',formatter:'integer'}
					 ,{name:'SALE_CUP_RATE',width:10,align:'center'}
					 
					 ,{name:'DT_EXPIRY',width:20,align:'center'}
					 ,{name:'NO_PIN', hidden:true}
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
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
				$('.select-pagging').hide();
			}
			, async:true
	};
	uxl.callSubmitFunction( 'listForm', url , option );
}

</script>