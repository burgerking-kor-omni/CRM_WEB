<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="com.ubone.framework.data.Result"%>
<%@ page import="java.util.Enumeration"%>

<%
	String returnCode = request.getParameter("error_code");
//	returnCode = "250";
%>


<html>
<head>
<TITLE>chart</TITLE>

<script language="javascript" src="<%=request.getContextPath()%>/uxl/ext/flex/AC_OETags.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
	var returnCode = "<%=returnCode%>";
	
	parent.dispReturnFunc(returnCode);
-->
</script>
</body>
</html>
