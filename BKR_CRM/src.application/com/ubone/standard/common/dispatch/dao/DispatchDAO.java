package com.ubone.standard.common.dispatch.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface DispatchDAO {

	/**
	 * VOC 통보대상자 조회 - 직원
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public DataList getDispatchEmpTarget(Parameter parameter);
	
	/**
	 * 유형별 통보대상자 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public DataList getVocDispatch(Parameter parameter);
	
	/**
	 * 통보실행이력 저장
	 * @param param
	 * @return count 
	 */
	public String insertDispatchRun(Parameter parameter);
	
	/**
	 * 통보실행대상 저장
	 * @param param
	 * @return count 
	 */
	public String insertDispatchRunTarget(Parameter parameter);
	
}
