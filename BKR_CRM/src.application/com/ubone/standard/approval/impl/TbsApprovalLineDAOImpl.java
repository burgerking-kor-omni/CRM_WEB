package com.ubone.standard.approval.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.approval.dao.TbsApprovalLineDAO;

/** 
 * <pre>
 *  파 일 명 : TbsAddressDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 11. 27
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class TbsApprovalLineDAOImpl extends UbSqlSessionDaoSupport implements TbsApprovalLineDAO{

	private String queryPrefix = "TbsApprovalLine.";
	
	public String insertApprovalLine(Parameter parameter) {
		return insert(this.queryPrefix + "insertApprovalLine", parameter);
	}

	public int deleteApprovalLine(Parameter parameter) {
		return delete(this.queryPrefix + "deleteApprovalLine", parameter);
	}

	public int updateApprovalLine(Parameter parameter) {
		return update(this.queryPrefix + "updateApprovalLine", parameter);
		
	}

}
