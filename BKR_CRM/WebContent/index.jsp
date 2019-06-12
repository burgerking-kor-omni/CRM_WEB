<%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	Boolean sslFlag = ConfigHolder.getBoolean("sslEnabled");
	String svPt = Integer.toString(request.getServerPort());
	String svNm = request.getServerName();
	
	String url = ConfigHolder.APPLICATION_MODE.equals("real") ? "https://"+svNm:"http://"+svNm;
	
	url+=(sslFlag?"":":"+svPt);
	
	url+=request.getContextPath()+"/screen/BCO0001.ub";
	response.sendRedirect(url);
%>
