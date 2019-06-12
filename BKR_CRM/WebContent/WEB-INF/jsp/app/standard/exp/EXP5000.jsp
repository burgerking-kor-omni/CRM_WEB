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
	
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/tab/uxl-divTab-1.0.0.js'/>"></script>
<script type="text/javascript">
var tab = null;
uxl.onLoad(function(){
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('EXP8001');
	});
	
	//저장
	$('#save').click(function(){		
	});
	
	//tab 컨트롤
	tab= new uxl.DivTabs('tabs');
//	tab= new uxl.DivTabs('tabs', {showOnAdded:true, reloadOnShow:true});
	
	tab.add('EXP5001', uxl.getScreenURL('EXP5001'), '등록화면-EXP5001', false);	// 등록화면 예제 / 첨부파일 예제
	tab.add('EXP5002', uxl.getScreenURL('EXP5002')+"?ID_NOTICE=60", 'EXP5002', false);	// 상세화면 예제 / 첨부파일 예제
	tab.add('EXP5003', uxl.getScreenURL('EXP5003'), '목록화면-EXP5003', false);	// 목록화면 예제 / 페이징 / 검색조건 이력(X)
	tab.add('EXP5004', uxl.getScreenURL('EXP5004'), '목록화면-EXP5004', false);	// 목록화면 예제 / 페이징 / 검색조건 이력(X)
	tab.add('EXP5005', uxl.getScreenURL('EXP5005')+"?ID_NOTICE=70", 'EXP5005', false);	// 상세화면 예제 / 첨부파일 예제
	tab.add('EXP5006', uxl.getScreenURL('EXP5006'), 'EXP5006', false);	// 상세화면 예제 / 제이쿼리 탭 > 일반 탭 
	
});
</script>	

