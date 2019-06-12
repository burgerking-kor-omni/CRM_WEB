package com.ubone.example.pivotgrid.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.pivotgrid.dao.PivotGridExampleDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

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
public class PivotGridExampleDAOImpl extends UbSqlSessionDaoSupport implements PivotGridExampleDAO{
	
	private String queryPrefix = "PivotGridExample.";

	@Override
	public DataList getGridData(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getGridData", parameter);
	}

	@Override
	public DataList getGridDataAll(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getGridDataAll", parameter);
	}
	
	
}
