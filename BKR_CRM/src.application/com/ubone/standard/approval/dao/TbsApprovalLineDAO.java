package com.ubone.standard.approval.dao;

import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : TbsApprovalLineDAO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 11. 27
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface TbsApprovalLineDAO {
	
	/**
	 * 결재선 신규 등록
	 * @param parameter HTTP 요청 파라미터  
	 * @return business key
	 */
	public String insertApprovalLine(Parameter parameter);
	
	/**
	 * 결재선 상세 삭제
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int deleteApprovalLine(Parameter parameter);

	/**
	 * 결재선 수정
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int updateApprovalLine(Parameter parameter);

}
