<%--
#*
 *  파 일 명 :  POP0102.jsp
 *  설    명 :  회원명 변경 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2019.08.02
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
 
   - PAGE ID : POP0102R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	$('#updateBtn').click(function(){
		fnUpdate();
	});
	
	$("#NM_MEMBER").bind("keyup",function(){
		var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
	    var temp=$("#NM_MEMBER").val();
	    if(re.test(temp)){ 
	    	alert("특수문자는 입력하실 수 없습니다.");
	        $("#NM_MEMBER").val(temp.replace(re,"")); 
	    } 
	});
});

function fnUpdate(){
	
	if($('#NM_MEMBER').val() == ''){
		alert('변경할 이름을 입력해주세요.');
		return false;
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			data:{NM_MEMBER_BR : opener.$('#NM_MEMBER').val()}
			, validator:function(data,targetForm){
				var returnVal = false;
				//필수항목체크
				if(uxl.checkRequiredFields(targetForm)){
						returnVal = true;
				}
				return returnVal;
			}
			, success:function(result){
				opener.uxl.reload();
				self.close();
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','변경'),
				 success : uxl.getMessage('@message.common.success','변경'),
				 fail 	 : uxl.getMessage('@message.common.fail','변경')
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );

}
</script>