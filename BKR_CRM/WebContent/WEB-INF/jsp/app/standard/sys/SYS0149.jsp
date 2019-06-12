<%--
#*
 *  파 일 명 :  SYS0149.jsp
 *  설    명 :  사용자관리 등록
 *  작 성 자 :  강현준
 *  작 성 일 :  2019-01-11
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
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
	DataList _dl_CD_DUTY = ViewUtil.getResult().getDataList("Code.CD_DUTY");
	DataList _dl_INCUMBENT_USER_CD = ViewUtil.getResult().getDataList("Code.INCUMBENT_USER_CD");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0149R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 

<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/cryptojs/rollups/sha256.js'/>"></script>
<script type="text/javascript">
uxl.onLoad(function(){
	
	$('input[type="text"]').val('');
	
	uxl.bindComboCode('CD_ROLE', 'CD_ROLE', {parameter : {}, emptyOption:'선택안됨'});
	uxl.bindComboCode('INCUMBENT_CD', 'INCUMBENT_USER_CD', {parameter : {}, emptyOption:'선택안됨'});
	uxl.bindComboCode('CD_DUTY', 'CD_DUTY', {parameter : {}, emptyOption:'선택안됨'});
	
	// 전화번호 숫자만
	$('#MOBILE_NO').keyup(function(event){
		uxl.setInputMask($(this), "cellPhone");
	});
	
	$('#btnRegist').click(function(){
// 		if(fnCheckPwd($('#PASSWD').val())){
			fnRegist();
// 		}
	});
	
	$('#btnList').click(function(){
		uxl.returnToList('SYS0021');
	});
	
	//부서검색팝업화면호출
	$('#deptPop').click(function(event) {
		uxl.openWindow('Popup', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackRegDept);
	});
	
	
	/**
	  계정ID 중복체크
	*/
	$('#checkBtn').click(function(){
		fnCheck();
	});
	
	$('#searchDept').click(function(){
		uxl.openWindow('Popup', uxl.getScreenURL('POP0002'), { width:'425px' ,height:'578px' }, callBackRegDept);
	});
	
	
	$('#LOGIN_ID').keyup(function(){
		$('#dupAlertMsg').text('');
	});
	
	$('#dupAlertMsg').addClass('txt-color01');
	
	$('input').dblclick(function(e){
		$(this).val('');
		if(this.id == 'DEPT_NM'){
			$('#DEPT_ID').val('');
		}
	})
	
});

function fnRegist(){
	
	if($('input[name=btnfgrecv]:checked').val() == 'Y'){
		$('#FG_RECV').val('Y');
	}else{
		$('#FG_RECV').val('N');
	}
	
	if($('#CD_ROLE_LIST option').length == 0){
		alert('사용자권한을 추가해주세요.');
		return;
	}else{
		$('#CD_ROLE_LIST option').attr('selected',true);	
	}
	
	var url = uxl.getFunctionUrl('SYS0148', 'REGIST');
	var option = {
		data:{}
	  , validator:function(data,targetForm) {
			var returnVal = false;
			//필수항목체크
			if(uxl.checkRequiredFields(targetForm)) {
				returnVal = true;
			}
			return returnVal;
		}
	  , success:function(result) {
		  	//var userId = result.getResultKey();
		  	uxl.returnToList('SYS0021');
		}
	  , async:true
	  , message : {
		  confirm : uxl.getMessage('@message.common.confirm','저장'),
		  success : uxl.getMessage('@message.common.success','저장'),
		  fail : uxl.getMessage('@message.common.fail','저장')
		}
	  
	};
	uxl.callSubmitFunction('detailForm', url, option);
	
}

function fnCheck(){
	var url = uxl.getFunctionUrl('SYS0148','CHECK');
	var option = {
			  data: {}
			, validator:function(data,targetForm){
					var returnVal = false;
					if($('#LOGIN_ID').val().length > 0){
						returnVal = true;
					}else{
						$('#LOGIN_ID').focus();
					}
					return returnVal;
			}
			, success:function(result){
				var duplicationCnt = result.getDataList(0).rows[0].DUP_CNT;
				if( duplicationCnt > 0 ){
					$('#dupAlertMsg').text('이미 사용중인 계정입니다.');
				}else{
					$('#dupAlertMsg').text('사용가능한 계정입니다.');
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}


function fnCheckPwd(pwd){
	var returnb = false;
	if ( 7 < pwd.length &&  pwd.length < 10){ //8자리 이상
		returnb = validationPwd_8(pwd);
		if(!returnb){
			alert('비밀번호는 영문+숫자+기호 중 3가지 이상으로 구성되어야 합니다. ');
		}
		return returnb;
	}else if(pwd.length > 9){  //10자리 이상
		returnb = validationPwd_10(pwd);
		if(!returnb){
			alert('비밀번호는 영문+숫자+기호 중 2가지 이상으로 구성되어야 합니다. ');
		}
		return returnb;
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
</script>