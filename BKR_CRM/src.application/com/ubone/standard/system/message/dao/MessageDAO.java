package com.ubone.standard.system.message.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.WorkCategory;
import com.ubone.framework.engine.WorkflowActivity;


/** 
 * <pre>
 *  설    명 : 메세지 정보 DAO
 *  작 성 자 : 임경철
 *  작 성 일 : 2010.09.01
 *  버    전 : 1.0
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface MessageDAO {
	
	/**
	 * 메세지 정보 등록
	 * @param parameter
	 * @return key
	 * @throws DataAccessException
	 */
	String insert(Parameter parameter);
	
	/**
	 * 메세지 수신자 정보 등록
	 * @param parameter
	 * @throws DataAccessException
	 */
	void insertTarget(Parameter parameter);
	
	/**
	 * @param workCategory
	 * @param workflowActivity
	 * @return
	 */
	DataList findRuleBy(WorkCategory workCategory, WorkflowActivity workflowActivity);

	/**
	 * 메세지 Rule 관리 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 메세지 Rule 관리 조회 결과
	 */
	public DataList getRuleList(Parameter parameter);	
}
