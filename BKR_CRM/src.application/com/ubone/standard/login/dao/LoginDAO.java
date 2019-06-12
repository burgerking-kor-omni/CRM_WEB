package com.ubone.standard.login.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.framework.engine.domain.UserContainer;

/** 
 * <pre>
 *  파 일 명 : LoginDAO.java
 *  설    명 : 사용자 처리 관련 업무 처리 인터페이스
 *  작 성 자 : Administrator
 *  작 성 일 : 2013.12.09
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public interface LoginDAO {
	
	/**
	 * 로그인 상태를 변경하는 함수
	 * @param parameter 로그인 가능여부, 로그인상태코드
	 */
	public int updateLoginStatus(Parameter parameter);
	
	/**
	 * 로그인 이후 변경될 로그인 정보를 수정하는 함수
	 * @param parameter 파라미터 
	 */
	public int updateLoginInfo(Parameter parameter);
	
	/**
	 * 로그인 성공 이후 로그인 정보 처리 함수
	 * @param parameter
	 * @return
	 */
	public int updateLoginInfoForSuccess(UserContainer userContainer);
	
	/**
	 * 로그인시 사용할 사용자의 권한 정보를 조회한다.
	 * @param builder UserBuilder 인스턴스
	 * @return 사용자 권한 정보
	 */
	public DataList getListUserRole(UserBuilder builder);


	/**
	 * 로그인시 사용할 로그인 정보를 조회한다.
	 * @param loginId 로그인ID
	 * @return 사용자 정보
	 */
	public DataList getLoginInfo(String loginId);

	/**
	 * Token Filter에서 유효토큰에 대한 사용자 정보를 조회하는 함수
	 * @param loginToken 로그인 토큰정보
	 * @param loginIp 로그인Ip
	 * @return 사용자 정보
	 */
	public DataList getLoginInfoByLoginToken(String loginToken, String loginIp);
	
	/**
	 * 사용자의 정보를 조회한다.
	 * @param userId 사용자ID
	 * @return 저장 건수
	 */
	public int updatePersonInfo(Parameter parameter);
	
	/**
	 * 로그인정보를 등록한다.
	 * @param parameter
	 * @return
	 */
	public String insertLoginInfo(Parameter parameter);

	/**
	 * 패스워드 불일치 카운트 추가
	 * @param parameter
	 */
	public int updaePwdFailCount(Parameter parameter);
	
	/**
	 * 사용자 권한을 등록 한다.
	 * @param parameter
	 * @return
	 */
	public String insertApRoleCompostion(Parameter parameter);
	
	public int updateSysLogin(Parameter parameter);
	
	public int updateApRoleCompstion(Parameter parameter);
	
	public int deleteApRoleCompstion(Parameter parameter);
}