<%--
#*
 *  파 일 명 :  SYS0060.jsp
 *  설    명 :  비밀번호 변경 
 *  작 성 자 :  안진철
 *  작 성 일 :  2013-07-26
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>
<%
	DataList _dataList = null;		/* List Table default dataTable */ 
	Boolean encryptPw = ConfigHolder.getBoolean("encrypt.password.enabled");
%>


<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : SYS0060R00
   - PAGE TYPE : JSP
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 


<!-- layout-1 Start -->
<h1 class="ub-control title">비밀번호 변경</h1>
<div class="ub-layout details"><form id="detailForm" name="detailForm"><table class="ub-control table normal ">
<colgroup>
<col width="45%"/>
<col />
</colgroup>
<tbody>
<tr id="layout-1_1">
<th id="layout-1_1_1"><label class="ub-control label"> 아이디</label></th>
<td id="layout-1_1_2"><input type=text  class="ub-control input-text " id="LOGIN_ID" name="LOGIN_ID"  value=""  readonly style="text-align:left;width:100px;"></td>
</tr>
<tr id="layout-1_2">
<th id="layout-1_2_3"><label class="ub-control label" for="PASSWD">현재 비밀번호</label></th>
<td id="layout-1_2_4"><input type=password  class="ub-control input-text " id="PASSWD" name="PASSWD" style="width:100px;"   value="" metaessential="1"></td>
</tr>
<tr id="layout-1_3">
<th id="layout-1_3_5"><label class="ub-control label" for="CHANGE_PASSWD"> 변경할 비밀번호</label></th>
<td id="layout-1_3_6"><input type=password  class="ub-control input-text " id="CHANGE_PASSWD" name="CHANGE_PASSWD" style="width:100px;"   value="" metaessential="1"></td>
</tr>
<tr id="layout-1_4">
<th id="layout-1_4_7"><label class="ub-control label" for="RECHECK_PASSWD">비밀번호 확인</label></th>
<td id="layout-1_4_8"><input type=password  class="ub-control input-text " id="RECHECK_PASSWD" name="RECHECK_PASSWD" style="width:100px;"   value="" metaessential="1"></td>
</tr>
</tbody>
</table>
 <input type=hidden id="USER_ID" name="USER_ID" value="${paramMap.USER_ID}">
 <input type=hidden id="FG_PASS" name="FG_PASS" value="">
</form>
</div>
<div class="ub-layout button bottom"><span class="ub-control button bottom icon" id="update">
    <a href="#none" title="Save"><span class="ico-save"></span>변경</a>
</span>
</div>

<!-- layout-1 End -->

<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/cryptojs/rollups/sha256.js'/>"></script>	
<script type="text/javascript">
uxl.onLoad(function(){
	
	if($('#USER_ID').val() != ''){
		$('#layout-1_2').hide();
		$('#PASSWD').attr('metaessential',0);
		$('#LOGIN_ID').val($('#USER_ID').val());
		$('#FG_PASS').val('N');
	}else{
		$('#LOGIN_ID').val('${user.loginId}');		
		
	}
	
	

	$('#close').click(function(){
		uxl.close();
	});
	
	//수정
	$('#update').click(function(event){
		if(!fnPassWordCheck()){
			return false;
		}
		fnUpdate();
	});
	
});

// 수정
function fnUpdate(){
	if(!confirm(uxl.getMessage("@message.common.change.passwd"))){
		return false;
	}
	var pass = $('#CHANGE_PASSWD').val();
	if(<%=encryptPw%>){
// 		$('#PASSWD').val(CryptoJS.SHA256($('#PASSWD').val()));
		$('#CHANGE_PASSWD, #RECHECK_PASSWD').val(CryptoJS.SHA256(pass));
	}
	pass = $('#PASSWD').val()
	if(pass.length > 0){
		$('#PASSWD').val(CryptoJS.SHA256(pass));
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
				var cntUser = result.getDataList(0).rowCount;
				if(cntUser == 0){
					if($('#USER_ID').val() != ''){
						uxl.showMessage(uxl.getMessage('message.common.validation.change', '비밀번호'));
						uxl.close();
					}else{
						uxl.showMessage(uxl.getMessage('message.common.validation.different', '현재 비밀번호'));
						$('#PASSWD, #CHANGE_PASSWD, #RECHECK_PASSWD').val('');
						$('#PASSWD').focus();
					}
				}else{
					uxl.showMessage(uxl.getMessage('message.common.validation.change', '비밀번호'));
					uxl.close();
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('detailForm' , url , option );
}

//비밀번호Validator
function fnPassWordCheck(){
	
// 	if(!uxl.isEmpty($('#CHANGE_PASSWD').val())){
// 		if(7 < $('#CHANGE_PASSWD').val().length && $('#CHANGE_PASSWD').val().length < 10){
// 			// 8자리 이상 10자리 이하
// 			returnb = validationPwd_8($('#CHANGE_PASSWD').val());
// 			if(!returnb){
// 				uxl.showMessage(uxl.getMessage('message.common.input.passwd.comp', '영문+숫자+기호', '3'));
// 				$('#CHANGE_PASSWD').focus();
// 				return false;
// 			}
// 		}else if($('#CHANGE_PASSWD').val().length > 9){
// 			//10자리 이상
// 			returnb = validationPwd_10($('#CHANGE_PASSWD').val());
// 			if(!returnb){
// 				uxl.showMessage(uxl.getMessage('message.common.input.passwd.comp', '영문+숫자+기호', '2'));
// 				$('#CHANGE_PASSWD').focus();
// 				return false;
// 			}
// 		}else{
// 			uxl.showMessage(uxl.getMessage('message.common.input.passwd.min', '8자리 이상'));
// 			$('#CHANGE_PASSWD').focus();
// 			return false;
// 		}
// 	}
// 	if(!uxl.isEmpty($('#RECHECK_PASSWD').val())){
// 		if($('#RECHECK_PASSWD').val().length < 6){
// 			uxl.showMessage(uxl.getMessage('message.common.validation.equal', '변경될 패스워드'));
// 			$('#RECHECK_PASSWD').focus();
// 			return false;
// 		}
// 	}
	if(uxl.isEmpty($('#PASSWD').val())){
		if(uxl.isEmpty($('#USER_ID').val())){
			alert('이전 비밀번호를 입력해주세요.');
			$('#PASSWD').focus();
			return false;
		}
	}else{
		if($('#PASSWD').val() == $('#CHANGE_PASSWD').val()){
			uxl.showMessage(uxl.getMessage('message.common.validation.overlap','현재 패스워드'));
		    $('#CHANGE_PASSWD').focus();
			return false;
		}
	}
	if(uxl.isEmpty($('#CHANGE_PASSWD').val())){
		alert('변경할 비밀번호를 입력해주세요.');
		$('#CHANGE_PASSWD').focus();
		return false;
	}
	if(uxl.isEmpty($('#RECHECK_PASSWD').val())){
		alert('비밀번호 확인을 입력해주세요.');
		$('#RECHECK_PASSWD').focus();
		return false;
	}else{
		if($('#CHANGE_PASSWD').val() != $('#RECHECK_PASSWD').val()){
		   uxl.showMessage(uxl.getMessage('message.common.validation.equal', '변경될 패스워드'));
		   $('#RECHECK_PASSWD').focus();
			return false;
		}
	}
	return true;
}
	
function validationPwd_10(pwd){
	var regx =/^.*(?=.{10,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	return regx.test(pwd);
}

function validationPwd_8(pwd){
	var regx =/^.*(?=.{8,10})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]).*$/;
	return regx.test(pwd);
}	
</script>	