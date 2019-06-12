<%--
#*
 *  파 일 명 :  SYS0041.jsp
 *  설    명 :  배치 등록
 *  작 성 자 :  안신용
 *  작 성 일 :  2013-05-22
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>

<script type="text/javascript">
uxl.onLoad(function(){
	
	uxl.bindComboCode('BATCH_TYPE', 'BATCH_TYPE', {emptyOption:'선택안됨'});
	
	// 목록 이동
	$('#listBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('SYS0040'));
	});
	
	// 저장 버튼
	$('#insertBtn').click(function(){
		insertBatch();
	});
	
	$('input[id^=EXEC_COND]').on('keyup', function(){
		$(this).val($(this).val().replace(/[^0-9\*]/gi,""));
	});
	$('#SCHEDULE').append('<span/>').children().attr('class','required').append('*');
});	
$(document).ready(function(){
	$('label[for^=EXEC_COND] > span').remove();
});
//배치 등록
function insertBatch(){
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
					uxl.moveLocation(uxl.getScreenURL('SYS0040'));
				}
				, async:true
		};
		uxl.callSubmitFunction('insertForm' , url , option );
}
</script>