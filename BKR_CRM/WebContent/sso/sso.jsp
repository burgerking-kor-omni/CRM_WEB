<%@page import="com.ubone.standard.login.domain.SsoData"%>
<%@page import="com.ubone.framework.ConfigHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" isErrorPage="true"%>
<%
	/**
	 * SSO에서의 데이터의 유효성에 대한 메세지나, 
	 * 기타 다른 관련 페이지들의 연계 처리는 sso.jsp 에서 구현한다.
	 */

	// 1.로컬 모드인 경우는 일반 로그인 창으로 이동
	if(!"local".equalsIgnoreCase(ConfigHolder.APPLICATION_MODE)){
		response.sendRedirect(request.getContextPath()+"/screen/BCO0001.ub");
		return;
	}
%>
	out.println("로컬 SSO 샘플 페이지 입니다. admin 계정으로 로그인됩니다.");
<%
	// 2.SSO의 데이터를 파싱 처리한다.
	// SSO는 고객사에서 제공되는 가이드에 따라 각각 별도 적용한다.
	// 
	// 추출된 SSO의 ID에 따른 정보를 세션에 추가한다.
	//
	String loginUserId = "admin";
	String name = "관리자";
	String deptCd = "001001001";
	String deptNm = "총무부";
	
	// 3.내부 SSO 데이터 객체 생성
	SsoData ssoData = new SsoData();
	ssoData.setLoginId(loginUserId);
	ssoData.setName(name);
	ssoData.setDeptCd(deptCd);
	ssoData.setDeptNm(deptNm);
	
	// 4.세션에 SSO 데이터를 저장
	session.setAttribute("SSO_DATA", ssoData);
	
	// 5.sso 모듈 호출 URL로 리턴한다.
	response.sendRedirect("/sso.ub");
%>