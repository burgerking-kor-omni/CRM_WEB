<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<HTML>
<HEAD>
    <TITLE>세션 JSP 테스트</TITLE>
</HEAD>
<BODY>
<h1>세션 JSP 테스트</h1>
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
당신은 이곳을 <b> <%= ival %> </b>번 방문 했습니다.<p>
<p>
<h3>request 객체와 관련된 세션 데이터</h3>
요청된 세션 ID : <%= request.getRequestedSessionId() %><br />
쿠키로 부터 요청된 세션 ID 인가? : <%= request.isRequestedSessionIdFromCookie() %><br />
URL로부터 요청된 세션 ID 인가? : <%= request.isRequestedSessionIdFromURL() %><br />
유효한 세션 ID 인가? : <%= request.isRequestedSessionIdValid() %><br />

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
	//헤더 전체정보 보기
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