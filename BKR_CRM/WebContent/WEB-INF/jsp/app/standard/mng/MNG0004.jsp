<%--
#*
 *  파 일 명 :  MNG0004.jsp
 *  설    명 :  스탬프 적립혜택 관리
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-11-22
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


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : MNG0004R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->

<style>
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>

<script type="text/javascript">
uxl.onLoad(function(){
	
	//스탬프 혜택목록
	var options = {
			//header name
			colNames:['쿠폰코드','쿠폰명','유효기간','STR_COUPON'] 
			
			//mapping column
			,colModel:[
					   {name:'CD_COUPON', width:10, align:'center'}
			          ,{name:'NM_COUPON', width:20, align:'center'}
			          ,{name:'DT_EXPIRY', width:15, align:'center'}
			          ,{name:'STR_COUPON', hidden:true}
			         ]
			,autowidth:true
			,height:90
			,multiselect:true
		};
		uxl.grid('list_cnt5', options);
		uxl.grid('list_cnt10', options);
		
		fnSearch();
});

// 쿠폰 등록 팝업 띄우기
function fnPopup(flag){
	
	var index = $('#list_cnt'+flag).getGridParam("reccount");
	
	if(index == 3){
		alert('적립혜택 쿠폰은 3개까지만 등록 가능합니다.');
		return;
	}
	
	uxl.openWindow('couponPopup'
			, uxl.getScreenURL('POP1003') 
			, {width:900 ,height:600}
			, function(rdata){
				
				var ynFlag = "Y";
				var allData = $('#list_cnt'+flag).getRowData();
				
				for(var i = 0; i < index; i++){
					if(allData[i].CD_COUPON == rdata.CD_COUPON){
						ynFlag='N';
						break;
					} 
				}
				
				if(ynFlag == 'Y'){
					$('#list_cnt'+flag).jqGrid('addRowData', index+1 , rdata);					
				}else{
					alert('이미 등록된 쿠폰입니다.');
				}
			}
	);
}

// 목록에서 삭제
function fnDelList(id_grid){
	
	var id = "#"+id_grid;
	
	var recs = $(id).jqGrid('getGridParam', 'selarrrow');
	var rows = recs.length;
	
	if(rows < 1){
		alert('선택된 상품이 없습니다. \n삭제할 상품을 선택해주세요.');
		return;
	}
	
	for (var i = rows - 1; i >= 0; i--) {
	      $(id).jqGrid('delRowData', recs[i]);
	}

	// 전체선택 해제
	$("#cb_" + id_grid).prop("checked",false);
			
}

// 저장하기
function fnSave(){
	
	var cnt5 = $('#list_cnt5').getGridParam("reccount");
	var allData5 = $('#list_cnt5').getRowData();
	var cnt10 = $('#list_cnt10').getGridParam("reccount");
	var allData10 = $('#list_cnt10').getRowData();
	
	var strCoupon5 = [cnt5];
	var strCoupon10 = [cnt10];
	
	
	for(var i = 0; i < cnt5; i++){
		strCoupon5[i] = allData5[i].STR_COUPON;
	}
	for(var i = 0; i < cnt10;i++){
		strCoupon10[i] = allData10[i].STR_COUPON;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		  data:{
			  STR_COUPON5 : strCoupon5,
			  STR_COUPON10 : strCoupon10
		  }
		, success:function(result){
			uxl.reload();
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.insert.confirm'),
			 success : uxl.getMessage('@message.common.insert.success'),
			 fail 	 : uxl.getMessage('@message.common.insert.fail')
		}
		, async:true
	};
	uxl.callFunction( url , option );
}


// 목록 조회
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
		  data:{}
		, success:function(result){
			
			var rows = result.getDataList(0).rows
			var cnt = result.getDataList(0).rowCount;
			
			for(var i = 0; i < cnt; i++){
				$('#list_cnt'+rows[i].CNT_STAMP_REWARD).jqGrid('addRowData', rows[i].ORDER_NO, rows[i]);
			}
		}
		, async:true
	};
	uxl.callFunction( url , option );
}
</script>