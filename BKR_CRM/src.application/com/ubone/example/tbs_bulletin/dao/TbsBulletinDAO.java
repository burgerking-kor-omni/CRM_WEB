package com.ubone.example.tbs_bulletin.dao;

import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : TbsBulletinDAO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 9.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface TbsBulletinDAO {

	/**
	 * FAQ 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public String insertFaq(Parameter parameter);
	
	/**
	 * FAQ 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int updateFaq(Parameter parameter);
	
	/**
	 * FAQ 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int deleteFaq(Parameter parameter);

	/**
	 * 자료실 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public String insertRef(Parameter parameter);
	
	/**
	 * 자료실 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int updateRef(Parameter parameter);
	
	/**
	 * 자료실 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int deleteRef(Parameter parameter);
}