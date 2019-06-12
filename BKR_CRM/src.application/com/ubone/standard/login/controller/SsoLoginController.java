package com.ubone.standard.login.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubone.framework.ConstantHolder;
import com.ubone.framework.util.hotlink.HotLink;
import com.ubone.standard.login.service.LoginSO;

/**
 * <pre>
 *  파 일 명 : SsoLoginController.java
 *  설    명 : SSO 로그인 컨트롤러
 *  작 성 자 : 유기태
 *  작 성 일 : 2015.04.16
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
@Controller
public class SsoLoginController {
	private static String LOGIN_URL  		= "/screen/BCO0001.ub";
	private static String SSO_SUCCESS_PAGE 	= "/login/ssoSuccess.jsp";
	
	@Resource
	private LoginSO loginSO;
	
	@RequestMapping("/ssoLogin.ub")
	public void ssoLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		String contextPath = request.getContextPath();
		
		//핫링크정보 생성
		HotLink hotLink = loginSO.getHotLink(request);
		
		//현재 세션에 SSO 정보 저장
		HttpSession session =  request.getSession();
		session.setAttribute(ConstantHolder.KEY_PARAMETER_HOTLINK, hotLink);
		
		// 세션유효체크
		if(request.getSession().getAttribute(ConstantHolder.KEY_USER) != null){
			loginSO.setHotLink(request.getSession(), hotLink);

			//SSO Success 페이지로 이동
			response.sendRedirect(contextPath + SSO_SUCCESS_PAGE);
		}else{
			//로그인 페이지로 이동
			response.sendRedirect(contextPath + LOGIN_URL);
		}	
	}
}
