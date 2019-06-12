package com.ubone.example.notice.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/** 
 * <pre>
 *  파 일 명 : NoticeManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 김범수
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface NoticeManageInquiryDAO {
	
	/**
	 * 공지사항 목록 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 목록 조회 결과
	 */
	public DataList getNoticeList(Parameter parameter);

	/**
	 * 공지사항 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	public Result getNoticeDetail(Parameter parameter);
	
	/**
	 * 공지사항 다음글 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	public Result getNoticeNextDetail(Parameter parameter);
	
	/**
	 * 공지사항 이전글 상세 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 공지사항 상세 조회 결과
	 */
	public Result getNoticePrevDetail(Parameter parameter);
	
	/**
	 * 로그인화면 공지사항 조회.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public DataList getNoticeListLogin(Parameter parameter);
	
	/**
	 * 엑셀데이터 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 
	 */
	public DataList getExcelList(Parameter parameter);
}
