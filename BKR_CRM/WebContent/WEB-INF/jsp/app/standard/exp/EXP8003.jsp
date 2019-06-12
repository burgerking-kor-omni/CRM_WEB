<%--
#*
 *  파 일 명 :  INF0003.jsp
 *  설    명 :  공지사항 등록
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-05-19
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
	
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('EXP8001');
	});
	
	//저장
	$('#save').click(function(){		
		fnSave();
	});
	
	
	uxl.ext.Upload('file');
	
	/*
   	uxl.Editor('DS_NOTICE' , {
		height:'250px'   // CSS unit.
	});
	*/
   	
});

//등록
function fnSave() {
	
	//$('#DS_NOTICE').val(uxl.Editor.getData("DS_NOTICE"));
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					var returnVal = false;
					//필수항목체크
					if(uxl.checkRequiredFields(targetForm)){
						if($('#DT_START').val()>$('#DT_END').val()){
							uxl.showMessage(uxl.getMessage('message.common.validation.date', "공지기간 마지막일","공지기간 시작일"));
						}else{
							returnVal = true;
						}
					}
					
					return returnVal;
			}
			, success:function(result){
				uxl.moveLocation('EXP8001');
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

