package com.ubone.standard.approval.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.approval.dao.ApprovalInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : ApprovalInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 유기태, 최소정
 *  작 성 일 : 2013. 11.29.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class ApprovalInquiryDAOImpl extends UbSqlSessionDaoSupport implements ApprovalInquiryDAO{
	
	private String queryPrefix = "ApprovalInquiry.";

	
	@Override
	public DataList getMyApprovalList(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMyApprovalList", parameter);
	}

	@Override
	public DataList getMyApprovalDetailLine(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMyApprovalDetail_line", parameter);
	}

	@Override
	public DataList getApprovalSubmitData(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getApprovalSubmitData", parameter);
	}
	
	@Override
	public String insertApproval(Parameter parameter) {
		return insert(this.queryPrefix + "insertApproval", parameter);
	}
	
	@Override
	public String insertApprovalLine(Parameter parameter) {
		return insert(this.queryPrefix + "insertApprovalLine", parameter);
	}

	@Override
	public int setApprovalLine(Parameter parameter) {
		return update(this.queryPrefix + "setApprovalLine", parameter);
	}
	
	@Override
	public int setApprovalFirstLine(Parameter parameter) {
		return update(this.queryPrefix + "setApprovalFirstLine",parameter);
	}

	@Override
	public int cancleApproval(Parameter parameter) {
		update(this.queryPrefix + "cancleApproval_detail", parameter);
		return update(this.queryPrefix + "cancleApproval_master", parameter);
	}

	@Override
	public DataList getMyApprovalDetailContent(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMyApprovalDetail_content", parameter);
	}

	@Override
	public DataList getMyApproveListData(Parameter parameter) {
		return queryForDataList(queryPrefix + "getMyApproveListData", parameter);
	}

	/**
	 * 결재자 결재진행..
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 화면
	 */
	@Override
	public DataList getMyApproveDetail(Parameter parameter) {
		
		return queryForDataList(queryPrefix + "getMyApproveDetail", parameter);
	}

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 반려의견 업뎃 및 문서종결 처리 (1)
	 */
	@Override
	public int updateBanraeComm(Parameter parameter) {

		return update(queryPrefix + "updateBanraeComm", parameter);
	}
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 반려의견 업뎃 및 문서종결 처리 (2)
	 */	
	@Override
	public int updateBanrae2(Parameter parameter) {
		return update(queryPrefix + "updateBanrae2", parameter);
	}

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 총 결재자 수(기안자 포함) 카운트
	 */
	@Override
	public DataList countAPPR(Parameter parameter) {
		return queryForDataList(queryPrefix + "countAppr", parameter);
	}
	
//	@Override
//	public int countAPPR2(Parameter parameter) {
//		
//		return queryForObject(queryPrefix + "countAppr2", parameter);
//	}
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (결재자가 남았을 때 update (1))
	 */
	@Override
	public int updateInfoNextApproval(Parameter parameter) {
		return update(queryPrefix + "updateInfoNextApproval", parameter);
	}

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (마지막 결재자일때 update (1))
	 */
	@Override
	public int updateInfoWhenLastApproval(Parameter parameter) {
		return update(queryPrefix + "updateInfoWhenLastApproval", parameter);
	}

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 (공통 update (2))
	 */
	@Override
	public int updateInfoApprovalItMust(Parameter parameter) {
		return update(queryPrefix + "updateInfoApprovalItMust", parameter);
	}
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (결재자가 남았을 때 update (1))
	 */
	@Override
	public int updateInfoNextApprovalWhenAgree(Parameter parameter) {
		return update(queryPrefix + "updateInfoNextApprovalWhenAgree", parameter);
	}	
		
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (마지막 결재자일때 update (1))
	 */
	@Override
	public int updateInfoWhenLastAgree(Parameter parameter) {
		return update(queryPrefix + "updateInfoWhenLastAgree", parameter);
	}	
		
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 합의진행 (공통 update (2))
	 */
	@Override
	public int updateInfoAgreeItMust(Parameter parameter) {
		return update(queryPrefix + "updateInfoAgreeItMust", parameter);
	}	
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재경로 Grid Control
	 */
	@Override
	public DataList getMyApproveLineListData(Parameter parameter) {
		
		return queryForDataList(queryPrefix + "getMyApproveLineListData", parameter);
	}

	/**
	 * 결재선관리 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 검색 결과
	 */
	public DataList getApprovalLineList(Parameter parameter) {
		return queryForDataList(queryPrefix + "getApprovalLineList", parameter);
	}

	/**
	 * 결재선관리 상세.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 상세 결과
	 */
	public DataList getApprovalLineDetail(Parameter parameter) {
		return queryForDataList(queryPrefix + "getApprovalLineDetail", parameter);
	}

	/**
	 * 다음결재자 정보를 가져옴
	 * @param parameter HTTP 요청 파라미터  
	 * @return 다음결재자 정보를 가져옴 결과
	 */
	public DataList getNextAppEmpId(Parameter parameter) {
		return queryForDataList(queryPrefix + "getNextAppEmpId", parameter);
	}	     
} 