package com.ubone.standard.login.domain;

import java.io.Serializable;
import java.util.Map;

import org.codehaus.jettison.json.JSONObject;

/**
 * <pre>
 *  파 일 명 : LoginResult.java
 *  설    명 : 로그인 결과 도메인 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2014.01.06
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public class LoginResult implements Serializable{
	private static final long serialVersionUID = 7335631035205082087L;
	
	private String loginId;							// 로그인ID
	private String loginIP;							// 로그인IP

	private LoginResultType loginResultType;		// 로그인 결과
	
	/**
	 * 사용자정보를 맵에 생성
	 */
	private JSONObject userData;	

	public JSONObject getUserData() {
		return userData;
	}
	
	public void setUserData(JSONObject userData) {
		this.userData = userData;
	}

	
	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}

	public LoginResultType getLoginResultType() {
		return loginResultType;
	}

	public void setLoginResultType(LoginResultType loginResultType) {
		this.loginResultType = loginResultType;
	}
}
