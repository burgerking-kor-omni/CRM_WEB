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
 
   - PAGE ID : CUS0013R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:[
			          '주문번호','상품명','금액'
			          ,'결제구분','주문일시','매장'
			          ,'STOR_CD','POS_NO','SALE_DT'
			         ]

			//mapping column
			,colModel:[
			          {name:'ORDER_NO',width:15,align:'center'}
			         ,{name:'MENU_NM', width:20,align:'center' }
			         ,{name:'TOTAL_PRC', width:10,align:'center',formatter:setComma}
			         
// 			         ,{name:'PAYMENT_TYPE', width:15,align:'center',codeCategory:'CD_PAY_WAY' }
			         ,{name:'PAYMENT_TYPE', width:15,align:'center',codeCategory:'PAYMENT_TYPE' }
			         ,{name:'REG_DATE', width:10,align:'center'}
			         ,{name:'STOR_NM', width:10,align:'center'}
			         
			         ,{name:'STOR_CD', hidden:true}
			         ,{name:'POS_NO', hidden:true}
			         ,{name:'SALE_DT', hidden:true}
			]
			, height:290
			,autowidth:true
			,onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				
				var url = uxl.addQueryToUrl(uxl.getScreenURL('POP1001'), 'ID_MEMBER', parent.$('#ID_MEMBER').val());
				url = uxl.addQueryToUrl(url, 'ORDER_NO', selectedRow.ORDER_NO);
				uxl.openWindow('POP1001',  url , {width:1000, height:760});
				
// 				var url = uxl.addQueryToUrl(uxl.getScreenURL('POP1011'), 'ORDER_NO', selectedRow.ORDER_NO);
// 				url = uxl.addQueryToUrl(url, 'ID_MEMBER', parent.$('#ID_MEMBER').val());
// 				url = uxl.addQueryToUrl(url, 'STOR_CD', selectedRow.STOR_CD);
// 				url = uxl.addQueryToUrl(url, 'POS_NO', selectedRow.POS_NO);
// 				url = uxl.addQueryToUrl(url, 'SALE_DT', selectedRow.SALE_DT);
// 				uxl.openWindow('POP1011',  url , {width:1000, height:760});
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