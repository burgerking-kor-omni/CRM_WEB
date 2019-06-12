<%--
 *
 *  설    명 :  로그인 페이지
 *  작 성 자 :  관리자
 *  작 성 일 :  2011-01-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
 * 
--%>
<%@page import="com.ubone.framework.type.ResultStatus"%>
<%@page import="java.util.Map"%>
<%@page import="com.ubone.framework.data.DataList"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.ubone.framework.web.util.HttpUtils"%>
<%@page import="com.ubone.framework.data.Parameter"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>
<%
	Boolean encryptPw = ConfigHolder.getBoolean("encrypt.password.enabled");
	String loginFlag = StringUtils.defaultString(request.getParameter("login_flag"), "");
	String errorMessage = "";
	if(ConfigHolder.APPLICATION_MODE.equals("dev")){
		if(ViewUtil.getResult() != null){
			if(ViewUtil.getResult().getServiceMessage().getResultStatus() == ResultStatus.Fail){
				errorMessage = ViewUtil.getResult().getServiceMessage().getMessage();
			}
		}
	}

	if("".equals(errorMessage)){
		if("fail".equals(loginFlag)){
			errorMessage = "사용자 정보가 일치하지 않습니다.\n확인후 다시 실행해 주십시요.";
		}else if("timeout".equals(loginFlag)){
			errorMessage = "세션이 만료되어 로그아웃 되었습니다.";
		}else if("accountLockTerminateRegist".equals(loginFlag)){
			errorMessage = "정지계정해지 신청중입니다.\n시스템관리자에게 문의하세요.";
		}else if("accountLockTerminateReject".equals(loginFlag)){
			errorMessage = "정지계정해지 반려되었습니다.\n시스템관리자에게 문의하세요.";
		}else if("accountNewRegist".equals(loginFlag)){
			errorMessage = "신규 계정 등록중입니다.\n시스템관리자에게 문의하세요.";
		}else if("accountNewReject".equals(loginFlag)){
			errorMessage = "신규 계정 등록이 반려되었습니다.\n시스템관리자에게 문의하세요.";
		}else if("duplicateLogin".equals(loginFlag)){
			errorMessage = "현재 사용자 계정이 사용중입니다.\n시스템관리자에게 문의하세요.";
		}else if("expirePassword".equals(loginFlag)){
			errorMessage = "패스워드가 만료되었습니다.\n시스템관리자에게 문의하세요.";
		}else if("holdedLoginId".equals(loginFlag)){
			errorMessage = "로그인 계정 중지 상태입니다.\n시스템관리자에게 문의하세요.";
		}else if("ipAccessDenied".equals(loginFlag)){
			errorMessage = "접근IP 제한입니다.\n시스템관리자에게 문의하세요.";
		}else if("lockedLoginId".equals(loginFlag)){
			errorMessage = "로그인 계정 잠김 상태입니다.\n시스템관리자에게 문의하세요.";
		}else if("maxFailPassword".equals(loginFlag)){
			errorMessage = "패스워드 실패 허용횟수 초과입니다.\n시스템관리자에게 문의하세요.";
		}else if("undefined".equals(loginFlag)){
			errorMessage = "사용자 신청이 필요한 로그인 계정입니다.\n시스템관리자에게 문의하세요.";
		}else if("periodNotExceedingOnline".equals(loginFlag)){
			errorMessage = "미접속기간 초과입니다.\n시스템관리자에게 문의하세요. ";
		}else if("retiree".equals(loginFlag)){
			errorMessage = "퇴사자 처리된 계정입니다.\n시스템관리자에게 문의하세요.";
		}
	}
	
	// Resign 에서는 sendRedirect 처리를 사용자에게 명시적으로 제한하고 있어서
	// 해당 코딩은 비정상적인 기능으로 동작한다.
//	if(!UserUtil.getLoginUser().equals(ConstantHolder.AUTH_ANONYMOUS_USER)){
//		response.sendRedirect(request.getContextPath() + "/screen/POR0007.ub");
//	}
%>
<script language="javascript" type="text/javascript">
	uxl.onLoadComplete(function() {
		var message = $('#errorMessage').text();
		if(uxl.isNotEmpty(message)){
  			uxl.error(message);
		}
		// 로그인 페이지시 최상위 Layer로 표출하는 기능
		if(top != window){
			top.location.href = location.href;
		}else{
			$('.ub-layout.login').show();
		}
	});
</script>
<div id="errorMessage" style="display:none;"><%=errorMessage %></div>
<div class="ub-layout login" style="display:none;">
	<div class="login-content">
		<div class="logo-area">
			<h1><img src="<spring:url value='/page/images/site/common/img_logo_login.png'/>" alt="BKR CRM" /></h1>
		</div>
		<div class="login-form">
			<form name="login" method="post" action="<spring:url value='/login.ub' />" target="_top">
				<fieldset>
					<legend>Login</legend>
					<div class="id-insert">
						<label for="userid"><ub:message code="label.BCO0001.id" text="아이디"/></label>
						<span class="login-inputtext">
							<input type="text" id="userid" name="userid" class="ub-control input-text" style="width:317px;" placeholder="아이디" autocomplete="off"/>	
						</span> 
					</div>
					<div class="pw-insert">
						<label for="userpw"><ub:message code="label.BCO0001.passwd" text="비밀번호"/></label>
						<span class="login-inputtext">
							<input type="password" id="userpw" name="userpw" class="ub-control input-text" style="width:317px;" placeholder="비밀번호" autocomplete="off"/>
						</span>
					</div>	
					<div class="login-btn" id="login" name="login"><span><a><img src="<spring:url value='/page/images/site/common/btn_login.gif'/>" alt="로그인" /></a></span></div>
					<div class="login-idcheck"><input type="checkbox" id="login-idSave" class="ub-control checkbox" /> <label for="login-idSave" class="save"><ub:message code="label.BCO0001.save.id" text="아이디저장"/></label></div>
				</fieldset>						
			</form>
			<form name="loginSubmit" method="post" action="<spring:url value='/login.ub' />" target="_top">
				<input type="hidden" id="<%=ConstantHolder.AUTH_KEY_USERNAME %>" name="<%=ConstantHolder.AUTH_KEY_USERNAME %>"/>
				<input type="hidden" id="<%=ConstantHolder.AUTH_KEY_PASSWORD %>" name="<%=ConstantHolder.AUTH_KEY_PASSWORD %>"/>
			</form>
		</div>		
<!-- 		<div class="login-foot"> -->
<!-- 			<p><copyright>Copyright (c) 2017 UB-One all rights reserved</copyright></p> -->
<!-- 		</div> -->
	</div>	
</div>
<script type="text/javascript" charset="UTF-8" src="<spring:url value='/uxl/ext/cryptojs/rollups/sha256.js'/>"></script>
<script type="text/javascript">
	// 문서 준비 핸들러
	uxl.onLoad(function() {
		var loginId = $.cookie('loginId');
		if(uxl.isNotNull(loginId)){
			$('#userid').val(loginId);
			$('#userpw').focus();
			$('#login-idSave').attr('checked', true);
		}else{
			$('#userid').focus();
		}
		
		$('#userid').keydown(function(event) {
			if(event.keyCode == '13') {
				$('#userpw').focus();
				return false;
			}
		});
		
		$('#userpw').keydown(function(event) {
			if(event.keyCode == '13') {
				login();
				return false;
			}
		});
		
		$('#login').click(function(event) {
			login();
			return false;
		});

		$('#login-idSave').click(function(event) {
			if($(this).attr('checked')){
				$.cookie('loginId', $('#userid').val());
			}else{
				$.cookie('loginId', null);
			}
		});
	});
	
	function login() {
		if(uxl.checkRequiredFields()) {
			if($('#login-idSave').attr('checked')){
				$.cookie('loginId', $('#userid').val(), {expires:7});
			}else{
				$.cookie('loginId', null);
			}
			if(<%=encryptPw%>){
				var encryptedPassword = CryptoJS.SHA256($('#userpw').val());
				$('#<%=ConstantHolder.AUTH_KEY_PASSWORD %>').val(encryptedPassword);
			}else{
				$('#<%=ConstantHolder.AUTH_KEY_PASSWORD %>').val($('#userpw').val());
			}
			
			var userId = $('#userid').val();
			$('#<%=ConstantHolder.AUTH_KEY_USERNAME%>').val(userId);
			
			document.forms['loginSubmit'].submit();
		}
		return false;
	}
</script>
