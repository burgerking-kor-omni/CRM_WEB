package com.ubone.standard.approval.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.approval.dao.ApprovalInquiryDAO;
import com.ubone.standard.approval.dao.ApprovalProvider;

@Component(value="approvalProviderImpl")
public class ApprovalProviderImpl implements ApprovalProvider {

	@Resource
	private ApprovalInquiryDAO approvalInquiryDAO;

	/**
	 * 결재선관리 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 검색 결과
	 */
	public DataList getApprovalLineList(Parameter parameter) {
		return approvalInquiryDAO.getApprovalLineList(parameter);
	}

	/**
	 * 결재선관리 상세.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 상세 결과
	 */
	public DataList getApprovalLineDetail(Parameter parameter) {
		return approvalInquiryDAO.getApprovalLineDetail(parameter);
	}
	
}
