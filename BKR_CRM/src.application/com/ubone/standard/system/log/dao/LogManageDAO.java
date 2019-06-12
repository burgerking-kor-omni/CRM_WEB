package com.ubone.standard.system.log.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : LogManageDAO.java
 *  설    명 : 시스템관리 > 로그관리 DAO
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface LogManageDAO {
	
	/**
	 * 사용자접속로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	DataList getUserAccessLogList(Parameter parameter);
	
	/**
	 * 프로그램사용로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	DataList getProgramUseLogList(Parameter parameter);
	
	/**
	 * 권한변경로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	DataList getRoleChangeLogList(Parameter parameter);
	
	/**
	 * 로그관리 사용자 검색 AutoComplate
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	DataList getUserNameByAuto(Parameter parameter);
	
	/**
	 * 로그관리 배치 로그 검색
	 * @param parameter
	 * @return
	 */
	DataList getBatchLogList(Parameter parameter);
	/**
	 * 통보이력 목록 조회
	 * @param parameter
	 * @return
	 */
	DataList getListDispatch(Parameter parameter);
	
	/**
	 * 고객정보 조회로그 목록 조회
	 * @param param 
	 * @return
	 */
	public DataList getPrivacyList (Parameter param);
	
	/**
	 * 고객정보 조회로그 등록
	 * @param param
	 */
	public void insertPrivacyLog(Parameter param);
}
