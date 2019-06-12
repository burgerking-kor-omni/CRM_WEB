package com.ubone.standard.approval.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.approval.dao.TbsApprovalLineDtlDAO;

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
public class TbsApprovalLineDtlDAOImpl extends UbSqlSessionDaoSupport implements TbsApprovalLineDtlDAO{

	private String queryPrefix = "TbsApprovalLineDtl.";
	
	public String insertApprovalLineDtl(Parameter parameter) {
		return insert(this.queryPrefix + "insertApprovalLineDtl", parameter);
	}

	public int deleteApprovalLineDtl(Parameter parameter) {
		return delete(this.queryPrefix + "deleteApprovalLineDtl", parameter);
	}
}
