package com.ubone.standard.approval.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.util.sequence.SequenceRepository;
import com.ubone.standard.approval.dao.TbsApprovalLineDAO;
import com.ubone.standard.approval.dao.TbsApprovalLineDtlDAO;

/** 
 * <pre>
 *  파 일 명 : ApprovalManageSO.java
 *  설    명 : 
 *  작 성 자 : 
 *  작 성 일 : 2013. 11. 27
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class ApprovalManageSO {

	@Resource
	private TbsApprovalLineDAO tbsApprovalLineDAO;
	@Resource
	private TbsApprovalLineDtlDAO tbsApprovalLineDtlDAO;
	@Resource
    SequenceRepository sequenceRepository;

	/**
	 * 결재선 신규 등록.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public String insertApprovalLine(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		String [] SEQ_APPR = parameter.getValues("SEQ_APPR2");
		String [] TP_APPR_LINE = parameter.getValues("TP_APPR_LINE2");
		String [] ID_DEPT = parameter.getValues("ID_DEPT2");
//		String [] CD_POSITION = parameter.getValues("CD_POSITION2");
		String [] CD_DUTY = parameter.getValues("CD_DUTY");
		String [] ID_EMP = parameter.getValues("ID_EMP2");
//		parameter.setParameter("ID_APPR_LINE_KEY",sequenceRepository.nextVal("SEQ_TBS_APPROVAL_LINE"));
		String approvalId = tbsApprovalLineDAO.insertApprovalLine(parameter);
		String approvalDtlId="";
		if(approvalId != null){
			parameter.setParameter("ID_APPR_LINE", approvalId);
			for(int i=0;i<SEQ_APPR.length;i++){
				parameter.setParameter("SEQ_APPR", SEQ_APPR[i]);
				parameter.setParameter("TP_APPR_LINE", TP_APPR_LINE[i]);
				parameter.setParameter("ID_DEPT", ID_DEPT[i]);
//				parameter.setParameter("CD_POSITION", CD_POSITION[i]);
				parameter.setParameter("CD_DUTY", CD_DUTY[i]);
				parameter.setParameter("ID_EMP", ID_EMP[i]);
//				parameter.setParameter("ID_APPR_LINE_DTL_KEY",sequenceRepository.nextVal("SEQ_TBS_APPROVAL_LINE_DTL"));
				approvalDtlId = tbsApprovalLineDtlDAO.insertApprovalLineDtl(parameter);
			}
		}
		return approvalDtlId;
	}
	
	/**
	 * 결재선 수정.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int updateApprovalLine(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		//결재선상세 삭제후
		tbsApprovalLineDtlDAO.deleteApprovalLineDtl(parameter);
		
		//결재선 수정
		parameter.setParameter("NM_APPR_LINE", parameter.getValue("NM_APPR_LINE2"));
		tbsApprovalLineDAO.updateApprovalLine(parameter);
		
		//결재선상세 입력
		String [] SEQ_APPR = parameter.getValues("SEQ_APPR2");
		String [] ID_DEPT = parameter.getValues("ID_DEPT2");
		String [] TP_APPR_LINE = parameter.getValues("TP_APPR_LINE2");
//		String [] CD_POSITION = parameter.getValues("CD_POSITION2");
		String [] CD_DUTY = parameter.getValues("CD_DUTY");
		String [] ID_EMP = parameter.getValues("ID_EMP2");
		
		for(int i=0;i<SEQ_APPR.length;i++){
			parameter.setParameter("SEQ_APPR", SEQ_APPR[i]);
			parameter.setParameter("TP_APPR_LINE", TP_APPR_LINE[i]);
			parameter.setParameter("ID_DEPT", ID_DEPT[i]);
//			parameter.setParameter("CD_POSITION", CD_POSITION[i]);
			parameter.setParameter("CD_DUTY", CD_DUTY[i]);
			parameter.setParameter("ID_EMP", ID_EMP[i]);
//			parameter.setParameter("ID_APPR_LINE_DTL_KEY",sequenceRepository.nextVal("SEQ_TBS_APPROVAL_LINE_DTL"));
			tbsApprovalLineDtlDAO.insertApprovalLineDtl(parameter);
		}
		
		return 1;
	}
	/**
	 * 결재선 삭제
	 * @param parameter HTTP 요청 파라미터  
	 * @return 성공여부
	 */
	public int deleteApprovalLine(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return 	tbsApprovalLineDAO.deleteApprovalLine(parameter);
	}
}
