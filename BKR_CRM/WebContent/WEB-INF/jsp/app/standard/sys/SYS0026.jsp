<%--
#*
 *  파 일 명 :  SYS0026.jsp
 *  설    명 :  사용자관리 목록 상세
 *  작 성 자 :  이동엽
 *  작 성 일 :  2013-06-03
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
	//목록 이동	
	$('#list').click(function(){
		uxl.returnToList('SYS0021');
	});
	
	//권한추가
	$('#addAuthGroup').click(function(event) {
		uxl.openWindow('Popup', uxl.getScreenURL('SYS0058'), { width:'747px' ,height:'605px' }, callBackAdd);		
	});
	
	//권한삭제
	$('#removeAuthGroup').click(function(event) {
		$('option:checked' , $('#AUTH_LIST')).remove();
	});
	
	
	$('#saveBtn').click(function(){
		addAuthGroup();
	});
	
	selectAuthList();
	
	//비밀번호 초기화
	$('#pw_reset').click(function(event){
		fnUpdate();
	});
});

//검색 callBack
function callBackAdd(authData) {
	
	if($('option' , $('#AUTH_LIST')).text().indexOf(authData.idUser) > 0){  //이미등록되어있는 사원
		alert("이미등록되어있는 권한");
	}else{
		var text = authData.compNm+"/"+authData.roleNm+"/"+authData.channelNm;
		$('#AUTH_LIST').addOption(text, authData.compId+"|"+authData.roleId+"|"+authData.channelId);
	}
}

//조회
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
				
			}
			, async:true

	};
	uxl.callSubmitFunction('detailForm' , url , option );
	
}

//비밀번호 초기화
function fnUpdate(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
					return true;
			}
			, success:function(result){
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.reset.confirm','비밀번호'),
				 success : uxl.getMessage('@message.common.reset.success','비밀번호'),
				 fail : uxl.getMessage('@message.common.reset.fail','비밀번호')
			  }
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

//저장
function addAuthGroup(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
				
				$('#AUTH_LIST > option').attr('selected', 'selected');//권한그룹목록

					return true;
			}
			, success:function(result){
				
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


//권한그룹 목록 조회
function selectAuthList(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  success:function(result){
					var dataSet = result.getDataList(0).rows;
					var rowCount = result.getDataList(0).rowCount;
					var i=0;
					for( i ; i < rowCount ;  i++){
						var text = dataSet[i]['NM_COMP']+"/"+dataSet[i]['ROLE_NM']+"/"+dataSet[i]['NM_CHN'];
						$('#AUTH_LIST').addOption(text, dataSet[i]['GRP_MAP_ID_1']+"|"+dataSet[i]['ROLE_ID']+"|"+dataSet[i]['GRP_MAP_ID_2']);
					}
			}
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}


</script>
