package com.ubone.example.excel.impl;

import org.springframework.stereotype.Repository;

import com.ubone.example.excel.dao.ExcelDataDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : ExcelDataDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2017. 11. 16.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class ExcelDataDAOImpl extends UbSqlSessionDaoSupport implements ExcelDataDAO{

	private String queryPrefix = "ExcelData.";

	@Override
	public DataList getExcel(Parameter parameter) {
		return queryForDataList(this.queryPrefix+ "getExcel", parameter);
	}

	@Override
	public DataList getLargeCapacityExcel(Parameter parameter) {
		return queryForDataList(this.queryPrefix+ "getLargeCapacityExcel", parameter);
	}
	
	@Override
	public DataList getLargeCapacityExcel_petch(Parameter parameter) {
		return queryForDataList(this.queryPrefix+ "getLargeCapacityExcelPetch", parameter);
	}
}
