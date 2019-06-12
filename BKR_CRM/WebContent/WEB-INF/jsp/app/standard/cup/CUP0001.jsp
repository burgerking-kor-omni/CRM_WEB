<%--
#*
 *  파 일 명 :  CUP0001.jsp
 *  설    명 :  다우핀 가져오기 설정
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-11-02
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
 
   - PAGE ID : CUP0001R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->

<script type="text/javascript">

uxl.onLoad(function(){
	$('.ub-control .label').css('font-weight','bold');
});

//저장하기
function fnSave(){
	
	if($('#VAL_LIMIT_PIN').val() == ''){
		alert('남은 쿠폰 수를 입력해주세요.');
		$('#VAL_LIMIT_PIN').focus();
		return;
		
	}else if($('#VAL_BRING_PIN').val() == ''){
		alert('가져올 쿠폰 수를 입력해주세요.');
		$('#VAL_BRING_PIN').focus();
		return;
		
	}else if( $('#VAL_BRING_PIN_MANUAL').val() == ''){
		alert('수동으로 가져올 쿠폰 수를 입력해주세요.');
		$('#VAL_BRING_PIN_MANUAL').focus();
		return;
	}else if ( $('#VAL_FIRST_PIN').val() == ''){
		alert('초기에 가져올 쿠폰 수를 입력해주세요.');
		$('#VAL_FIRST_PIN').focus();
		return;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		  data:{}
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
	uxl.callSubmitFunction( 'detailForm', url , option );
}

</script>