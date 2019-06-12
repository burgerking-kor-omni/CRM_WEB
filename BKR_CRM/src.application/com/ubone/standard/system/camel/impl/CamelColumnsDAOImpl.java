package com.ubone.standard.system.camel.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.standard.system.camel.dao.CamelColumnsDAO;

/** 
 * <pre>
 *  파 일 명 : CamelColumnsDao.java
 *  설    명 : Camel 구문을 생성하는 DAO
 *  작 성 자 : 강영운
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class CamelColumnsDAOImpl extends UbSqlSessionDaoSupport implements CamelColumnsDAO{
	
	private final String prefix_id = CamelColumnsDAOImpl.class.getName()+".";
	
	
	public DataList listColumns(String tableName){
		return queryForDataList(prefix_id+"listColumns", tableName);
	}
	public DataList listAutocompleate(String tableName){
		return queryForDataList(prefix_id+"listAutocompleate",tableName);
	}
}
