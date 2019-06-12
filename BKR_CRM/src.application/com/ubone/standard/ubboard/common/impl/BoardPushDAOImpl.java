package com.ubone.standard.ubboard.common.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ubboard.common.dao.BoardPushDAO;

/** 
 * <pre>
 *  파 일 명 : BoardPushDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class BoardPushDAOImpl extends UbSqlSessionDaoSupport implements BoardPushDAO{

	private String queryPrefix = "BoardPushDAO.";

	@Override
	public DataList getPushTarget(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getPushTarget", parameter);
	}

	@Override
	public DataList getMessageInfo(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMessageInfo", parameter);
	}

	@Override
	public DataList getArticleRegistUserId(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getArticleRegistUserId", parameter);
	}

	
	
}
