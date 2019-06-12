<%--
#*
 *  파 일 명 : INF0015.jsp
 *  설    명 : 베스트 워스트 상세
 *  작 성 자 :  
 *  작 성 일 :  2015-03-20
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
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
	
 	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});  
	
	var hasRole = "<%=hasRole%>";
	
	//관리자가 아닐 경우
	if("N" == hasRole){
		//수정,삭제 숨김 & 비활성화
		$('#delete').hide();
		$('#modify').hide();
		$('#TP_CASE').attr('disabled',true);
		$('#DS_TITLE').attr('readonly',true);
		$('#DS_CONT').attr('readonly',true);
		$('#DS_REPLY').attr('readonly',true);
		$('#DS_ACT').attr('readonly',true);
	}
	
 
	
	//disabled 처리 ie8버전...
	$('#CD_VOC_PATTERN_1').attr('disabled',true);
	$('#CD_VOC_PATTERN_2').attr('disabled',true);
	$('#TP_CHNN_SYSTEM').attr('disabled',true);
	$('#TP_CHNN_PATH').attr('disabled',true);
	$('#CD_VOC_CAUSE_1').attr('disabled',true);
	$('#CD_VOC_CAUSE_2').attr('disabled',true);
	$('#CD_VOC_CAUSE_3').attr('disabled',true);
	
	
	//목록버튼 클릭
	$('#list').click(function(){
		uxl.returnToList('INF0010');
	});
	
	$('#modify').click(function(){
		fnUpdate();
	});
	
	$('#delete').click(function(){
		fnDelete();
	});
	
	
});//end of onLoad

//수정
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
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.reload();
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail 	 : uxl.getMessage('@message.common.update.fail')
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
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.returnToList('INF0010');
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
