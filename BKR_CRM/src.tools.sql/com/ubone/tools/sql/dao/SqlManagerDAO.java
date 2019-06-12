package com.ubone.tools.sql.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : SqlManagerDAO.java
 *  설    명 : SQL 관리자의 DAO 인터페이스
 *  작 성 자 : 강영운
 *  작 성 일 : 2015.12.14
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface SqlManagerDAO {
	public DataList selectQuery(Parameter parameter);
	public int updateQuery(Parameter parameter);
}
