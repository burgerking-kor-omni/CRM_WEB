package com.ubone.standard.alimy.dao;

import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : AlimyLoginDAO.java
 *  설    명 : 알리미 로그인 관련 DAO 인터페이스 클래스
 *  작 성 자 : 강영운
 *  작 성 일 : 2016.04.22
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */
public interface AlimyLoginDAO {
	
	/**
	 * 알리미 로그인 정보 생성함수
	 * @param parameter
	 * @return
	 */
	public void saveAlimyLoginInfo(Parameter parameter);
}