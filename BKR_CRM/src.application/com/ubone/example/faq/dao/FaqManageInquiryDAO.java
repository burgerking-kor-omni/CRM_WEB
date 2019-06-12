package com.ubone.example.faq.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : FaqManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface FaqManageInquiryDAO {

	/**
	 * FAQ목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return FAQ목록 조회 결과
	 */
	public Result getFaqList(Parameter parameter);

	/**
	 * FAQ상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return FAQ상세 조회 결과
	 */
	public Result getFaqDetail(Parameter parameter);
	
	
}
