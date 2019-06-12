<%--
#*
 *  파 일 명 :  POP3001.jsp
 *  설    명 :  쿠폰 등록 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-10-25
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : POP2002R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 




<script type="text/javascript">
var flag = '${paramMap.SUB}';
uxl.onLoad(function(){
	
	//부서목록 JqGrid (LeftBox)
	var options = {
		//header name
		colNames:['쿠폰코드','쿠폰명']
		
		//mapping column
		,colModel:[
		           {name:'CD_COUPON' ,width:10}
		          ,{name:'NM_COUPON' ,width:30}
		         ]
		,autowidth:true
		,height:300
		,multiselect:true
		,multiboxonly:true
		,onSelectRow:function(rowid, status, e){
		    if($('#jqg_list_'+rowid).is(":checked")){
    			$(this).resetSelection();
		    	$(this).setSelection(rowid, false);
			}
		}
		,ondblClickRow: function (rowid, iRow, iCol, e) {
			var selRow = $(this).getRowData(rowid);
			var data = {
					  CD_COUPON : selRow.CD_COUPON
					, NM_COUPON : selRow.NM_COUPON
					, flag : flag
			}
			uxl.pushToParent(data);
			uxl.close();
		}
	};
	uxl.grid('list', options);
	
	fnSearch();
		
});

// 데이터 넘겨주기
function fnSave(){
	var rowid = $('#list').getGridParam( "selrow" );
	var selRow = $('#list').jqGrid('getRowData', rowid);

	var data = {
			  CD_COUPON : selRow.CD_COUPON
			, NM_COUPON : selRow.NM_COUPON
			, flag : flag
	}
	uxl.pushToParent(data);
	uxl.close();
}

// 목록 조회
function fnSearch(){
	
	var data = {};
	
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
	uxl.callSubmitFunction('searchForm' , url , option );

}
</script>
		 