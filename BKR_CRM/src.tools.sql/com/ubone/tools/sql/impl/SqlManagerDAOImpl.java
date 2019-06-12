package com.ubone.tools.sql.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.tools.sql.dao.SqlManagerDAO;

/** 
 * <pre>
 *  파 일 명 : SqlManagerDAOImpl.java
 *  설    명 : SQL 관리자의 DAO 인터페이스 구현체
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.12.14.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class SqlManagerDAOImpl extends UbSqlSessionDaoSupport implements SqlManagerDAO{
	
	private String queryPrefix = "SqlManager.";

	@Override
	public DataList selectQuery(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "selectQuery", parameter);
	}

	@Override
	public int updateQuery(Parameter parameter) {
		return update(this.queryPrefix + "updateQuery", parameter);
	}
     
} 