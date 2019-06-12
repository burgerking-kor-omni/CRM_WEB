<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" isErrorPage="true"%>
<%
	if(exception != null){
		exception.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href='../../page/css/style.css' />
</head>
<body>

<div class="ub-page error">
	<div class="ub-layout errorHead">
		<p class="comment1"><em>시스템 오류</em>가 발생하였습니다.</p>
		<p class="comment2">시스템 관리자에게 문의하십시요.</p>
	</div>
</div>
</body>
</html>