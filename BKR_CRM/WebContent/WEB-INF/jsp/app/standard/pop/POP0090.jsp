<%--
#*
 *  파 일 명 :  POP0090.jsp
 *  설    명 :  쿠폰 순서 설정 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.11.06
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
 
   - PAGE ID : POP0090R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
	SetDate();
	
	//콤보 세팅
	uxl.bindComboCode('CD_COUPON_OBJ','CD_COUPON_OBJ',{emptyOption : false});	
	
	// 매장 목록
	var	options = {
			//header name
			colNames:['쿠폰코드','순서','쿠폰명','유효기간','순서변경']

			//mapping column
			,colModel:[
			          {name:'CD_COUPON',hidden:true}
			         ,{name:'NO_COUPON_ORDER',width:20,align:'center'}
			         ,{name:'NM_COUPON',width:20,align:'center'}
					 ,{name:'DT_EXPIRY',width:20,align:'center'}
					 ,{name:'EDIT_ROW',width:15,align:'center',formatter: formatOpt1}
			]
			, height:290
			, autowidth:true
			,ondblClickRow: function (rowid, iRow, iCol, e) {
// 				var selRow = $(this).getRowData(rowid);
// 				var data = {
// 						STOR_CD : selRow.STOR_CD,
// 						STOR_NM : selRow.STOR_NM
// 				}
// 				uxl.pushToParent(data);
// 				uxl.close();
			}
		};
	uxl.grid('list', options);

	// 엔터키 이벤트
	$('#searchForm').keydown(function (key) {
		if(key.keyCode == 13){
			fnSearch();	
		}
	});
	
// 	$('#CD_COUPON_OBJ');
	$('#CD_COUPON_OBJ').change(function(){
		fnSearch();
	}).val('1').change();
	
});

// 상품목록 조회
function fnSearch(){
	
	if($('#DT_EXPIRY_START_ORDER').val() == '' || $('#DT_EXPIRY_END_ORDER').val() == ''){
		alert("유효기간을 설정해주세요!");
		return;
	}else{
		// 날짜 유효성 검사
		var dtStart = new Date($('#DT_EXPIRY_START_ORDER').val());
		var dtEnd = new Date($('#DT_EXPIRY_END_ORDER').val());

		if(dtStart > dtEnd ){
			alert('유효기간 검색일자가 유효하지 않습니다.');
			return;
		}
	}
	
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

// 저장
function fnSave(){
	
	if($('#DT_EXPIRY_START_ORDER').val() == '' || $('#DT_EXPIRY_END_ORDER').val() == ''){
		alert("유효기간을 설정해주세요!");
		return;
	}
	
	var rowids = $('#list').jqGrid('getRowData');
	var cd_coupon = [];
	var no_coupon_order = [];
	for(var i = 0; i < rowids.length; i++){
			cd_coupon[i] = rowids[i].CD_COUPON
			no_coupon_order[i] = i+1;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'REGIST');
	var option = {
		data : {
			CD_COUPON : cd_coupon
			,NO_COUPON_ORDER : no_coupon_order
		},
		success : function(result) {
			uxl.pushToParent('');
			uxl.close();
		}
		,async : true
		, message : {
			 confirm : uxl.getMessage('@message.common.insert.confirm'),
			 success : uxl.getMessage('@message.common.insert.success'),
			 fail 	 : uxl.getMessage('@message.common.insert.fail')
		}
	};
	uxl.callSubmitFunction( 'searchForm', url , option );
}

// 순서 이동 버튼 만들기
function formatOpt1(cellvalue, options, rowObject){
	var str = "";

	str += '<div class="ub-layout rightBox" value="'+options.rowId+'"><a href="javaScript:upLine('+(options.rowId)+')" title="위" class="ub-control button imgBtn img-up" id="UP_LINE" name="UP_LINE"><span></span></a><a href="javaScript:downLine('+(options.rowId)+')" title="아래" class="ub-control button imgBtn img-down" id="DOWN_LINE" name="DOWN_LINE"><span></span></a></div>';    
  	
	return str;
}

//위로가기 버튼 클릭시
function upLine(index){
	
	var rowids = $('#list').jqGrid('getRowData');
	var data=new Array(rowids.length);
	//jqgrid 안의 데이터를 저장
	for(var i=0;i<rowids.length;i++){
		data[i]=rowids[i];
	}
	
	//row가 1번째 줄이 아닐경우만
	if(index>0){
	
		//해당 데이터와 윗줄의 데이터를 바꾼다.
		data[index-1] = {
						CD_COUPON	: rowids[index].CD_COUPON
					,   NO_COUPON_ORDER		: rowids[index-1].NO_COUPON_ORDER
					,	NM_COUPON			: rowids[index].NM_COUPON				//부서코드
					,	DT_EXPIRY			: rowids[index].DT_EXPIRY				//부서명
					,	EDIT_ROW		: rowids[index-1].EDIT_ROW
				};
		data[index] = {
						CD_COUPON	: rowids[index-1].CD_COUPON
					,   NO_COUPON_ORDER		: rowids[index].NO_COUPON_ORDER
					,	NM_COUPON			: rowids[index-1].NM_COUPON				//부서코드
					,	DT_EXPIRY			: rowids[index-1].DT_EXPIRY				//부서명
					,	EDIT_ROW		: rowids[index].EDIT_ROW
				};
				
	
		//grid 안의 데이터를 모두 삭제
		for(var i=0;i<rowids.length;i++){
			$("#list").jqGrid('delRowData', i);
		}
		//grid 안의 데이터를 정렬된 값으로 다시 셋팅
		for(var i=0;i<rowids.length;i++){
			$("#list").jqGrid('addRowData', i , data[i]);
		}
	}		
}

//아래로 가기 버튼 클릭시
function downLine(index){
	
	var rowids = $('#list').jqGrid('getRowData');
	var data=new Array(rowids.length);
	//jqgrid 안의 데이터를 저장
	for(var i=0;i<rowids.length;i++){
		data[i]=rowids[i];
	}
	
	//row가 마지막줄이 아닐경우만
	if(rowids.length > index){
		//해당 데이터와 아랫줄의 데이터를 바꾼다.
		data[index+1] = {
						CD_COUPON	: rowids[index].CD_COUPON
					,   NO_COUPON_ORDER		: rowids[index+1].NO_COUPON_ORDER
					,	NM_COUPON			: rowids[index].NM_COUPON				//부서코드
					,	DT_EXPIRY			: rowids[index].DT_EXPIRY				//부서명
					,	EDIT_ROW		: rowids[index+1].EDIT_ROW
				};
		data[index] = {
						CD_COUPON	: rowids[index+1].CD_COUPON
					,   NO_COUPON_ORDER		: rowids[index].NO_COUPON_ORDER
					,	NM_COUPON			: rowids[index+1].NM_COUPON				//부서코드
					,	DT_EXPIRY			: rowids[index+1].DT_EXPIRY				//부서명
					,	EDIT_ROW		: rowids[index].EDIT_ROW
				};
			
	
		//grid 안의 데이터를 모두 삭제
		for(var i=0;i<rowids.length;i++){
			$("#list").jqGrid('delRowData', i);
		}
		//grid 안의 데이터를 정렬된 값으로 다시 셋팅
		for(var i=0;i<rowids.length;i++){
			$("#list").jqGrid('addRowData', i , data[i]);
		}
	}		
}

// 유효기간 이번 주 월 ~ 일까지
function SetDate(){
	var d = new Date();
	var day = d.getDay(), 
				diff = d.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
	var dd = new Date(d.setDate(diff));
	var year = dd.getFullYear();
	var month = (dd.getMonth()+1);
	month = month.toString().length == 1 ? '0'+month : month;
	var date = dd.getDate();
	date = date.toString().length == 1 ? '0'+date : date;
	$("#DT_EXPIRY_START_ORDER").val(year+"-"+month+"-"+date);
	
	var d2 = new Date();
	d2.setDate(d.getDate() + 6);
	year = d2.getFullYear();
	month = (d2.getMonth()+1);
	month = month.toString().length == 1 ? '0'+month : month;
	date = d2.getDate();
	date = date.toString().length == 1 ? '0'+date : date;
	$("#DT_EXPIRY_END_ORDER").val(year+"-"+month+"-"+date);
}
</script>