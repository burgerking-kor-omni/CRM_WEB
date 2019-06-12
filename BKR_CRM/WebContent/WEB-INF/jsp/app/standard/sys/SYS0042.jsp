<%--
#*
 *  파 일 명 :  SYS0042.jsp
 *  설    명 :  배치 상세
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
	// 목록 이동
	$('#listBtn').click(function(){
		uxl.returnToList('SYS0040');
	});
	
	//등록버튼
	$('#insertBatchBtn').click(function(){
		uxl.moveLocation(uxl.getScreenURL('SYS0041'));
	});
	
	var batchId = $('#BATCH_ID').val();
	
	//준비버튼
	$('#readyBtn').click(function(){
		updateBatchStatus(batchId,'00');				
	});
	
	//강제실행버튼
	$('#forceBtn').click(function(){
		updateBatchStatus(batchId,'01');
	});
	
	//수정버튼
	$('#updateBtn').click(function(){
		updateBatch();
	});
	
	//삭제버튼
	$('#deleteBtn').click(function(){
		deleteBatch();
	});
	
	$('input[id^=EXEC_COND]').on('keyup', function(){
		$(this).val($(this).val().replace(/[^0-9\*]/gi,""));
	});
	$('#SCHEDULE').append('<span/>').children().attr('class','required').append('*');
});
$(document).ready(function(){
	$('label[for^=EXEC_COND] > span').remove();
});

//배치 상태 수정(준비&강제실행)
function updateBatchStatus(BATCH_ID,BATCH_STATUS){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
				  data:{
					  ID:BATCH_ID
					 ,BATCH_STATUS:BATCH_STATUS
				  }
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							returnVal = true;
						}
						return returnVal;
				}
				, success:function(result){
					uxl.reload();
				}
				, message : {
					 confirm : uxl.getMessage('@message.common.update.confirm'),
					 success : uxl.getMessage('@message.common.update.success'),
					 fail : uxl.getMessage('@message.common.update.fail')
				}
				, async:true
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//배치 수정
function updateBatch(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
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
					uxl.reload();
				}
				, message : {
					 confirm : uxl.getMessage('@message.common.update.confirm'),
					 success : uxl.getMessage('@message.common.update.success'),
					 fail : uxl.getMessage('@message.common.update.fail')
				}
				, async:true
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}

//배치 삭제
function deleteBatch(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
	var option = {
				  data:{}
				, success:function(result){
					uxl.moveLocation(uxl.getScreenURL('SYS0040'));
				}
				, message : {
					 confirm : uxl.getMessage('@message.common.delete.confirm'),
					 success : uxl.getMessage('@message.common.delete.success'),
					 fail : uxl.getMessage('@message.common.delete.fail')
				}
				, async:true
		};
		uxl.callSubmitFunction('detailForm' , url , option );
}
</script>