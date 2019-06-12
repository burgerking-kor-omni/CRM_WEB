package com.ubone.standard.system.lang.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.message.MessageService;
import com.ubone.standard.system.lang.dao.LanguageResourceDAO;

/** 
 * <pre>
 *  파 일 명 : LanguageResourceDAOImpl.java
 *  설    명 : 다국어 리소스 DAO Impl
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 23.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
@Repository
public class LanguageResourceDAOImpl extends UbSqlSessionDaoSupport implements LanguageResourceDAO{
	
	@Resource
	private MessageService messageService;
	
	private String queryPrefix = "LanguageResource.";

	/**
	 * 다국어 리소스 등록 - SYS_RESOURCE
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public String insertSysResource(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return insert(this.queryPrefix + "insertSysResource", parameter);
	}
	
	/**
	 * 다국어 리소스 등록/수정 - SYS_RESOURCE_DTL
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public String insertSysResourceDtl(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return insert(this.queryPrefix + "insertSysResourceDtl", parameter);
	}
	
	/**
	 * 다국어 리소스 수정 - SYS_RESOURCE
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int updateSysResource(Parameter parameter) {
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return update(this.queryPrefix + "updateSysResource", parameter);
	}
	
	/**
	 * 다국어 리소스 수정/삭제 - SYS_RESOURCE_DTL 삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int deleteSysResourceDtl(Parameter parameter) {
		return delete(this.queryPrefix + "deleteSysResourceDtl", parameter);
	}
	
	/**
	 * 다국어 리소스 삭제 - SYS_RESOURCE 삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int deleteSysResource(Parameter parameter) {
		return delete(this.queryPrefix + "deleteSysResource", parameter);
	}
	
	/**
	 * 다국어 리소스 상세 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 다국어 리소스 상세 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public DataList getLanguageResourceDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getLanguageResourceDetail", parameter);
	}
	
	/**
	 * 다국어 리소스 목록 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-28
	 */
	public DataList getLanguageResourceList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getLanguageResourceList", parameter);
	}
	
	/**
	 * 공통코드용 다국어 리소스 ID 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-10-05
	 */
	public DataList getResIdByCode(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getResIdByCode", parameter);
	}
}
