<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	String errorMessage = ""; 
	Exception exception = (Exception)request.getAttribute("exception");
	if(exception != null){
		errorMessage = exception.getMessage();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href='../../page/css/style.css' />
</head>
<body>
	<p class="accessTxt"><em>요청페이지의 접근권한이 없습니다.</em> <br />시스템 관리자에게 문의하십시오.</p>
</body>
</html>