package com.ubone.standard.system.camel.dao;

import com.ubone.framework.data.DataList;

/** 
 * <pre>
 *  파 일 명 : CamelColumnsDAO.java
 *  설    명 : Camel 구문을 생성하는 DAO
 *  작 성 자 : 강영운
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface CamelColumnsDAO {
	
	/**
	 * 컴럼가지고 오기 테스트
	 * @param tableName
	 * @return
	 */
	public DataList listColumns(String tableName);
	public DataList listAutocompleate(String tableName);
}
