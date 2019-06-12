package com.ubone.standard.system.log.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.log.dao.LogManageDAO;

/** 
 * <pre>
 *  파 일 명 : MaskManageDAOImpl.java
 *  설    명 : 시스템관리 > 로그관리 DAO Impl
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class LogManageDAOImpl extends UbSqlSessionDaoSupport implements LogManageDAO{

	private static final String QUERYPREFIX = "LogManage.";

	@Override
	public DataList getUserAccessLogList(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getUserAccessLogList", parameter);
	}

	@Override
	public DataList getProgramUseLogList(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getProgramUseLogList", parameter);
	}

	@Override
	public DataList getRoleChangeLogList(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getRoleChangeLogList", parameter);
	}

	@Override
	public DataList getUserNameByAuto(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getUserNameByAuto", parameter);
	}

	@Override
	public DataList getBatchLogList(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getBatchLogList", parameter);
	}

	@Override
	public DataList getListDispatch(Parameter parameter) {
		return queryForDataList(this.QUERYPREFIX + "getListDispatch", parameter);
	}
	
	@Override
	public DataList getPrivacyList(Parameter param) {
		return queryForDataList(this.QUERYPREFIX+"getPrivacyList", param);
	}
	
	@Override
	public void insertPrivacyLog(Parameter param) {
		insert(this.QUERYPREFIX+"insertPrivacyLog", param);
	}
}
