package com.ubone.standard.system.log.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.log.dao.LogManageDAO;


/** 
 * <pre>
 *  파 일 명 : LogManageSO.java
 *  설    명 : 시스템관리 > 로그관리 Service
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Service
public class LogManageSO {
	
	@Resource
	private LogManageDAO logManageDAO;

	/**
	 * 사용자접속로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getUserAccessLogList(Parameter parameter){
		return logManageDAO.getUserAccessLogList(parameter);
	}
	
	/**
	 * 프로그램사용로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getProgramUseLogList(Parameter parameter){
		return logManageDAO.getProgramUseLogList(parameter);
	}
	
	/**
	 * 권한변경로그관리 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getRoleChangeLogList(Parameter parameter){
		return logManageDAO.getRoleChangeLogList(parameter);
	}
	
	/**
	 * 로그관리 사용자 검색 AutoComplate
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	public DataList getUserNameByAuto(Parameter parameter){
		return logManageDAO.getUserNameByAuto(parameter);
	}

	public DataList getBatchLogList(Parameter parameter){
		return logManageDAO.getBatchLogList(parameter);
	}
	
	/**
	 * 통보이력 목록 조회
	 * @param parameter 파라미터 클래스
	 * @return 목록 DataList
	 */
	
	public DataList getListDispatch(Parameter parameter){
		return logManageDAO.getListDispatch(parameter);
	}
	
	/**
	 * 고객정보 조회로그 목록 조회
	 * @param param 
	 * @return
	 */
	public DataList getPrivacyList (Parameter param){
		return logManageDAO.getPrivacyList(param);
	}
}
