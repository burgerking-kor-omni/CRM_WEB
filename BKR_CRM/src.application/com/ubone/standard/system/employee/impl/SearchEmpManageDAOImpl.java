package com.ubone.standard.system.employee.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.employee.dao.SearchEmpManageDAO;

/** 
 * <pre>
 *  파 일 명 : SearchEmpManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 6.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class SearchEmpManageDAOImpl extends UbSqlSessionDaoSupport implements SearchEmpManageDAO{
	
	private String queryPrefix = "SearchEmpManageInquiry.";
	
	/* **
	 *  직원 검색(공통)
	 * @param parameter 
	 * @return 
	 */
	public DataList getEmpList(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getEmpList", parameter);
	}
	
	/* **
	 *  직원 검색(공통) - 부서선택시 사용자 리스트 호출
	 * @param parameter 
	 * @return 
	 */
	public DataList getUserList(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getUserList", parameter);
	}

	/* **
	 *  직원 검색(공통) - 부서선택시 사용자 리스트 호출(Lazy)
	 * @param parameter 
	 * @return 
	 */	
	public DataList getEmpListForLazy(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getEmpListForLazy", parameter);
	}
}
