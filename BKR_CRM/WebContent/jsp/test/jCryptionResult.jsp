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

		String encrypted = request.getParameter("jCryption");
		String username = null;
		String password = null;
		// decrypt
		if (encrypted != null && keys != null) {
			try {
				String data = JCryptionUtil.decrypt(encrypted, keys);
				request.getSession().removeAttribute(JCryptionUtil.SESSION_KEY);
				Map params = JCryptionUtil.parse(data, "UTF-8");
				username = (String) params.get("user");
				password = (String) params.get("password");
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
%>
posted user:<%=username%><br>
posted password:<%=password%><hr>
</body>
</html>
