package com.ubone.standard.login.domain;

import java.io.Serializable;

/** 
 * <pre>
 *  파 일 명 : SsoData.java
 *  설    명 : SSO 정보를 저장하는 Domain 객체
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.11.04
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 *    1. 아래의 항목은 SSO의 일반적인 항목만 표현됨.
 *       사이트의 SSO 정보에 맞게 도메인 클래스를 변경하세요.
 * </pre>
 */
public class SsoData implements Serializable{

	private static final long serialVersionUID = -4456896120911414145L;
	
	/**
	 * 로그인 ID
	 */
	private String loginId;
	
	/**
	 * 이름
	 */
	private String name;
	
	/**
	 * 부서코드
	 */
	private String deptCd;
	
	/**
	 * 부서명
	 */
	private String deptNm;

	/**
	 * @return the loginId
	 */
	public String getLoginId() {
		return loginId;
	}

	/**
	 * @param loginId the loginId to set
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the deptCd
	 */
	public String getDeptCd() {
		return deptCd;
	}

	/**
	 * @param deptCd the deptCd to set
	 */
	public void setDeptCd(String deptCd) {
		this.deptCd = deptCd;
	}

	/**
	 * @return the deptNm
	 */
	public String getDeptNm() {
		return deptNm;
	}

	/**
	 * @param deptNm the deptNm to set
	 */
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	
	
}
