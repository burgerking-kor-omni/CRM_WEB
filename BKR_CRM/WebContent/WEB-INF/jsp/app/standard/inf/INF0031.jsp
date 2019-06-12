<%--
#*
 *  파 일 명 :  INF0030.jsp
 *  설    명 :  공지사항 팝업 기한 설정
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-08-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
<script type="text/javascript">
uxl.onLoad(function(){

	//첨부파일 다운로드
	uxl.ext.Upload('file', {readOnly : true});
	
	//닫기 버튼
	$('#close').click(function(){
		uxl.close();
	});
	
	//저장 버튼
	$('#save').click(function(){
		fnPushToOpener();
	});
	
});//END OF ONLOAD


function fnPushToOpener(){
	
	var dateData = {
		  startDate	: 	$('#DT_START_POPUP').val()				
		, endDate	: 	$('#DT_END_POPUP').val()				
	};
	uxl.pushToParent(dateData);
	self.close();
	
}

</script>	