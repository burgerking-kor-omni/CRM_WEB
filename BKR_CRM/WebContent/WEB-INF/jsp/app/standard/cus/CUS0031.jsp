<%--
#*
 *  파 일 명 :  CUS0031.jsp
 *  설    명 :  스탬프 기준관리
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-10-22
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
 
   - PAGE ID : CUS0031R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->
<%
	DataList _dl_cd_buy_method = ViewUtil.getResult().getDataList("Code.CD_BUY_METHOD");
%>
 

<script type="text/javascript">

uxl.onLoad(function(){

	// 구매방법 그리기
	fnSetTd();
	
	// 코드 세팅
	uxl.bindComboCode('FG_USE', 'FLAG_YN', {emptyOption:'선택안됨'});
	
	//등급목록 JqGrid (왼쪽)
	var options = {
		//header name
		colNames:['상품명','가격','상태','적립개수','사용여부'] 
		
		//mapping column
		,colModel:[
		           {name:'' , width:20 ,align:'center'}
		          ,{name:'' , width:15 ,align:'center'}
		          ,{name:'' , width:10 ,align:'center'}
		          ,{name:'' , width:10 ,align:'center'}
		          ,{name:'' , width:10 ,align:'center'}
		         ]
		,autowidth:true
		,height:200
		,onSelectRow:function(rowid, status, e){
			var selRow = $(this).getRowData(rowid);
		}
	};
	uxl.grid('list_prod', options);
	
	//등급 쿠폰목록 (오른쪽 아래)
	options = {
			//header name
			colNames:['변경일시','변경항목','변경전','변경후','변경자'] 
			
			//mapping column
			,colModel:[
					   {name:'', width:10, align:'center'}
			          ,{name:'', width:20, align:'center'}
			          ,{name:'', width:10, align:'center' }
			          ,{name:'', width:10, align:'center' }
			          ,{name:'', width:10, align:'center' }
			         ]
			,autowidth:true
			,height:200
			,multiselect:true
		};
		uxl.grid('list_change', options);
	
	//등급 신규추가
	$('#newBtn').click(function(){
		fnNewGrade();
	});
	
	
	// 쿠폰 추가
	$('#addBtn').click(function(){
		var url = uxl.getScreenURL('POP1003');
		url = uxl.addQueryToUrl(url, '', $('#').val());
		uxl.openWindow('add_coupon', url, {width:850, height:500}, fnAddcoupon);
	});
	
	// 구매방법 변경 시
	$('input[type=radio][name=CD_BUY_METHOD]').change(function(){
		
		
	});

// 	fnSearch_grade();
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

// 등급 신규등록
function fnNewGrade(){
	
	$("#list_coupon").clearGridData();

	
	var rowcnt = $('#list_grade').getGridParam("reccount");
	var cd_grade = (rowcnt+1).length >= 2 ? rowcnt+1 : '0'+(rowcnt+1);
	
	$("form").each(function() {  
        this.reset();  
    });
	
	// 등급 목록에 로우추가
	$('#list_grade').jqGrid("addRowData", rowcnt+1, {
		CD_GRADE : cd_grade
		, NM_GRADE :  ''
		, CNT_STAMP : ''
	});
	// 코드 입력
	$('#CD_GRADE').val(cd_grade);
	$('#FG_USE').val('Y');
	$("#YN_NEW").val('Y')
	
	$('#list_grade').setSelection(rowcnt+1,false);
}

// 등급별 쿠폰목록 조회
function fnSearch_coupon(){
	var data = {
			CD_GRADE : $('#CD_GRADE').val()
	};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
		  data:$.extend(data, uxl.grid.getParam('list_coupon'))
		, success:function(result){
			uxl.grid.appendData('list_coupon' ,result , true );
		}
		, async:true
	};
	uxl.callFunction( url , option );
}

// 구매방법 td 그리기
function fnSetTd(){

	$('#layout-1_1_2').remove();
<%
	int rowcnt = _dl_cd_buy_method.getRowCount();
	for(int i = 0; i < rowcnt ; i++){
%>
	$('#layout-1_1').append(makeRadio('layout-1_1_'+<%=i+2%>,'<%=_dl_cd_buy_method.get(i).get("CODE")%>','<%=_dl_cd_buy_method.get(i).get("CODE_NAME")%>'));
<%
	}
%>
	$('#layout-1_1:first td').each(function(){
		if($(this).attr('id') == null ){
			$(this).remove();
		};
	});
<%
	if(rowcnt < 6){
%>
	$('#layout-1_1:first').append('<td colspan='+<%=6-rowcnt%>+'></td>');
<%
	}
%>
} 

// 라디오 버튼 그리기
function makeRadio(tid, rval, rtitle){
	var str = '<td id='+tid+'><input class="ub-control radio" name="CD_BUY_METHOD" type="radio" value='+rval+' /><label>'+rtitle+'</label><td>';
	return str;
}

// 팝업 띄우기
function fnPopup(flag,sub){
	
	// 팝업창 크기 조절
	var wstr,hstr ;
	if(sub == 'P'){
		wstr = '500';
		hstr = '250';
	}else{
		wstr = '1200';
		hstr = '650';
	}

	uxl.openWindow(flag, uxl.getScreenURL(flag)+"?SUB="+sub, {width:wstr ,height:hstr }, fnCallback);
}

// 각 팝업창 콜백 함수
function fnCallback(rdata){
	if(rdata.flag == 'P'){
		alert('p');
	}else if(rdata.flag == 5){
		$('#NM_COUPON_5').val(rdata.NM_COUPON);
	}else if(rdata.flag == 10){
		$('#NM_COUPON_10').val(rdata.NM_COUPON);
	};
}

</script>