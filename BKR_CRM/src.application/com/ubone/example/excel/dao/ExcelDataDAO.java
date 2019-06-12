package com.ubone.example.excel.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : ExcelDataDAO.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2017. 11. 16.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface ExcelDataDAO {
	
	/**
	 * 
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public DataList getExcel(Parameter parameter);
	/**
	 * 대용량데이터
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public DataList getLargeCapacityExcel(Parameter parameter);
	/**
	 * 대용량데이터 (petch 활용 시 )
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public DataList getLargeCapacityExcel_petch(Parameter parameter);
	
}