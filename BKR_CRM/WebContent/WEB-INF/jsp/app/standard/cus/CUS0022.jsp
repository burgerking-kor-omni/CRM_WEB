<%--
#*
 *  파 일 명 :  CUS0022.jsp
 *  설    명 :  킹머니이력 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.10.17
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
 
   - PAGE ID : CUS0022R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	uxl.bindComboCode('CD_CARD', 'CD_CARD', {parameter:{ID_MEMBER : parent.$('#ID_MEMBER').val()},emptyOption:'선택안됨'});
	
	var options = {
			//header name
			colNames:['카드번호', '구분', '금액'
			          , '일시', '총금액']

			//mapping column
			,colModel:[
			          {name:'NO_CARD',width:20,align:'center'}
			         ,{name:'CD_INCREMENT',width:15,align:'center', codeCategory:'CD_INCREMENT'}
					 ,{name:'VAL_AMOUNT_INCRE',width:30,align:'center', formatter:fnSetcoma}
					 
					 ,{name:'DT_REG',width:20,align:'center'}
					 ,{name:'VAL_AMOUNT_LAST',width:30,align:'center', formatter:fnSetcoma, hidden:true}
			]
			, height:150
			,autowidth:true
		};
		uxl.grid('list', options);
		
// 		fnSearch();	
		
});

function fnSearch(){
	
	$("#list").clearGridData();
	
	var data = {
			ID_MEMBER : parent.$('#ID_MEMBER').val(),
			NO_MEMBER : parent.$('#NO_MEMBER').val()
		};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
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
	uxl.callFunction( url , option );
}

// 금액 쉼표 및 단위 붙이기
function fnSetcoma(cellValue,rowObject,options){
	return uxl.setComma(cellValue) + " 원";
}

</script>