<%--
#*
 *  파 일 명 :  EXP9996.jsp
 *  설    명 :  좌측메뉴예제 (메인 포탈페이지를 LeftMenu가 존재하는 포탈페이지로 이동시켜주는 연결 페이지 )
 *  작 성 자 :  황민국
 *  작 성 일 :  2016-11-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : EXP9996R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================  --> 
<script type="text/javascript">
//uxl.onLoad(function(){
$(document).ready(function(){
	
	alert("LeftMenu가 적용된 포탈페이지로 이동됩니다.\n상단 TopMenu영역을 클릭하면 LeftMenu가 생성됩니다.");
	
	/*
	*POR0011.jsp(TopMenu가 WideMenu기준의 LeftMenu)
	*POR0017.jsp(TopMenu가 SimpleMenu기준의 LeftMenu)
	*/	
	parent.document.location.href=uxl.getScreenURL('POR0011');
	 
});


</script>