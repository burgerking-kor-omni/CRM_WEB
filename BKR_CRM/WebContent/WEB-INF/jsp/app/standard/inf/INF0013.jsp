<%--
#*
 *  파 일 명 :  INF0013.jsp
 *  설    명 :  처리지침 상세
 *  작 성 자 :  이동엽
 *  작 성 일 :  2014-03-19
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

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
	if("Y" != hasRole){
		$('#update').hide();
		$('#delete').hide();
		$('#DS_TITLE').attr('disabled', true);
		$('#DT_START').attr('disabled', true);
		$('#DT_END').attr('disabled', true);
		$('#DS_CONTENT').attr('disabled', true);
		$('#NM_VOC_CAUSE').attr('disabled', true);
		$('#CD_VOC_CAUSE_1').attr('disabled', true);
		$('#CD_VOC_CAUSE_2').attr('disabled', true);
		$('#CD_VOC_CAUSE_3').attr('disabled', true);
		$('input[name=FG_OPEN_PORTAL]').attr('disabled', true);
		
		uxl.ext.Upload('file', {readOnly : true});
		
	}else{
		uxl.ext.Upload('file');
		
	}
	
	//Combo Ajax 처리
	uxl.bindComboCode('CD_VOC_PATTERN', 'CD_VOC_PATTERN', {parameter : {}, emptyOption:'전체'});
	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('INF0020');
	});
	
	//수정
	$('#update').click(function(){
		fnUpdate();
	});
	
	//삭제
	$('#delete').click(function(){
		fnDelete();
	});
	
	//uxl.Editor.setData("DS_CONTENT",$("#DS_CONTENT").val());
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_VOC_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
					data : {}
					, minLength : 2
					, itemExtractor : function(row) { 
													var item = {
																id : row.CODE
																, value : row.CODE_NAME
																, label : row.CODE_NAME
													};
						return item;
					}
	    			, select: function(event, ui) {
									    			var str = ui.item.id;
											    	$('#CD_VOC_CAUSE_1').val(str.substr(0,3));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_2').val(str.substr(0,6));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_3').val(str).change();
													}
	});
});


//수정
function fnUpdate(){

	//$('#DS_CONTENT').val(uxl.Editor.getData("DS_CONTENT"));
	
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
				uxl.moveLocation('INF0020');
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
				uxl.moveLocation('INF0020');
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