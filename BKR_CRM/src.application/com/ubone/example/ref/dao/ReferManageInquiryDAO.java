package com.ubone.example.ref.dao;

import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : ReferManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 6. 3.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface ReferManageInquiryDAO {
	
	/**
	 * 자료실 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 자료실 목록 조회 결과
	 */
	public Result getRefList(Parameter parameter);
	
	/**
	 * 자료실 목록 상세.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 자료실 목록 상세조회 결과
	 */
	public Result getRefDetail(Parameter parameter);
}