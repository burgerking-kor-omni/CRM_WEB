<%--
#*
 *  파 일 명 :  POP0101.jsp
 *  설    명 :  스탬프 추가 팝업
 *  작 성 자 :  강현준
 *  작 성 일 :  2018.12.10
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
 
   - PAGE ID : POP0101R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript">

uxl.onLoad(function(){
	
});

function fnSave(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			data:{}
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
				self.close();
			}
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','추가'),
				 success : uxl.getMessage('@message.common.success','추가'),
				 fail 	 : uxl.getMessage('@message.common.fail','추가')
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );

}
</script>