<%--
#*
 *  파 일 명 :  CUP0021.jsp
 *  설    명 :  쿠폰 마스터 상세
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-12-05
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
 
   - PAGE ID : CUP0021R00
   - PAGE TYPE : Meta
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
-->

<script type="text/javascript">
uxl.onLoad(function(){
	
	// 날짜 세팅
	var d = new Date();
	var day = d.getDay(), 
				diff = d.getDate() - day + (day == 0 ? -6:1);
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
});


function fnSave(){
	
	// 날짜 유효성 검사
	var dtStart = new Date($('#DT_EXPIRY_START').val());
	var dtEnd = new Date($('#DT_EXPIRY_END').val());
	
	if(dtStart > dtEnd ){
		// 시작일이 종료일보다 늦을때
		alert('유효기간이 유효하지 않습니다.');
		return;
	};
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
		data:{
			
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
			uxl.pushToParent();
			uxl.close();
		}
		, message : {
			 confirm : uxl.getMessage('@message.common.confirm','재등록'),
			 success : uxl.getMessage('@message.common.success','재등록'),
			 fail 	 : uxl.getMessage('@message.common.fail','재등록')
		}
		, async:true
	};
	uxl.callSubmitFunction( 'registForm', url , option );
}
</script>