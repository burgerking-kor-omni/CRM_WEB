<%--
#*
 *  파 일 명 :  EXP5000.jsp
 *  설    명 :  DIV 탭 메인화면 샘플
 *  작 성 자 :  강영운
 *  작 성 일 :  2017-04-10
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
	
<%-- <script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-divTab-1.0.0.js'/>"></script> --%>
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-tab-1.3.0.js'/>"></script>
<script type="text/javascript">
/**
 * 탭ID에 해당하는 로딩 한수를 등록하는 함수 선언
 *
 * tabId : 현재탭 id
 * thisTab : 현재탭 객체
 * screenId : 현재 탭에 표시되는 화면ID
 */
var tab;
tab.onLoad('EXP5006', function(tabId, $thisTab, screenId){

 	tab = new uxl.Tabs('tabs2');
	tab.add('APM0001' , uxl.getScreenURL('APM0001'),'APM0001', false);
	tab.add('SYS0011' , uxl.getScreenURL('SYS0011'),'SYS0011', false);

});

</script>	

