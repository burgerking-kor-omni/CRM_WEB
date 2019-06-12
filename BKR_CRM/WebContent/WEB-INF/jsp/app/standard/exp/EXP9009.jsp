<%--
#*
 *  파 일 명 :  EXP9009.jsp
 *  설    명 :  상세화면 페이지
 *  작 성 자 :  황민국
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*#
--%> 
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
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

<script type="text/javascript">
//uxl.onLoad(function(){
$(document).ready(function(){

	/* 임의로 데이터 삽입 */
	$('#ID_VOC').text("1");
	$('#CD_STATUS_TEXT').text("좋음");
	$('#DT_UPD_LAST').text("2017-01-31");
	$('#DT_REG_FST').text("2017-01-19");
	$('#NM_DEPARTMENT').text("서비스팀");
	$('#NM_USER_REG_FST').text("홍길동");
	$('#TEST1').text("한글");
	$('#TEST2').text("한글2");		
});

</script>