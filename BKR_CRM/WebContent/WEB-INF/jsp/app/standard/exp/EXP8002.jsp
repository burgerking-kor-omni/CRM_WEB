<%--
#*
 *  파 일 명 :  INF0002.jsp
 *  설    명 :  공지사항 상세
 *  작 성 자 :  김범수
 *  작 성 일 :  2013-05-11
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

%>

<script type="text/javascript">
uxl.onLoad(function(){

	uxl.ext.Upload('file');

	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('EXP8001');
	});
	
	//수정
	$('#update').click(function(){
		fnUpdate();
	});
	
	//삭제
	$('#delete').click(function(){
		fnDelete();
	});
	
	//다음글
	$('#next').click(function(){
		
		fnNext();
	});
	
	//이전글
	$('#prev').click(function(){
		fnPrev();
	});
	
	//uxl.Editor.setData("DS_NOTICE",$("#DS_NOTICE").val());
});

//수정
function fnUpdate(){

	//$('#DS_NOTICE').val(uxl.Editor.getData("DS_NOTICE"));
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.moveLocation('EXP8001');
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
				uxl.moveLocation('EXP8001');
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

function fnNext() {
	//필수정보 체크
		
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
				var data = result.getDataList("NoticeManageInquiry.getNoticeNextDetail");
				if(data.rowCount > 0){
					uxl.moveLocation(uxl.getScreenURL('EXP8002')+ '?ID_NOTICE='+data.rows[0].ID_NOTICE + '&DS_TITLE_H='+$('#DS_TITLE_H').val() + '&DT_REG_START_H='+$('#DT_REG_START_H').val() + '&DT_REG_END_H='+$('#DT_REG_END_H').val());	
				}else{
					alert('다음글이 존재하지 않습니다.');
				}
				
				
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );	
}

function fnPrev() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED2');
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
				var data = result.getDataList("NoticeManageInquiry.getNoticePrevDetail");
				if(data.rowCount > 0){
					uxl.moveLocation(uxl.getScreenURL('EXP8002')+ '?ID_NOTICE='+data.rows[0].ID_NOTICE + '&DS_TITLE_H='+$('#DS_TITLE_H').val() + '&DT_REG_START_H='+$('#DT_REG_START_H').val() + '&DT_REG_END_H='+$('#DT_REG_END_H').val());
				}else{
					alert('이전글이 존재하지 않습니다.');					
				}
				
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );	
}
</script>	

<!-- <script language="JScript" FOR="EDITOR_DS_NOTICE" EVENT="OnControlInit()">
	//var form = document.writeForm;
	document.EDITOR_DS_NOTICE.HtmlValue = $('#DS_NOTICE').val();
	
	//해당글을 등록한 직원이 아니면 에디터 수정불가.
	if($('#ID_REG_EMP').val() != '${user.id}'){
		document.EDITOR_DS_NOTICE.EditMode  = 0;
		document.EDITOR_DS_NOTICE.ActiveTab = 3;
	}
</script> -->