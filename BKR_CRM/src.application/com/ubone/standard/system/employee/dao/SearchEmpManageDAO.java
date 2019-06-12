package com.ubone.standard.system.employee.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : SearchEmpManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 6.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface SearchEmpManageDAO {
	
	/**
	 * 직원 목록(공통) 검색.
	 * @param parameter 
	 * @return 
	 */
	public DataList getEmpList(Parameter parameter);
	
	/**
	 * 직원 목록(공통) 검색(lazy용)
	 * @param parameter 
	 * @return 
	 */
	public DataList getEmpListForLazy(Parameter parameter);
	
	/**
	 *  직원 검색(공통) - 부서선택시 사용자 리스트 호출
	 * @param parameter 
	 * @return 
	 */
	public DataList getUserList(Parameter parameter);
	
}
