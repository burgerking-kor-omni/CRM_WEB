<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<HTML>
<HEAD>
    <TITLE>���� JSP �׽�Ʈ</TITLE>
</HEAD>
<BODY>
<h1>���� JSP �׽�Ʈ</h1>
<%
    Integer ival = (Integer)session.getAttribute("sessiontest.counter");
 
    if(ival==null) {
        ival = new Integer(1);
    }
    else {
        ival = new Integer(ival.intValue() + 1);
    }
    session.setAttribute("sessiontest.counter", ival);
    
    System.out.println(request.getRequestedSessionId());
%>
����� �̰��� <b> <%= ival %> </b>�� �湮 �߽��ϴ�.<p>
<p>
<h3>request ��ü�� ���õ� ���� ������</h3>
��û�� ���� ID : <%= request.getRequestedSessionId() %><br />
��Ű�� ���� ��û�� ���� ID �ΰ�? : <%= request.isRequestedSessionIdFromCookie() %><br />
URL�κ��� ��û�� ���� ID �ΰ�? : <%= request.isRequestedSessionIdFromURL() %><br />
��ȿ�� ���� ID �ΰ�? : <%= request.isRequestedSessionIdValid() %><br />

<h3>IP Information</h3>
* request.getRemoteAddr() : <%=request.getRemoteAddr() %><br />
<%
	String[] headerKeys = new String[]{"X-Forwarded-For",""};
	for(String key: headerKeys){
		out.println("* Http Request Header : ["+key+"] = "+request.getHeader(key)+"<br />");		
	}
%>


<h3>HTTP Request Header Information</h3>
<table border="1">
	<thead>
		<tr>
			<th width="100px;">Name</th>
			<th width="500px;">Value</th>
		</tr>
	</thead>
	<tbody>
		
<%
	//��� ��ü���� ����
	Enumeration<String> em = request.getHeaderNames();
	while(em.hasMoreElements()){
	    String name = em.nextElement() ;
	    String val = request.getHeader(name) ;
		out.println("<tr><td>"+name+"</td><td>"+val+"</td></tr>");
	}
%>
	</tbody>
</table>
</BODY>
</HTML>