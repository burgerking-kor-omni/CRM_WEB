<%--
#*
 *  파 일 명 :  INF0005.jsp
 *  설    명 :  FAQ 상세
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-05-11
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	// 버튼권한 - 시스템관리자, 민원관리자, 고객의소리(voc)관리자
// 	if(user.hasRole(VocConstantHolder.ROLE_ID_ADMIN)  || user.hasRole(VocConstantHolder.ROLE_VOC_ADMIN) || user.hasRole(VocConstantHolder.ROLE_CC_ADMIN))
	{
		hasRole = "Y";
	}
%>
	
<script type="text/javascript">
uxl.onLoad(function(){
	
	// 버튼권한
	var hasRole = "<%=hasRole%>";
	// 관리자아닐 경우
// 	if("N" == hasRole){
// 		//수정, 삭제 버튼 숨김
// 		$('#update').hide();
// 		$('#delete').hide();
// 		//비활성화
// 		$('#TP_CATEGORY').attr('disabled', true);
// 		$('#DS_TITLE').attr('readonly', true);
// 		$('#DS_CONTENT').attr('readonly', true);
// 		//첨부파일 열람만 가능
// 		uxl.ext.Upload('file',{readOnly : true});
// 	}else{
// 		uxl.ext.Upload('file');
// 	}
	
	$('#CD_CATEGORY_1').append('<option value="01">로그인오류</option>');
	$('#CD_CATEGORY_1').append('<option value="02">화면오류</option>');
	$('#CD_CATEGORY_1').change();
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('INF0004');
	});
	
	//수정
	$('#update').click(function(){
		fnUpdate();
	});
	
	//삭제
	$('#delete').click(function(){
		fnDelete();
	});
	
	
});

//수정-
function fnUpdate(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail : uxl.getMessage('@message.common.update.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

//삭제
function fnDelete(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
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
				 confirm : uxl.getMessage('@message.common.delete.confirm'),
				 success : uxl.getMessage('@message.common.delete.success'),
				 fail : uxl.getMessage('@message.common.delete.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

</script>	