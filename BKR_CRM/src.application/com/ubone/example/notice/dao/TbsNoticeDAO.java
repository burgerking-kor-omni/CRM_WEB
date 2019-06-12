package com.ubone.example.notice.dao;

import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : TbsNoticeDAO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 9.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface TbsNoticeDAO {

	/**
	 * 공지사항 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public String insertNotice(Parameter parameter);
	
	/**
	 * 공지사항 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int updateNotice(Parameter parameter);
	
	/**
	 * 공지사항 삭제.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int deleteNotice(Parameter parameter);
	
}