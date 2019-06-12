<%--
#*
 *  파 일 명 :  INF0006.jsp
 *  설    명 :  FAQ 등록
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-05-19
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
	
	//첨부파일
// 	uxl.ext.Upload('file');
	
	uxl.bindComboCode('CD_CATEGORY_1', 'CD_CATEGORY_1', {emptyOption:'선택안됨'});
// 	uxl.chainCombo( $('CD_CATEGORY_1'), $('CD_CATEGORY_2'), 'CD_CATEGORY_2', {parameter:{PARENT_CODE:$('#CD_CATEGORY_1').val()}} );
// 	uxl.chainCombo( $('CD_CATEGORY_2'), $('CD_CATEGORY_3'), 'CD_CATEGORY_3', {parameter:{PARENT_CODE:$('#CD_CATEGORY_2').val()}} );

	$('#CD_CATEGORY_1').append("<option value='01'>로그인오류</option>");
	$('#CD_CATEGORY_1').append("<option value='02'>화면오류</option>");
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('INF0004');
	});
	
	//등록(저장)
	$('#save').click(function(){		
		fnSave();
	});

});

//저장-

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
				uxl.returnToList('INF0004');
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