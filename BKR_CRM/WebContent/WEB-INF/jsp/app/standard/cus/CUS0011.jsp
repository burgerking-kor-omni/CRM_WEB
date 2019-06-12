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

<script type="text/javascript">

uxl.onLoad(function(){
	
	var options = {
			//header name
			colNames:['변경항목','변경전','변경후','변경일시','변경자','이력ID']

			//mapping column
			,colModel:[
			          {name:'CD_CHNG_ITEM', width:15, align:'center', codeCategory:'CD_CHNG_ITEM'}
			         ,{name:'VAL_ITEM_BR', width:15, align:'center'}
			         ,{name:'VAL_ITEM_AF', width:15, align:'center'}
			         ,{name:'DT_REG', width:20, align:'center'}
			         ,{name:'NM_REG_USER', width:20, align:'center'}
			         ,{name:'NO_ITEM_RECD', width:20, align:'center',hidden:true}
			]
			, height:290
			,autowidth:true
			,onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				
				var url = uxl.addQueryToUrl(uxl.getScreenURL('POP1000'), 'ID_MEMBER', parent.$('#ID_MEMBER').val());
				url = uxl.addQueryToUrl(url, 'FLAG_CODE', selectedRow.CD_STORE);
// 				uxl.openWindow('POP1000',  url + '&FLAG=STORE', {width:800, height:500});
			}
		};
		uxl.grid('list', options);
		

		fnSearch();	
		
});

function fnSearch(){
	
	$("#list").clearGridData();
	
	var data = {
			flag : 'CHANGE',
			ID_MEMBER : parent.$('#ID_MEMBER').val()
		};
	//필수정보 체크
	var url = uxl.getFunctionUrl('CUS0011','INQUIRY');
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
</script>