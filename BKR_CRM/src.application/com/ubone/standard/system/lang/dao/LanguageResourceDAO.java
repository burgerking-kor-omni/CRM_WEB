package com.ubone.standard.system.lang.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : LanguageResourceDAO.java
 *  설    명 : 다국어 리소스 DAO
 *  작 성 자 : 이창섭
 *  작 성 일 : 2016. 09. 23.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2016 by ㈜ 유비원. All right reserved.
 */
public interface LanguageResourceDAO {

	/**
	 * 다국어 리소스 등록 - SYS_RESOURCE
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public String insertSysResource(Parameter parameter);
	
	/**
	 * 다국어 리소스 등록/수정 - SYS_RESOURCE_DTL
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public String insertSysResourceDtl(Parameter parameter);
	
	/**
	 * 다국어 리소스 수정 - SYS_RESOURCE
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int updateSysResource(Parameter parameter);
	
	/**
	 * 다국어 리소스 수정/삭제 - SYS_RESOURCE_DTL 삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int deleteSysResourceDtl(Parameter parameter);
	
	/**
	 * 다국어 리소스 삭제 - SYS_RESOURCE 삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public int deleteSysResource(Parameter parameter);
	
	/**
	 * 다국어 리소스 상세 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 다국어 리소스 상세 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-23
	 */
	public DataList getLanguageResourceDetail(Parameter parameter);
	
	/**
	 * 다국어 리소스 목록 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-09-28
	 */
	public DataList getLanguageResourceList(Parameter parameter);
	
	/**
	 * 공통코드용 다국어 리소스 ID 조회
	 * @param parameter HTTP 요청 파라미터 
	 * @return 조회 결과 DataList
	 * @writer 이창섭
	 * @date 2016-10-05
	 */
	public DataList getResIdByCode(Parameter parameter);
	
}
