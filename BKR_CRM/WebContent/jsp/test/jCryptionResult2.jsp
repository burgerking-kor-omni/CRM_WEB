<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Map"%>
<%@page import="com.ubone.framework.security.jcryption.utils.JCryptionUtil"%>
<%@page import="java.security.KeyPair"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Login form</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<body>
<%
	KeyPair keys = (KeyPair) request.getSession().getAttribute(JCryptionUtil.SESSION_KEY);

	String username = request.getParameter("username");
	String password = request.getParameter("password");;
	
		// decrypt
		if (keys != null) {
			try {
				username = JCryptionUtil.decrypt(URLDecoder.decode(username, "UTF-8"), keys);
				password = JCryptionUtil.decrypt(password, keys);
				
//				Map params = JCryptionUtil.parse(data, "UTF-8");
				
//				username = (String) params.get("user");
//				password = (String) params.get("password");
				
				request.getSession().removeAttribute(JCryptionUtil.SESSION_KEY);
				
				System.out.println("username="+username);
				System.out.println("password="+password);
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
%>
posted user:<%=username%><br>
posted password:<%=password%><hr>
</body>
</html>
