<%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@page import="org.apache.commons.lang.StringUtils"%>
<script type="text/javascript">
<%
	String flag = StringUtils.defaultString(request.getParameter("flag"), "");
	String url="/screen/BCO0001.ub?login_flag="+flag;

	response.sendRedirect(request.getContextPath() + url);
%>

</script>