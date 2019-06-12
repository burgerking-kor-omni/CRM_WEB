<%--
#*
 *  파 일 명 :  CUS1006.jsp
 *  설    명 :  킹스템프 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.22
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
			colNames:['구매일','구매채널','이용 매장','구매상품','결제수단','쿠폰','구매액','킹스템프']

			//mapping column
			,colModel:[
			          {name:'DT_BUY',width:15,align:'center'}
			         ,{name:'CD_BUY_CHNN', width:15,align:'center', codeCategory : 'CD_BUY_CHANNEL'}
			         ,{name:'CD_STORE', width:20,align:'center'}
					 ,{name:'NM_PROD' ,width:40,align:'center'}
					 ,{name:'CD_BUY_WAY' ,width:15,align:'center', codeCategory : 'CD_PAYMENT'}
					 ,{name:'YN_COUPON',width:10,align:'center'}
					 ,{name:'VAL_BUY_PRICE',width:15,align:'center'}
					 ,{name:'YN_KING_STAMP',width:10,align:'center'}
			]
			, height:150
			, autowidth:true
			, onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
// 				uxl.moveLocation(uxl.getScreenURL('CUS0002') ); //+ '?ID_APPR='+selectedRow.ID_APPR + '&ID_ISSUE='+selectedRow.ID_BIZ_KEY);
			}
		};
// 		uxl.grid('list', options);

// 		fnSearch();	
		
		$('#searchBtn').click(function(){
			fnSearch();	
		});

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
			}
			, async:true
	};
// 	uxl.callSubmitFunction( 'searchForm' , url , option );		
}

</script>