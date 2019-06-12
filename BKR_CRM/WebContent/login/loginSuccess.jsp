<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.framework.util.hotlink.HotLink"%>
<%@page import="com.ubone.framework.util.UserUtil"%>
<%@page import="com.ubone.framework.engine.domain.User"%>
<%@page import="org.apache.commons.lang.StringUtils"%><%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	String url = "/screen/POR0001.ub";
	
	User user = UserUtil.getLoginUser();
	HotLink hotLink = (HotLink)user.getSsoInfo().get(ConstantHolder.KEY_PARAMETER_HOTLINK); 
	if(hotLink != null){
		if("SCREEN".equals(hotLink.getHotLinkType())){
			// 메뉴가 존재하는 포털화면으로 이동시 포털주소를 설정할 것
			response.sendRedirect(request.getContextPath() + "/screen/POR0001.ub");
		}else{
			// 핫링크에 존재하는 URL로 이동시
			user.getSsoInfo().remove(ConstantHolder.KEY_PARAMETER_HOTLINK);
			response.sendRedirect(request.getContextPath() + hotLink.getLinkUrl());
		}
	}else{
		response.sendRedirect(request.getContextPath() + url);
	}

	//response.sendRedirect(request.getContextPath() + "/screen/POR0002.ub");
%>