<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
	String loginStatusCd = (String)request.getAttribute("loginStatusCd");
	if(loginStatusCd != null){
		loginStatusCd = "("+loginStatusCd+")";
	}else{
		loginStatusCd = "";
	}
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href='../../page/css/style.css' />
</head>
<body>

<div class="ub-page error">
	<div class="ub-layout errorHead">
		<p class="comment1">로그인 실패</p>
		<p class="comment2"></p>
	</div>

	<div class="ub-layout errorCon" style="width:70%;margin:0 auto;">
		<div class="errorCon-float">
			<strong>에러 메세지 : </strong>&nbsp;<span>현재 로그인 계정은 신규 계정 등록이 반려되어 로그인이 불가능합니다. 관리자에게 문의하시기 바랍니다.</span>
		</div>
	</div>
	
	<div style="width:50%;margin:0 auto;text-align:center;margin-top:50px;">
		<a href='<spring:url value="/logout.ub"/>'>로그인 이동</a>
	</div>
</div>
</body>
</html>