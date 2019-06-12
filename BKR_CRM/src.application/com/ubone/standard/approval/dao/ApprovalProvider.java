package com.ubone.standard.approval.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface ApprovalProvider {

	/**
	 * 결재선관리 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 검색 결과
	 */
	public DataList getApprovalLineList(Parameter parameter);

	/**
	 * 결재선관리 상세.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 상세 결과
	 */
	public DataList getApprovalLineDetail(Parameter parameter);
		
}
