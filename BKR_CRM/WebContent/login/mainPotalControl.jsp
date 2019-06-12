<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.ubone.framework.ConfigHolder"%>


<%
     if(ConfigHolder.getBoolean("bottom.layout.tabs.enabled")){
    	 response.sendRedirect(request.getContextPath() + "/screen/POR0002.ub");
     }else{
    	 response.sendRedirect(request.getContextPath() + "/screen/POR0007.ub");
     }
%>