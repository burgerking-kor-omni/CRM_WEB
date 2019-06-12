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
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	DataList _dl_detail = ViewUtil.getResult().getDataList("UserManageInquiry.getUserDetail");
%>

<%
	User user = UserUtil.getLoginUser();
	String userRole = user.getMaxRole();
	Boolean encryptPw = ConfigHolder.getBoolean("encrypt.password.enabled");
%>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0211R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/cryptojs/rollups/sha256.js'/>"></script>
<script type="text/javascript">
var strRole = [];
<%
	int cnt = _dl_detail.getRowCount();
	for(int i = 0; i < cnt; i++){
%>
	strRole[<%=i%>] = '<%=_dl_detail.getString(i, "ROLE_ID")%>';
<%	
	}
%>

uxl.onLoad(function(){
	
	uxl.bindComboCode('CD_ROLE', 'CD_ROLE', {parameter : {}, emptyOption:'선택안됨'});
	uxl.bindComboCode('INCUMBENT_CD', 'INCUMBENT_USER_CD', {parameter : {}, emptyOption:'선택안됨'});
	uxl.bindComboCode('CD_DUTY', 'CD_DUTY', {parameter : {}, emptyOption:'선택안됨'});
	
//	uxl.bindComboCode('CD_BRANCH', 'CD_BRANCH_REPORT', {parameter : {CD_BRANCH:'1999010110000000000'}, emptyOption:'선택안됨'});
//	uxl.chainCombo($('#CD_BRANCH'), $('#CD_TEAM'), 'CD_TEAM', {emptyOption:'전체'});
	
	//목록 이동	
	$('#btnList').click(function(){
		uxl.returnToList('SYS0021');
	});
	
	$('#saveBtn').click(function(){
		addAuthGroup();
	});
	
	$('#searchDept').click(function(){
		uxl.openWindow('Popup', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackRegDept);
	});	
	
	$('#updateBtn').click(function(){
		/* if(uxl.isEmpty($('#PASSWD').val())) {
			alert('패스워드를 입력해 주십시오.');
			$('#PASSWD').focus();
			return;
		} */
		
/* 		if(fnCheckPwd($('#PASSWD').val())){
			fnUpdateUseInfo();
		} */
		fnUpdateUseInfo();
	});
	
	
	// 지점VOC 관리자일경우 시스템관리자, VOC 총괄관리자 권한 제거
<%-- 	var userRole = "<%=userRole%>"; --%>
// 	if(userRole == 2){
// 		if($("#CD_ROLE").val() == 6 || $("#CD_ROLE").val() == 5){
// 			$("#CD_ROLE").attr('disabled',true);
// 			$('#CD_ROLE').addClass('readonly');
// 			return;
// 		}
// 		$("#CD_ROLE > option[value=5]").remove();
// 		$("#CD_ROLE > option[value=6]").remove();
// 	}
	var rcnt = strRole.length;
	for(var i = 0; i < rcnt; i++){
		$('select[name=CD_ROLE_LIST]').append($('select[name=CD_ROLE] option[value="'+strRole[i]+'"]'));
	}
		
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

//비밀번호 초기화
function fnResetPassword(){
	var pass = $('#LOGIN_ID').val();
	if(<%=encryptPw%>){
		pass = CryptoJS.SHA256(pass);
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			  data:{newPass:pass}
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

//조회
function fnUpdateUseInfo(){
	if(!confirm("수정하시겠습니까?")){
		return false;	
	}
	
	if($('#CD_ROLE_LIST option').length == 0){
		alert('사용자권한을 추가해주세요.');
		return;
	}else{
		$('#CD_ROLE_LIST option').attr('selected',true);
	}
	
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
				alert('수정이 완료되었습니다.');
				uxl.reload();
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
// 	uxl.callSubmitFunction('detailForm' , url , option );		
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

//사용자 신청 목록 조회
function fnAccountSearch(){
	//필수정보 체크
	var empNo = $("#EMP_NO").val();
	var data = {"LOGIN_ID":empNo};
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = { 
			data : $.extend(data, uxl.grid.getParam('list'))
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callFunction(url , option );		
}

function fnCheckPwd(pwd){
	if ( 7 < pwd.length &&  pwd.length < 10){ //8자리 이상
		var retVal = validationPwd_8(pwd);
		if(!retVal){
			alert('비밀번호는 영문 , 숫자, 특수문자 중 3가지를 조합해야합니다.');
		}
		return retVal;
	}else if(pwd.length > 9){  //10자리 이상
		var retVal = validationPwd_10(pwd);
		if(!retVal){
			alert('비밀번호는 영문 , 숫자, 특수문자 중 2가지를 조합해야합니다.');
		}
		return retVal;
	}else{
		alert('비밀번호는 최소 8자리 이상이어야 합니다.');
		return false;
	} 
}

function validationPwd_10(pwd){
	var regx =/^.*(?=.{10,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	return regx.test(pwd);
}

function validationPwd_8(pwd){
	var regx =/^.*(?=.{8,10})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]).*$/;
	return regx.test(pwd);
}

function callBackRegDept(deptData){
	$('#DEPT_NM').val(deptData.nmDept);
	$('#DEPT_ID').val(deptData.idDept);
}

function callBackAccount(){
	uxl.reload();
}


function fnAdd(){
	if($('select[name=CD_ROLE] option:selected').val() != ''){
		$('select[name=CD_ROLE_LIST]').append($('select[name=CD_ROLE] option:selected'));
	}
}
function fnDel(){
	if($('select[name=CD_ROLE_LIST] option:selected').length > 0){
		$('select[name=CD_ROLE]').append($('select[name=CD_ROLE_LIST] option:selected'));
	}
}

function fnChgPass(){
	uxl.openWindow('POR0002',uxl.getScreenURL('SYS0060')+"?USER_ID="+$('#LOGIN_ID').val(),{ width:500 ,height:250 });
}

</script>
