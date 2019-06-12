package com.ubone.standard.approval.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


/** 
 * <pre>
 *  파 일 명 : ApprovalInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 유기태, 최소정
 *  작 성 일 : 2013. 11.29
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface ApprovalInquiryDAO {
	
	// 유기태 담당 영역////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 나의상신목록 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신목록 조회 결과
	 */
	public DataList getMyApprovalList(Parameter parameter);
	
	/**
	 * 나의상신상세 결재경로 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신상세 결재경로 조회 결과
	 */
	public DataList getMyApprovalDetailLine(Parameter parameter);
	
	/**
	 * 나의상신상세 결재내용 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신상세 결재내용 조회 결과
	 */
	public DataList getMyApprovalDetailContent(Parameter parameter);
	
	/**
	 * 결재상신등록 창 호출시 기본데이터 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재상신등록 창 호출시 기본데이터 결과
	 */
	public DataList getApprovalSubmitData(Parameter parameter);
	
	/**
	 * 다음결재자 정보를 가져옴
	 * @param parameter HTTP 요청 파라미터  
	 * @return 다음결재자 정보를 가져옴 결과
	 */
	public DataList getNextAppEmpId(Parameter parameter);
	
	/**
	 * 결재상신 등록
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재상신등록 결과
	 */
	public String insertApproval(Parameter parameter);
	
	/**
	 * 결재라인 등록
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재라인 등록 결과
	 */
	public String insertApprovalLine(Parameter parameter);
	
	/**
	 * 결재라인기안 설정
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재라인기안 설정 결과
	 */
	public int setApprovalLine(Parameter parameter);
	
	/**
	 * 결재라인 첫 결재자 설정
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재라인 첫 결재자 설정 결과
	 */
	public int setApprovalFirstLine(Parameter parameter);
	
	/**
	 * 기안취소
	 * @param parameter HTTP 요청 파라미터  
	 * @return 기안취소 결과
	 */
	public int cancleApproval(Parameter parameter);
	
	/**
	 * 나의 결재 목록 조회
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 목록 조회 결과
	 */
	public DataList getMyApproveListData(Parameter parameter);     

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재경로 Grid Control
	 */
	public DataList getMyApproveLineListData(Parameter parameter);    		
		
	/**
	 * 결재자 결재진행..
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 화면
	 */
	public DataList getMyApproveDetail(Parameter parameter);    	
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 총 결재자 수(기안자 포함) 카운트
	 */
	public DataList countAPPR(Parameter parameter);         
	//public int countAPPR2(Parameter parameter);       //합의자 수 카운트
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (결재자가 남았을 때 update (1))
	 */
	public int updateInfoNextApproval(Parameter parameter);            
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (마지막 결재자일때 update (1))
	 */
	public int updateInfoWhenLastApproval(Parameter parameter);           
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (공통 update (2))
	 */
	public int updateInfoApprovalItMust(Parameter parameter);          
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (결재자가 남았을 때 update (1))
	 */
	public int updateInfoNextApprovalWhenAgree(Parameter parameter);	     
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (공통 update (2))
	 */
	public int updateInfoAgreeItMust(Parameter parameter);			
 	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (마지막 결재자일때 update (1))
	 */
	public int updateInfoWhenLastAgree(Parameter parameter);      
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 반려의견 업뎃 및 문서종결 처리 (1)
	 */
	public int updateBanraeComm(Parameter parameter);  
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 반려의견 업뎃 및 문서종결 처리 (2)
	 */	
	public int updateBanrae2(Parameter parameter);

	
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
