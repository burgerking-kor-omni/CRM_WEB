<%--
#*
 *  파 일 명 : MNG0001.jsp
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
 
   - PAGE ID : MNG0001R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	uxl.bindComboCode('FG_USE', 'FLAG_YN', {emptyOption:'전체'});
	
	var options = {
			//header name
			colNames:['NO_STAMP','구분','제목','적용기간',
			          '적용상품 개수','사용여부','등록자','등록일']
	
			//mapping column
			,colModel:[
					  {name:'NO_STAMP'	,hidden:true}
					 ,{name:'TP_SET'	,width:5 ,align:'center' ,codeCategory:'TP_SET' }
					 ,{name:'DS_TITLE'	,width:20 ,align:'center'}
					 ,{name:'DT_APPLY'	,width:15 ,align:'center'}
					 
					 ,{name:'CNT_ROLE'	,width:10 ,align:'center'}
					 ,{name:'FG_USE'	,width:5 ,align:'center'}
					 ,{name:'NM_USER_REG'	,width:10,align:'center'}
			         ,{name:'DT_REG'	,width:10 ,align:'center'}
			]
			, height:435
			,autowidth:true
			,onSelectRow: function(rowid){
				var selectedRow = $(this).getRowData(rowid);
				uxl.moveLocation(uxl.getScreenURL('MNG0002')+ '?NO_STAMP='+selectedRow.NO_STAMP);
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
		uxl.moveLocation(uxl.getScreenURL('MNG0003'));
	});
});

uxl.onLoadComplete(function(){
	$('#FG_USE').val('Y');
	fnSearch();	
});

// 목록 조회
function fnSearch(){
	
	// 날짜 유효성 검사
	var dtStart = "";
	var dtEnd = "";

	if($('#DT_START').val() != "" && $('#DT_END').val() != ""){
		dtStart = new Date($('#DT_START').val());
		dtEnd = new Date($('#DT_END').val());
		if(dtStart > dtEnd ){
			alert('유효기간 검색일자가 유효하지 않습니다.');
			return;
		};
	}

	// 목록 초기화
// 	$("#list").clearGridData();

	var data = {};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:$.extend(data, uxl.grid.getParam('list'))
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
					"<input type='text' style='width:50px;text-align:right;' maxlength=4 value='0' id='txt_"+rowdata.CD_COUPON+"' onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'/><b>  </b>"+
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
	uxl.openWindow('POP0091', uxl.getScreenURL('POP0091')+"?CD_COUPON="+rowid, {width:'500', height:'400'});
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
				+"&CNT_PIN="+$('#txt_'+rowid).val(), {width:'500', height:'300'});
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
				'<span class="ub-control button inner icon"  onclick="PopupPubPinBatch('+rowdata.CD_COUPON+')">'+
			    	'<a href="#none" ><span></span>핀 일괄 발행</a>'+
				'</span>'+
			'</div>';
		return str;
	}
	return '';
}

// 쿠폰 다우 핀 발급
function PopupPubPin(rowid){
	uxl.openWindow('POP0093', uxl.getScreenURL('POP0093')+"?CD_COUPON="+rowid, {width:'600', height:'400'}); 
}

// 쿠폰 일괄 발행
function PopupPubPinBatch(rowid){
	uxl.openWindow('POP0094', uxl.getScreenURL('POP0094')+"?CD_COUPON="+rowid, {width:'700', height:'600'});
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
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
</script>