package com.ubone.example.faq.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.faq.dao.FaqManageInquiryDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : FaqManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class FaqManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements FaqManageInquiryDAO{
	
	private String queryPrefix = "FaqManageInquiry.";
	
	public Result getFaqList(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getFaqList", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}
	
	public Result getFaqDetail(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getFaqDetail", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}

	public DataList getFaqCategoryTreeList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getFaqCategoryTreeList", parameter);
	}



}
