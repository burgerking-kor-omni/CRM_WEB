<%--
#*
 *  파 일 명 :  CUS0001.jsp
 *  설    명 :  고객 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.06.19
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
<%@ page import="com.ubone.standard.common.encrypto.IwtCrypt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : CUS0001R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<%
	String NM_MEMBER = request.getParameter("NM_MEMBER") != null ? IwtCrypt.aesDecryptHex(request.getParameter("NM_MEMBER")) : "" ;
	String NO_PHONE = request.getParameter("NO_PHONE") != null ? IwtCrypt.aesDecryptHex(request.getParameter("NO_PHONE")) : "" ;
%>
<style>
	.ui-jqgrid-bdiv tr { cursor : pointer; }
	.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis;-o-text-overflow: ellipsis; }
</style>
<script type="text/javascript">

uxl.onLoad(function(){
	
	// 엑셀 다운로드 숨김 처리
	$("#excel_layout").hide();
	
	// 코드 세팅
	uxl.bindComboCode('CD_GRADE','CD_GRADE',{emptyOption : '전체'});
	uxl.bindComboCode('CD_JOIN_SITE','CD_JOIN_SITE',{emptyOption : '전체'});
	uxl.bindComboCode('CD_STATUS','CD_STATUS',{emptyOption : '전체'});
	uxl.bindComboCode('CD_JOIN_PATH','ORDER_CHN',{emptyOption : '전체'});
	
	var options = {
		//header name
		colNames:['회원PK','회원명','이메일','전화번호','회원등급','회원상태','가입경로','가입사이트','가입일']

		//mapping column
		,colModel:[
				 {name:'ID_MEMBER',width:10,align:'center'}
		         ,{name:'NM_MEMBER', width:15,align:'center' ,sortable:false}
				 ,{name:'DS_EMAIL',width:20,align:'center'}
		         ,{name:'NO_PHONE', width:20,align:'center',formatter: setPhoneNo ,sortable:false}
		         ,{name:'CD_GRADE',width:10,align:'center', codeCategory:'CD_GRADE'}
		         ,{name:'CD_STATUS',width:10,align:'center', codeCategory:'CD_STATUS'}
		         ,{name:'CD_JOIN_PATH',width:20,align:'center', codeCategory:'ORDER_CHN'}
		         ,{name:'CD_JOIN_SITE',width:20,align:'center', codeCategory:'CD_JOIN_SITE'}
		         ,{name:'DT_JOIN' ,width:15,align:'center'}
				 
		]
		, height:435
		,autowidth:true
		,onSelectRow: function(rowid){
			var selectedRow = $(this).getRowData(rowid);
			uxl.moveLocation(uxl.getScreenURL('CUS0002')+ '?ID_MEMBER='+selectedRow.ID_MEMBER );
		}
	};
	uxl.grid('list', options);
	
	// 검색버튼 클릭시 조회
	$("#search").click(function(event){
		fnSearch();
	});
	
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
	
	// 전화번호 숫자만
	$('#NO_PHONE_SEARCH').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
	fnSearch();
});

// 목록 조회
function fnSearch(){
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_START').val());
	var dtEnd = new Date($('#DT_END').val());
	
	if($('#DT_START').val() == '' || $('#DT_END').val() == ''){
		if($('#NM_MEMBER_SEARCH').val() == '' 
				&& $('#DS_EMAIL').val() == ''
				&& $('#NO_PHONE_SEARCH').val() == ''
				&& $('#ID_MEMBER').val() == '' ){
			alert('가입일자를 입력해주세요.');
			$('#DT_START').focus();
			return;
		}
	}else if(dtStart > dtEnd ){
		// 시작일이 종료일보다 늦을때
// 		var temp = $('#DT_START').val();
// 		$('#DT_START').val($('#DT_END').val());
// 		$('#DT_END').val(temp);
		alert('가입일의 검색일자가 유효하지 않습니다.');
		return;
	};
	
	var dtStartLater = new Date($('#DT_START').val());
	dtStartLater.addMonths(6);
	
	if(dtStartLater < dtEnd){
		
        var FirstDate = new Date($('#DT_START').val());
        var SecondDate = new Date($('#DT_END').val());

		var calDate = SecondDate - FirstDate;
		
		var calDateDays = calDate / ( 24*60*60*1000); 
		 
		if(calDateDays > 186){
			alert('가입일자 최대 검색기간은 6개월입니다. 다시 입력해주세요.');
			return;
		};
		
// 		dtStartLater.setDate(0);
// 		if(dtEnd.getDate() != dtStartLater.getDate() && dtEnd.getDate() != 31){
// 		};
		
	};
	
	var str_email = $('#DS_EMAIL').val().trim();
	if(str_email != ''){
		if(str_email.length < 2 ){
			alert('이메일은 2글자 이상부터 검색가능합니다.');
			$('#DS_EMAIL').focus();
			return;
		}		
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

function setPhoneNo(cellValue, options, rowdata, action){
	var formatNum = '';
    if(cellValue.length==11){
    	formatNum = cellValue.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }else if(cellValue.length==8){
        formatNum = cellValue.replace(/(\d{4})(\d{4})/, '010-$1-$2');
    }else if(cellValue.length==10){
    	formatNum = cellValue.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }if(cellValue.length==9){
        	formatNum = cellValue.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
    }
    return formatNum;
	
}
</script>