package com.ubone.example.notice.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.notice.dao.NoticeManageInquiryDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : NoticeManageInquiryDAOImpl.java
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
public class NoticeManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements NoticeManageInquiryDAO{
	
	private String queryPrefix = "NoticeManageInquiry.";
	
	public DataList getNoticeList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getNoticeList", parameter);
	}

	public Result getNoticeDetail(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getNoticeDetail", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}

	public Result getNoticeNextDetail(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getNoticeNextDetail", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}

	public Result getNoticePrevDetail(Parameter parameter) {
		Result result = DataUtil.makeResult();
		result.addDataList(queryForDataList(this.queryPrefix + "getNoticePrevDetail", parameter));
		result.addDataList(queryForDataList(this.queryPrefix + "getLoginProgramAccessList", parameter));
		return result;
	}

	public DataList getNoticeListLogin(Parameter parameter) {
		return queryForDataList(this.queryPrefix+ "getNoticeListLogin", parameter);
	}

	@Override
	public DataList getExcelList(Parameter parameter) {
		return queryForDataList(this.queryPrefix+ "getExcelList", parameter);
	}
}
