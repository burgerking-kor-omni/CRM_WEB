<%@page import="com.ubone.framework.engine.domain.UserContainer"%>
<%@page import="com.ubone.framework.util.hotlink.HotLink"%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	UserContainer userContainer = (UserContainer)session.getAttribute(ConstantHolder.KEY_USER);
	if(userContainer != null){
		User user = userContainer.getUser();
		HotLink hotLink = (HotLink)user.getSsoInfo().get(ConstantHolder.KEY_PARAMETER_HOTLINK); 
		if(hotLink != null){
			if("SCREEN".equals(hotLink.getHotLinkType())){
				response.sendRedirect(request.getContextPath() + "/screen/POR0002.ub");
			}else{
				response.sendRedirect(request.getContextPath() + hotLink.getLinkUrl());
			}
		}else{
			response.sendRedirect(request.getContextPath() + "/screen/POR0001.ub");
		}
	}
%>