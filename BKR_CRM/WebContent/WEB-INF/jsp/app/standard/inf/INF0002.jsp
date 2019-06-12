<%--
#*
 *  파 일 명 :  INF0002.jsp
 *  설    명 :  공지사항 상세
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-08-05
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.standard.common.constant.AuthConstantHolder"%>

<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	//관리자 권한(시스템관리자, 전체관리자, 고객서비스 팀장, VOC관리자)
	if(user.hasRole(AuthConstantHolder.ROLE_SYSTEM_ADMIN) || user.hasRole(AuthConstantHolder.ROLE_NORMAL_ADMIN) 
		|| user.hasRole(AuthConstantHolder.ROLE_VOC_ADMIN)){
		hasRole = "Y";
	}
%>
<script type="text/javascript">
uxl.onLoad(function(){
	
	
	// 버튼권한
	var hasRole = "<%=hasRole%>";
	if("Y" == hasRole){ //관리자일 경우
		
		//첨부파일 업&다운로드 가능
		uxl.ext.Upload('file');
		$('input, textarea').dblclick(function(){
			$(this).val('');
		});
		
	}else{ //관리자가 아닐 경우
		
		//( 첨부파일 업로드 / 수정/ 삭제 )버튼 숨김 & 비활성화
		$('#update').hide();
		$('#delete').hide();
		$('#DS_TITLE').attr('readonly', true);
		$('#DT_START').attr('readonly', true);
		$('#DT_END').attr('readonly', true);
		$('#DS_NOTICE').attr('readonly', true);
		$('input[name=FG_OPEN_PORTAL]').attr('readonly', true);
		$('#DT_START').attr('class', 'ub-control input-text calendar hasDatepicker readonly');
		$('#DT_END').attr('class', 'ub-control input-text calendar hasDatepicker readonly');
		$('#FG_OPEN_PORTAL').attr('disabled',true);
		$('#FG_POPUP').attr('disabled',true);
		$('#FG_OPEN_HGST').attr('disabled',true);
		uxl.ext.Upload('file', {readOnly : true});
	}
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('INF0001');
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
	
	// 게시여부
	$('#FG_OPEN').click(function(){
		if($(this).prop("checked")){
			$('#DT_START, #DT_END').attr('metaessential',1);
			$('label[for="DT_START,DT_END"]').append('<span class="required">*</span>');
			$('#FG_OPEN_PORTAL').val('Y');
		}else{
			$('#DT_START, #DT_END').attr('metaessential',0);
			$('label[for="DT_START,DT_END"] span').remove();
			$('#FG_OPEN_PORTAL').val('N');
		}
	});
	if($('#FG_OPEN_PORTAL').val()=='Y'){
		$('#FG_OPEN').attr('checked',true);
		$('#DT_START, #DT_END').attr('metaessential',1);
		$('label[for="DT_START,DT_END"]').append('<span class="required">*</span>');
	}else{
		$('#DT_START, #DT_END').attr('metaessential',0);
		$('label[for="DT_START,DT_END"] span').remove();
	}
	
	$('#DS_NOTICE').attr('maxlength',1000);
	$('a[class="file_link"]').attr('onclick','');
});

//수정
function fnUpdate(){
	
	var dtStart = new Date($('#DT_START').val());
	var dtEnd = new Date($('#DT_END').val());
	var fgOpenPortal = 'N';
	if(dtStart > dtEnd){
		alert('공지기간이 유효하지 않습니다.');
		return;
	}
	
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
			, success:function(result){
				uxl.returnToList('INF0001');
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
		  , success:function(result){
			  var data = result.getDataList("NoticeManageInquiry.getNoticeNextDetail");
			  if(data.rowCount > 0){
				  uxl.moveLocation(uxl.getScreenURL('INF0002')+ '?ID_NOTICE='+data.rows[0].ID_NOTICE + '&DS_TITLE_H='+$('#DS_TITLE_H').val() + '&DT_REG_START_H='+$('#DT_REG_START_H').val() + '&DT_REG_END_H='+$('#DT_REG_END_H').val());
			  }else{
				  uxl.showMessage('다음글이 존재하지 않습니다.');
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
			, success:function(result){
				var data = result.getDataList("NoticeManageInquiry.getNoticePrevDetail");
				if(data.rowCount > 0){
					uxl.moveLocation(uxl.getScreenURL('INF0002')+ '?ID_NOTICE='+data.rows[0].ID_NOTICE + '&DS_TITLE_H='+$('#DS_TITLE_H').val() + '&DT_REG_START_H='+$('#DT_REG_START_H').val() + '&DT_REG_END_H='+$('#DT_REG_END_H').val());
				}else{
					uxl.showMessage('이전글이 존재하지 않습니다.');					
				}
				
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );	
}

//팝업 기간 설정 콜백
function callBackDate(date){
	
	$('#DT_START_POPUP').val(date.startDate);				
	$('#DT_END_POPUP').val(date.endDate);
	
}

</script>	