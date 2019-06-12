package com.ubone.example.ref.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.ref.dao.ReferManageInquiryDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : ReferManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 6. 3.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class ReferManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements ReferManageInquiryDAO{
	
	private String queryPrefix = "ReferManageInquiry.";
	
	public Result getRefList(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getRefList", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}
	public Result getRefDetail(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getRefDetail", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}
}

