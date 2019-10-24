<%--
#*
 *  파 일 명 :  POP4001.jsp
 *  설    명 :  이메일 변경 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2019.08.20
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
  This page is generated with the UB-META™ ver6.0 
 
   - PAGE ID : POP4001R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	$('#DS_EMAIL').dblclick(function (){
		$(this).val('');
	});
	$('#DS_EMAIL').keydown(function (e){
		if (e.keyCode == 32) {
			return false;
		}
	});
	
	$('#updateBtn').click(function(){
		var test = $('#DS_EMAIL').val();
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	    
		if(test != '' && test != 'undefined' && regex.test(test)){
			fnSave();
		}else{
			alert('유효하지 않는 이메일 주소입니다.');
		}
	});
	

});

function fnSave(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			  data:{}
			, success:function(result){
				if(result.getResult().extendAttributeMap[0].resultStatus){
					uxl.pushToParent('');
					uxl.close();	
				};
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail 	 : uxl.getMessage('@message.common.update.fail')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}
</script>