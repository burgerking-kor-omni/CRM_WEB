<%--
#*
 *  파 일 명 :  CUS0030.jsp
 *  설    명 :  회원등급 기준관리
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-10-05
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
 
   - PAGE ID : CUS0030R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	$('#delBtn').hide();
	$('#lbl_warring, #lbl_warring2').attr('style','color:red; font-weight:bold;');
	
	uxl.bindComboCode('FG_USE', 'FLAG_YN', {emptyOption:'선택안됨'});
	
	//등급목록 JqGrid (왼쪽)
	var options = {
		//header name
		colNames:['등급코드','등급명','스탬프개수','사용여부'
		          ,'최소개수','최대개수'] 
		
		//mapping column
		,colModel:[
		           {name:'CD_GRADE'  , width:10 ,align:'center',sortable:false}
		          ,{name:'NM_GRADE'  , width:20 ,align:'center',sortable:false}
		          ,{name:'CNT_STAMP' , width:10 ,align:'center',sortable:false}
		          ,{name:'FG_USE' , width:10 ,align:'center',sortable:false}
		          
		          ,{name:'CNT_MIN_STAMP' ,hidden:true }
		          ,{name:'CNT_MAX_STAMP' ,hidden:true }
		         ]
		,autowidth:true
		,onSelectRow:function(rowid, status, e){
			$("#YN_NEW").val('N');
			var selRow = $(this).getRowData(rowid).CD_GRADE;
			fnSelgrade(selRow);
		}
	};
	uxl.grid('list_grade', options);
	
	//등급 쿠폰목록 (오른쪽 아래)
	options = {
			//header name
			colNames:['관계코드','쿠폰코드','쿠폰명','유효기간'] 
			
			//mapping column
			,colModel:[
					   {name:'NO_GRADE_RELATION', hidden:true}
			          ,{name:'CD_COUPON', width:10}
			          ,{name:'NM_COUPON', width:20}
			          ,{name:'DT_EXPIRY', width:10, align:'center' }
			         ]
			,autowidth:true
			,multiselect:true
		};
		uxl.grid('list_coupon', options);
	
	//등급 신규추가
	$('#newBtn').click(function(){
		if($('#YN_NEW').val() == 'Y'){
			return false;
		}else{
			fnNewGrade();
		}
	});
	
	// 저장
	$('#saveBtn').click(function(){
		
		// 선택된 행 체크
		var selrow = $('#list_grade').getGridParam( "selrow" );
		if(selrow == null){
			alert('선택된 행이 없습니다.');
			return;
		}

		// 스탬프 개수 유효성검사
		var flag = '00';
		var rowid  = $("#list_grade").jqGrid('getGridParam', "selrow" );
		var currMin = $('#CNT_MIN_STAMP').val();
		var currMax = $('#CNT_MAX_STAMP').val();

		// 입력한 최소/최대 개수 검사
		if(currMin*1 > currMax*1){
			flag = '01';
		}
		
		// 스탬프 개수 유효성검사 02 = 최소개수 오류, 99 = 최대개수 오류
		var alldata = $("#list_grade").getRowData();
		var rowcnt = $("#list_grade").getGridParam("reccount");
		for(var i = 0; i < rowcnt; i++){
			if(!uxl.isEmpty($("#list_grade").getRowData()[i].CD_GRADE)){
				if( i < rowid*1 ){
					if(alldata[i].CNT_MAX_STAMP*1 >= currMin*1 && alldata[i].CNT_MAX_STAMP*1 != 0 ){
						flag = '02'
					}
					if(currMax*1 < alldata[i].CNT_MIN_STAMP*1 ){
						flag = '99'
					}
				}else if( rowid*1 < i ){
					if(alldata[i].CNT_MIN_STAMP*1 <= currMin*1){
						flag = '02'
					}
					if(currMax*1 >= alldata[i].CNT_MIN_STAMP*1 ){
						flag = '99'
					}
				}
			}
		}
		
		// flag 값에 따른 메세지
		switch (flag) {
		case '00':
			fnSave();
			break;
		case '01':
			alert('스탬프 개수가 유효하지 않습니다.');
			break;
		case '02':
			alert('최소 스템프 개수가 유효하지 않습니다.');
			break;
		case '99':
			alert('최대 스탬프 개수가 유효하지 않습니다.');
			break;
		}
	});
	
	// 고객 등급 삭제 처리
	$('#delBtn').click(function(){
		fnDelete();
	});

	fnSearch_grade();
});

//등급 조회
function fnSearch_grade(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
		  data:uxl.grid.getParam('list_grade')
		, success:function(result){
			uxl.grid.appendData('list_grade' ,result , true );
		}
		, async:true
	};
	uxl.callFunction( url , option );
}

// 등급 상세 저장
function fnSave(){
	var flag = $("#YN_NEW").val();
	var alias,msg = "";
	
	// 신규등록 체크
	if(flag == 'Y'){
		alias = "REGIST";
		msg = 'insert'
	}else{
		alias = "MODIFY";
		msg = 'update';
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID, alias);
	var option = {
		  data:{
			  CD_DOWN_STAD : $("#CD_DOWN_STAD").val()
		  }
		, validator:function(data,targetForm){
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)){
				returnVal = true;
			}
			return returnVal;
		}
		, success:function(result){
			uxl.reload();
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.'+msg+'.confirm'),
			 success : uxl.getMessage('@message.common.'+msg+'.success'),
			 fail 	 : uxl.getMessage('@message.common.'+msg+'.fail')
		}
		, async:true
	};
	uxl.callSubmitFunction( 'detailForm', url , option );
}

// 등급상세조회
function fnSelgrade(selrow){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'CONFIRM');
	var option = {
		  data:{ CD_GRADE : selrow}
		, success:function(result){
			
			if(result.getDataList(0).rowCount > 0){
				var row = result.getDataList(0).rows[0];
				$('#CD_GRADE').val(row.CD_GRADE);
				$('#NM_GRADE').val(row.NM_GRADE);
				$('#CNT_MIN_STAMP').val(uxl.setComma(row.CNT_MIN_STAMP));
				$('#CNT_MAX_STAMP').val(uxl.setComma(row.CNT_MAX_STAMP));
				$('#FG_USE').val(row.FG_USE);
				$('#RT_DSCNT_CART').val(row.RT_DSCNT_CART);
				$('#CD_DOWN_STAD').val(row.CD_DOWN_STAD);
				$('#delBtn').show();
			}else{
				$('#CD_GRADE').val('');
				$('#NM_GRADE').val('');
				$('#CNT_MIN_STAMP').val('');
				$('#CNT_MAX_STAMP').val('');
				$('#FG_USE').val('Y');
				$('#RT_DSCNT_CART').val('');
				$('#YN_NEW').val('Y');
				$('#delBtn').hide();
			}
			
		}
		, async:true
	};
	uxl.callFunction( url , option );
}

// 등급 신규추가
function fnNewGrade(){
	$('#delBtn').hide();
	var rowcnt = $('#list_grade').getGridParam("reccount");
	
	$("form").each(function() {  
		this.reset();	
    });
	
	// 등급 목록에 로우추가
	$('#list_grade').jqGrid("addRowData", rowcnt+1, {
		CD_GRADE : ''
		, NM_GRADE :  ''
		, CNT_STAMP : ''
	});
	
	$('#YN_NEW').val('Y');
	$('#FG_USE').val('Y');
	$('#list_grade').setSelection(rowcnt+1,false);
}

function fnDelete(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
		  data:{ CD_GRADE : $('#CD_GRADE').val() }
		, success:function(result){
			uxl.reload();
		}
		, message : {
			 confirm : '정말로 삭제하시겠습니까?\n등급 삭제 시 회원들은 해당 등급혜택을 받지 못합니다.',
			 success : uxl.getMessage('@message.common.delete.success'),
			 fail 	 : uxl.getMessage('@message.common.delete.fail')
		}
		, async:true
	};
	uxl.callFunction( url , option );
}

</script>
		 