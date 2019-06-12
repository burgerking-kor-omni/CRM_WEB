<%--
#*
 *  파 일 명 :  POP0090.jsp
 *  설    명 :  쿠폰 핀 현황 보기 팝업
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
<%
	DataList _dl_ = ViewUtil.getResult().getDataList("");
// .getString(0,"");

%>
<script type="text/javascript">

uxl.onLoad(function(){
	// 엔터키 입력 시 조회
	$('form').keydown(function() {
	    if (event.keyCode === 13) {
	        fnSearch();
	    }
	});
	fnSearchInfo();
});

function fnSearchInfo(){
	var url = uxl.getFunctionUrl('POP0091','INQUIRY');
	var option = {
			  data:{}
			, success:function(result){
				
				var row = result.getDataList(0).rows[0];
				
				$('#CD_COUPON_OBJ').html(row.CD_COUPON_OBJ);
				$('#NM_COUPON').html(row.NM_COUPON);
				$('#DT_EXPIRY').html(row.DT_EXPIRY);
				$('#CD_STATUS').html(row.CD_STATUS);
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

//이메일로 사용자 찾기
function fnSearch(){
	
	if($("#DS_EMAIL_SEARCH").val() == ''){
		alert("이메일을 입력해 주세요.");
		return false;
	}else{
		var str = $("#DS_EMAIL_SEARCH").val();
		$("#DS_EMAIL_SEARCH").val(str.trim());
	}
	
	$("#DS_EMAIL").val('');
	$("#NM_MEMBER").val('');
	$("#ID_MEMBER").val('');
	
	var url = uxl.getFunctionUrl('POP0093','INQUIRY');
	var option = {
			  data:{}
			, success:function(result){
				
				
				if(result.getDataList(0).rowCount < 1){
					alert('조회된 회원이 없습니다. 이메일을 확인해 주세요.');
					$("#DS_EMAIL_SEARCH").focus();
				}else{
					var row = result.getDataList(0).rows[0];
					
					$("#DS_EMAIL").val($("#DS_EMAIL_SEARCH").val());
					$("#NM_MEMBER").val(row.NM_MEMBER);
					$("#ID_MEMBER").val(row.ID_MEMBER);
				};
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}


function fnPublish(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{}
			, success:function(result){
				fnPublishCoupon();
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

// 발행
function fnPublishCoupon(){
	if($("#ID_MEMBER").val() == ''){
		alert('선택된 회원이 없습니다.');
		return;
	}
   	var ID_MEMBERS = [$("#ID_MEMBER").val()];
	
	
	var url = uxl.getFunctionUrl('POP0094','EXECUTE');
	var option = {
			  data:{ID_MEMBERS : ID_MEMBERS}
			, success:function(result){
				opener.uxl.reload();
				self.close();
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','발행'),
				 success : uxl.getMessage('@message.common.success','발행'),
				 fail : uxl.getMessage('@message.common.fail','발행')
			 }
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}
</script>