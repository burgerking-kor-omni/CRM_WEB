<%--
#*
 *  파 일 명 :  INF0009.jsp
 *  설    명 :  자료실 등록
 *  작 성 자 :  안진철
 *  작 성 일 :  2013-06-04
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
	
<script type="text/javascript">
uxl.onLoad(function(){
	
	$('#DS_CONTENT').attr('maxlength',1000);
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('INF0007');
	});
	
	//저장
	$('#save').click(function(){		
		fnSave();
	});
	
	//첨부파일 업로드
	uxl.ext.Upload('file');

});

//저장
function fnSave() {

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
				uxl.moveLocation('INF0007');
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