package com.ubone.standard.ubboard.common.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.ubboard.board.notice.dao.NoticeBoardDAO;
import com.ubone.standard.ubboard.common.dao.BoardCommonDAO;

/** 
 * <pre>
 *  파 일 명 : BoardCommonDAOImpl.java
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
public class BoardCommonDAOImpl extends UbSqlSessionDaoSupport implements BoardCommonDAO{

	private String queryPrefix = "BoardCommonDAO.";

	@Override
	public DataList getBoardUserInfo(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getBoardUserInfo", parameter);
	}

	
	
}
