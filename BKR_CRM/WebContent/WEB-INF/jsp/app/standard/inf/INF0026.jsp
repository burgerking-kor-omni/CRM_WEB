<%--
#*
 *  파 일 명 :  INF0023.jsp
 *  설    명 :  사전예보 등록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-03-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,org.w3c.dom.*" %>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
	
<script type="text/javascript">
uxl.onLoad(function(){
	
	//첨부파일 업로드
	uxl.ext.pdfUpload('file');
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('INF0024');
	});
	
	//저장
	$('#save').click(function(){
		fnSave();
	});
	
	//첨부파일 필수조건 표시
	$('#layout-1_4_7').append("<span class='required'>*</span>");
	
	//$('#uploadedFiles_file').attr('metaessential','1');
});


//저장
function fnSave() {
	
	//첨부파일 필수처리
	var attrCount = 0;
	$('div',$('#uploadedFiles_file')).each(function() {
		if('block' == $(this).css('display')){
			attrCount++;
		}
	});
	if(0 == attrCount){
		uxl.showMessage('[첨부파일*] 은(는) 필수 항목입니다.');
		return;
	}
	
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
				uxl.returnToList('INF0024');
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.confirm','등록'),
				 success : uxl.getMessage('@message.common.success','등록'),
				 fail : uxl.getMessage('@message.common.fail','등록')
			  }
			
	};
	uxl.callSubmitFunction('registForm' , url , option );
}
</script>	