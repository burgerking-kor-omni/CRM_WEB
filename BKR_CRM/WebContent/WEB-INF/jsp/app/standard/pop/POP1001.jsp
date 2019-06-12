<%--
#*
 *  파 일 명 :  POP1001.jsp
 *  설    명 :  주문 상세 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.26
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
 
   - PAGE ID : POP1001R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<%
	DataList _dl_detail = ViewUtil.getResult().getDataList("CustManageDAO.getOrderDetail");
	int rowCnt = _dl_detail.getRowCount();
%>

<script type="text/javascript">
uxl.onLoad(function(){
	
	if('${paramMap.FLAG}'==''){
		$('#saveBtn').hide();
	}
	
	// 구성품 목록
	var	options = {
		//header name
		colNames:['쿠폰명','대상','쿠폰대상','대상회원','할인정책','할인금액']

		//mapping column
		,colModel:[
		          {name:'NM_COUPON',width:30,align:'center'}
		         ,{name:'CD_COUPON_OBJ',width:10,align:'center', codeCategory:'CD_COUPON_OBJ'}
				 ,{name:'TP_MEMBER',width:10,align:'center', codeCategory:'TP_MEMBER'}
				 ,{name:'CD_COUPON_TARGET',width:10,align:'center', codeCategory:'CD_COUPON_TARGET'}
				 ,{name:'CD_SALE_POLICY',width:15,align:'center', codeCategory:'CD_SALE_POLICY'}
				 ,{name:'VAL_SALE_POLICY',width:20,align:'center',formatter:setComma}
		]
		, height:100
		, autowidth:true
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
		}
	};
	uxl.grid('list_coupon', options);
		
	// 상품 목록
	options = {
		//header name
		colNames:['상품명','상품가격','상품수량','구성품']

		//mapping column
		,colModel:[
		          {name:'MENU_NM',width:30,align:'center',sortable:false}
		         ,{name:'MENU_PRC',width:15,align:'center',formatter:setComma,sortable:false}
				 ,{name:'MENU_QTY',width:10,align:'center',sortable:false}
				 ,{name:'OPTION_NAME',width:40,align:'center',sortable:false}
		]
		, height:150
		, autowidth:true
		, onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
// 	 		uxl.moveLocation(uxl.getScreenURL('CUS0002') ); //+ '?ID_APPR='+selectedRow.ID_APPR + '&ID_ISSUE='+selectedRow.ID_BIZ_KEY);
		}
	};
	uxl.grid('list_prod', options);
	
	// 코드 바인딩
	uxl.bindComboCode('PAYMENT_TYPE','PAYMENT_TYPE',{emptyOption : false});
	uxl.bindComboCode('ORDER_STATUS','ORDER_STATUS',{emptyOption : false});

	fnSearch_prod();
	fnSearch_coupon();
	
});

uxl.onLoadComplete(function(){
	if('<%=rowCnt%>' < 1){
		alert('조회된 주문이 없습니다.');
		self.close();
	}
	
	$('#TOTAL_PRC').val($('#TOTAL_PRC').val()+' 원');
	$('#PAYMENT_PRC').val($('#PAYMENT_PRC').val()+' 원');
});

// 상품목록 조회
function fnSearch_prod(){
	
	var data = {};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list_prod'))
			, success:function(result){
				uxl.grid.appendData('list_prod' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}


// 상품목록 조회
function fnSearch_coupon(){
	
	var data = {};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list_coupon'))
			, success:function(result){
				uxl.grid.appendData('list_coupon' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}

function setComma(cellValue, opts, rowObject){
	return uxl.setComma(cellValue) + " 원";
}

// 주문내용 선택
function fnSave(){
	var data = {
		ORDER_NO : $('#ORDER_NO').val()
	}
	uxl.pushToParent(data);
	self.close();
}

</script>