<%--
#*
 *  파 일 명 :  POP1000.jsp
 *  설    명 :  구매이력 목록 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.21
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
 
   - PAGE ID : CUS1000R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['주문번호','주문일','구매채널','이용 매장','구매상품','결제수단','상태','쿠폰','구매액','킹스템프']

			//mapping column
			,colModel:[
			          {name:'NO_ORDER',width:15,align:'center'}
			         ,{name:'DT_BUY',width:15,align:'center'}
			         ,{name:'CD_BUY_CHNN', width:15,align:'center', codeCategory : 'CD_BUY_CHANNEL'}
			         ,{name:'CD_STORE', width:20,align:'center'}
					 ,{name:'NM_PROD' ,width:40,align:'center'}
					 ,{name:'CD_BUY_WAY' ,width:15,align:'center', codeCategory : 'CD_PAYMENT'}
					 ,{name:'CD_STATUS',width:15,align:'center'}
					 ,{name:'YN_COUPON',width:10,align:'center'}
					 ,{name:'VAL_BUY_PRICE',width:15,align:'center', formatter : fnComma}
					 ,{name:'YN_KING_STAMP',width:10,align:'center'}
			]
			, height:150
			, autowidth:true
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
// 				uxl.moveLocation(uxl.getScreenURL('CUS0002') ); //+ '?ID_APPR='+selectedRow.ID_APPR + '&ID_ISSUE='+selectedRow.ID_BIZ_KEY);
			}
		};
		uxl.grid('list', options);

	fnSearch();	
	
	$('#searchBtn').click(function(){
		if($('#DT_BUY_START').val() != '' && $('#DT_BUY_END').val() != ''){
			if( DateUtil.getDayInterval($('#DT_BUY_START').val(), $('#DT_BUY_END').val()) < 0 ){
				var tempDate = "";
				tempDate = $('#DT_BUY_START').val();
				$('#DT_BUY_START').val($('#DT_BUY_END').val());
				$('#DT_BUY_END').val(tempDate);
			};				
		}
		
		fnSearch();	
	});
	
	$('input').dblclick(function (){
		$(this).val("");
	});

});

function fnSearch(){
	
	var data = {};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl('CUS1000','INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
// 	uxl.callSubmitFunction('searchForm' , url , option );

	$("#list").jqGrid("addRowData", 1, {
		NO_ORDER : '6570061',
		DT_BUY : '2018-08-17',
		CD_BUY_CHNN : '매장방문',
		CD_STORE : '종로점',
		NM_PROD : '와일드 갈릭 세트(1), 와퍼 세트(2)',
		CD_BUY_WAY : '신용카드',
		CD_STATUS : '매장결재',
		YN_COUPON : 'N',
		VAL_BUY_PRICE : '19,300',
		YN_KING_STAMP : 'Y'
	});
}

function fnComma(cellvalue, options, rowdata, action){
	return uxl.setComma(cellvalue);
}
</script>