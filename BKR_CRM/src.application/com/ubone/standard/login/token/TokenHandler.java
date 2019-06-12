package com.ubone.standard.login.token;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ubone.framework.engine.domain.UserContainer;
import com.ubone.framework.security.LoginTokenHandler;
import com.ubone.standard.login.service.LoginSO;

/** 
 * <pre>
 *  파 일 명 : TokenHandler.java
 *  설    명 : 유효 토큰에 대한 사용자 정보를 생성하는 핸들러 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2014.06.20
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 *  	1. 로그인 토큰 핸들러는 일반 로그인(id/pw) 방식이 아니며,
 *         유효한 Token 값이면 UserContainer를 생성하는 역할을 한다.
 *      2. 일반 로그인 절차를 거치지 않고, 로그인 로그도 생성하지 않는다.
 * </pre>
*/
public class TokenHandler implements LoginTokenHandler {

	@Resource
	private LoginSO loginSO;
	
	@Override
	public boolean isValid(HttpServletRequest request, HttpServletResponse response, String loginToken) {
		return loginSO.isValidToken(request, response, loginToken);
	}

	@Override
	public UserContainer doHandler(HttpServletRequest request, HttpServletResponse response, String loginToken) {
		return loginSO.getUserContainerByToken(request, response, loginToken);
	}
}
