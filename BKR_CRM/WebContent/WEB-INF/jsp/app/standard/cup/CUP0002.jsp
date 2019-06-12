<%--
#*
 *  파 일 명 : CUP0002.jsp
 *  설    명 : 쿠폰 마스터 관리 
 *  작 성 자 : 강현준
 *  작 성 일 : 2018.10.18
 *  버    전 : 1.0
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
<%@ page import="com.ubone.standard.common.encrypto.IwtCrypt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUP0002R00
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
	
	
	// 코드 세팅
	uxl.bindComboCode('CD_COUPON_OBJ','CD_COUPON_OBJ',{emptyOption : '전체'});
	uxl.bindComboCode('CD_CUP_STATUS','CD_CUP_STATUS',{emptyOption : '전체'});
	
	
	var options = {
			//header name
			colNames:['CD_COUPON','NO_REQ','쿠폰대상','쿠폰명','유효기간','시작일','종료일'
			          ,'순서','핀 현황','핀 생성','핀발행','등록일']
	
			//mapping column
			,colModel:[
					  {name:'CD_COUPON'	,hidden:true}
					 ,{name:'NO_REQ'	,hidden:true}
					 ,{name:'CD_COUPON_OBJ'	,width:5 ,align:'center' ,codeCategory:'CD_COUPON_OBJ' }
					 ,{name:'NM_COUPON'		,width:20 ,align:'center'}
					 ,{name:'DT_EXPIRY'		,width:15 ,align:'center'}
					 ,{name:'DT_EXPIRY_START',hidden:true}
					 ,{name:'DT_EXPIRY_END'	 ,hidden:true}
					 
					 ,{name:'NO_COUPON_ORDER'	,width:5,align:'center'}
					 ,{name:'PIN_STATUS',width:7  ,align:'center' ,formatter:fnMakebtn ,sortable:false}
			         ,{name:'CNT_DAUPIN',width:20 ,align:'center' ,formatter:fnPubDauPin ,sortable:false}
			         ,{name:'PUBPIN'	,width:20 ,align:'center' ,formatter:fnPubPin ,sortable:false}
			         ,{name:'DT_REG'	,width:10 ,align:'center'}
			]
			, height:435
			,autowidth:true
			,ondblClickRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('CUP0003')+ '?CD_COUPON='+selectedRow.CD_COUPON);
			}
		};
		uxl.grid('list', options);

	// 입력폼 더블 클릭 시 값 초기화
	$('form').dblclick(function(e){
		e.target.value = "";
	});
	
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	
	// 등록버튼
	$('#registBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('CUP0004'));
	});
	
	if ('${paramMap.SEARCH_YN}' != 'Y') {
		if('${paramMap.CD_CUP_STATUS}' == ''){
			$('#CD_CUP_STATUS').val('01');		
		};
	}
	
	$('#SEARCH_YN').val('Y');
	
// 	SetDate()
	fnSearch();
});

// 목록 조회
function fnSearch(){
	// 날짜 유효성 검사
	var dtStart = "";
	var dtEnd = "";

	if($('#DT_EXPIRY_START').val() != "" && $('#DT_EXPIRY_END').val() != ""){
		dtStart = new Date($('#DT_EXPIRY_START').val());
		dtEnd = new Date($('#DT_EXPIRY_END').val());
		if(dtStart > dtEnd ){
			alert('유효기간 검색일자가 유효하지 않습니다.');
			return;
		};
	}
	if($('#DT_START_REG').val()!= "" && $('#DT_END_REG').val()!= ""){
		dtStart = new Date($('#DT_START_REG').val());
		dtEnd = new Date($('#DT_END_REG').val());
		if(dtStart > dtEnd ){
			alert('등록일의 검색일자가 유효하지 않습니다.');
			return;
		};
	}

	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')
			, success:function(result){
				uxl.grid.init('list');
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );

}

// text 박스 생성
function fnPubDauPin(cellValue, options, rowdata, action){
	var flag = rowdata.CD_COUPON_OBJ
	var str = "";
	if(flag == '매장' || flag == '리워드'){
		str =  '<div class="ub-layout button inner" >'+
					"<input type='text' style='width:50px;text-align:right;' maxlength=5 id='txt_"+rowdata.CD_COUPON+"' onkeypress='removeChar(event)' onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' value='"+uxl.setComma(cellValue)+"'/><b>  </b>"+
					'<span class="ub-control button inner icon" onclick="PopupDauPin('+rowdata.CD_COUPON+')" >'+
			    		'<a href="#none" ><span></span>다우에서 핀 발행</a>'+
					'</span>'+ 
				'</div>';
	}
	
	return str;
}

// 버튼 만들기
function fnMakebtn (cellValue, options, rowdata, action){
	var str = 		
	'<div class="ub-layout button inner">'+
		'<span class="ub-control button inner icon" id="viewbtn_'+cellValue+'" onclick="fnView('+rowdata.CD_COUPON+')">'+
	    	'<a href="#none" ><span></span>보기</a>'+
		'</span>'+
	'</div>';
	return str;
}

// 핀 현황 보기 팝업
function fnView(rowid){
	uxl.openWindow('POP0091', uxl.getScreenURL('POP0091')+"?CD_COUPON="+rowid, {width:'500', height:'450'});
}

// 쿠폰 순서 설정 팝업
function fnPopupOrder(){
	uxl.openWindow('POP0090', uxl.getScreenURL('POP0090'), {width:'700', height:'600'},fnOrderUpdate);
}

// 쿠폰 순서 설정 팝업 콜백 함수
function fnOrderUpdate(){
	fnSearch();
}

// 다우에서 핀 발행 팝업
function PopupDauPin(rowid){
	var flag = $('#txt_'+rowid).val();
	if(flag != '' && flag != 0){
		uxl.openWindow('POP0092', uxl.getScreenURL('POP0092')+"?CD_COUPON="+rowid
				+"&CNT_PIN="+$('#txt_'+rowid).val(), {width:'500', height:'350'});
	}else{
		alert("생성할 핀 개수를 입력해주세요.");
		$('#txt_'+rowid).focus();
		return;
	}
	
}

// 쿠폰 자체 핀 발행 버튼 생성
function fnPubPin(cellValue, options, rowdata, action){
	var flag = rowdata.CD_COUPON_OBJ
	if(flag != '매장' && flag != '리워드'  ){
		var str = 
			'<div class="ub-layout button inner">'+
				'<span class="ub-control button inner icon" onclick="PopupPubPin('+rowdata.CD_COUPON+')">'+
			    	'<a href="#none" ><span>핀 발행</span></a>'+
				'</span>'+
				'<span class="ub-control button inner icon" onclick="PopupPubPinBatch('+rowdata.CD_COUPON+')">'+
			    	'<a href="#none"><span>핀 일괄 발행</span></a>'+
				'</span>'+
			'</div>';
		return str;
	}
	return '';
}

// 쿠폰 다우 핀 발급
function PopupPubPin(rowid){
	uxl.openWindow('POP0093', uxl.getScreenURL('POP0093')+"?CD_COUPON="+rowid, {width:'600', height:'450'}); 
}

// 쿠폰 일괄 발행
function PopupPubPinBatch(rowid){
	uxl.openWindow('POP0094', uxl.getScreenURL('POP0094')+"?CD_COUPON="+rowid, {width:'700', height:'650'});
}

//숫자만 입력 가능
function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = uxl.setComma(event.target.value.replace(/[^0-9]/g, ""));
}

//유효기간 이번 주 월 ~ 일까지
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
	$("#DT_EXPIRY_START").val(year+"-"+month+"-"+date);
	
	var d2 = new Date();
	d2.setDate(d.getDate() + 6);
	year = d2.getFullYear();
	month = (d2.getMonth()+1);
	month = month.toString().length == 1 ? '0'+month : month;
	date = d2.getDate();
	date = date.toString().length == 1 ? '0'+date : date;
	$("#DT_EXPIRY_END").val(year+"-"+month+"-"+date);
}

</script>