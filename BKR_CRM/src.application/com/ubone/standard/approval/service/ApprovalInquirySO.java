package com.ubone.standard.approval.service;

import java.util.GregorianCalendar;
import java.util.ListIterator;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.framework.util.file.FileSupport;
import com.ubone.framework.util.file.FileSupport.FileMethodType;
import com.ubone.framework.util.sequence.SequenceRepository;
import com.ubone.standard.approval.dao.ApprovalInquiryDAO;
import com.ubone.standard.approval.dao.ApprovalProvider;

/** 
 * <pre>
 *  파 일 명 : ApprovalInquirySO.java
 *  설    명 : 
 *  작 성 자 : 유기태, 최소정
 *  작 성 일 : 2013. 11. 29
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class ApprovalInquirySO {

	private static final String ID_ISSUE_ACT = "ID_ISSUE_ACT";
	private static final String ID_BIZ_KEY = "ID_BIZ_KEY";
	private static final String QTY_MILEAGE = "QTY_MILEAGE";
	private static final String PT_MILEAGE = "PT_MILEAGE";
	private static final String ID_MILEAGE = "ID_MILEAGE";
	private static final String ID_MILEAGE_RULE = "ID_MILEAGE_RULE";
	private static final String CD_BRANCH = "CD_BRANCH";
	private static final String CD_ITEM = "CD_ITEM";
	private static final String CD_TYPE = "CD_TYPE";
	private static final String ISSUE_STATUS = "issueStatus";
	private static final String CD_ISSUE_STATUS = "CD_ISSUE_STATUS";
	private static final String ID_ISSUE = "ID_ISSUE";
	private static final String ID_VOC = "ID_VOC";
	private static final String TP_BIZ = "TP_BIZ";
	private static final String ID_APPR = "ID_APPR";
	private static final String ID_DEPT = "ID_DEPT";
	private static final String ID_DEPT_UP = "ID_DEPT_UP";
	private static final Log logger = LogFactory.getLog(ApprovalInquirySO.class);
	@Resource
	private ApprovalProvider approvalProvider;
	
	@Resource
	private ApprovalInquiryDAO approvalInquiryDAO;
	
	@Resource
    SequenceRepository sequenceRepository;
	
	/**
	 * 나의상신목록 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신목록 조회 결과
	 */
	public DataList getMyApprovalList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return approvalInquiryDAO.getMyApprovalList(parameter);	
	}
	
	/**
	 * 나의상신상세 결재경로 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신상세 결재경로 조회 결과
	 */
	public DataList getMyApprovalDetailLine(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		DataList lists=approvalInquiryDAO.getMyApprovalDetailLine(parameter);
		
		// 상위부서 존재시 표시되는 부서 설정 (상위부서 > 부서명)
		ListIterator<Map<String,Object>> it=lists.listIterator();
		while(it.hasNext()){
			Map<String, Object> dto=it.next();	
			if(dto.get(ID_DEPT_UP)!="" && dto.get(ID_DEPT_UP)!=null){
				String deptNm=dto.get(ID_DEPT_UP)+" > "+dto.get(ID_DEPT);
				dto.put(ID_DEPT, deptNm);
			}
		}
		return lists;
	}
	
	/**
	 * 나의상신상세 결재내용 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의상신상세 결재내용 조회 결과
	 */
	@FileSupport(primaryKeyFieldNames=ID_APPR, methodType=FileMethodType.READ)
		public DataList getMyApprovalDetailContent(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return approvalInquiryDAO.getMyApprovalDetailContent(parameter);
	}
	
	/**
	 * 결재상신등록 창 호출시 기본데이터 검색
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재상신등록 창 호출시 기본데이터 결과
	 */
	public DataList getApprovalSubmitData(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return approvalInquiryDAO.getApprovalSubmitData(parameter);
	}
	
	/**
	 * 결재기안, 결재라인 등록
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재라인등록 결과
	 */
	@FileSupport(primaryKeyFieldNames=ID_APPR, methodType=FileMethodType.CREATE)
	public String submitApproval(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		
		// ID_APPR (기본키) 날짜 시간설정	
		GregorianCalendar gc= new GregorianCalendar();
		long now = gc.getTimeInMillis();
		parameter.set(ID_APPR,"APP"+now);
		
		// 기안등록
		this.approvalInquiryDAO.insertApproval(parameter);
		String submitResult=ResultUtils.makeResultForKey(parameter.get(ID_APPR));
		
		// 결재라인분리
		
		// 결재경로 추가완료여부를 저장하는 변수 (리턴값)
		String submitLineResult="";		
		if(submitResult!=null && !("".equals(submitResult))){
			String[] lists=parameter.getValues("LINE");
			String[] saveLists;		
			for(int i=0;i<lists.length;i++){
				saveLists=lists[i].split("[|]");
				parameter.setParameter("SEQ_APPR", i+1);
				parameter.setParameter("TP_APPR_LINE", saveLists[0]);
				parameter.setParameter("ID_EMP_APPR", saveLists[1]);
				parameter.setParameter("CD_DUTY", saveLists[2]);
				parameter.setParameter(ID_DEPT, saveLists[3]);
//				parameter.setParameter("ID_APPR_DTL_KEY",sequenceRepository.nextVal("SEQ_TBS_APPROVAL_DTL"));
				//결재라인 등록
				submitLineResult=ResultUtils.makeResultForKey(this.approvalInquiryDAO.insertApprovalLine(parameter));
				//최초 결재자에게 통보
				if(i == 1){
					//통보대상자 셋팅
					parameter.setParameter("ID_ACT_EMP", saveLists[1]);
					parameter.setParameter("ID_APPR_DTL", parameter.getParameter("ID_APPR_DTL_KEY"));
					//통보(이메일)
//					vocCommonUtil.getDispatchInfoForApp(parameter, VocConstantHolder.TP_BIZ_15, ChannelType.Email.getCode());
					//통보(SMS)
//					vocCommonUtil.getDispatchInfoForApp(parameter, VocConstantHolder.TP_BIZ_15, ChannelType.SMS.getCode());
				}
			}
			if(submitLineResult!=null && !("".equals(submitLineResult))){
				//결재라인기안 설정
				this.approvalInquiryDAO.setApprovalLine(parameter);
				//결재라인 첫결재자 설정
				this.approvalInquiryDAO.setApprovalFirstLine(parameter);
			}
		}
		//계획수립결재(메일) 통보
//		vocCommonUtil.getDispatchInfoForIss(parameter, VocConstantHolder.TP_BIZ_14, ChannelType.Email.getCode());
		//계획수립결재(문자) 통보
//		vocCommonUtil.getDispatchInfoForIss(parameter, VocConstantHolder.TP_BIZ_14, ChannelType.SMS.getCode());
				
		return submitResult;
	}
	
	/**
	 * 기안취소
	 * @param parameter HTTP 요청 파라미터  
	 * @return 기안취소 결과
	 */
	// 취소시 파일삭제할경우 주석해제 @FileSupport(primaryKeyFieldNames="ID_APPR", methodType=FileMethodType.DELETE)
	public int approvalCancle(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		//개선과제의 상태를 과제등록중으로 변경
		String idVoc = parameter.getParameter("ID_VOC");
		parameter.set(ID_ISSUE, idVoc);
//		DataList issueDetail = issueInquirySO.getIssuePlanDetail(parameter);
//		String issuStatus = issueDetail.get(0, CD_ISSUE_STATUS);
		
//		if("R1".equals(issuStatus)){
//			parameter.set(ISSUE_STATUS, "R0");
//		}else if("P1".equals(issuStatus)){
//			parameter.set(ISSUE_STATUS, "P0");
//		}
		
		try {
//			issueProcessSO.updateIssueApproval(parameter);
		} catch (Exception e) {
			//업데이트 실패시 메시지를 출력
			logger.debug("기안취소 후 개선과제 상태변경 오류 - 개선과제ID = " + idVoc);
		}
		return this.approvalInquiryDAO.cancleApproval(parameter);
	}
	

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 전체 리스트 및 조회 화면
	 */
	public DataList getMyApproveListData(Parameter parameter) {			
		parameter = DataUtil.makeUserAddedParameter(parameter);		
		
		return approvalInquiryDAO.getMyApproveListData(parameter);
	}
		
	/**
	 * 결재자 결재진행..
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행 화면
	 */
	@FileSupport(primaryKeyFieldNames=ID_APPR, methodType=FileMethodType.READ)
	public DataList getMyApproveDetail(Parameter parameter){		
		
		return approvalInquiryDAO.getMyApproveDetail(parameter);
	}
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 반려처리
	 * @throws Exception 
	 */
	@FileSupport(primaryKeyFieldNames=ID_APPR, methodType=FileMethodType.UPDATE)
	public int updateBanrae(Parameter parameter) throws Exception{
		int result = 0;
		String tpBiz = parameter.getValue(TP_BIZ);
		String idVoc = parameter.getValue(ID_VOC);
		parameter = DataUtil.makeUserAddedParameter(parameter);	
		int banraeComm=approvalInquiryDAO.updateBanraeComm(parameter);
		
		if(banraeComm==1){
			result = approvalInquiryDAO.updateBanrae2(parameter);
			
			//2014.04.16 결제반려 시 개선과제의 상태를 변경
//			try {				
//				if(result != 0 && "04".equals(tpBiz)){
//					
//					parameter.set(ID_ISSUE, idVoc);
//					DataList issueDetail = issueInquirySO.getIssuePlanDetail(parameter);
//					String issuStatus = issueDetail.get(0, CD_ISSUE_STATUS);
//					
//					if("R1".equals(issuStatus)){
//						parameter.set(ISSUE_STATUS, "R0");
//					}else if("P1".equals(issuStatus)){
//						parameter.set(ISSUE_STATUS, "P0");
//					}
//					
//					issueProcessSO.updateIssueApproval(parameter);
//				}
//			} catch (Exception e) {
//				throw e;
//			}
			//2014.04.16 결제반려 시 개선과제의 상태를 변경
		}
		return result;
	}

	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재진행
	 * @throws Exception 
	 */
	@FileSupport(primaryKeyFieldNames=ID_APPR, methodType=FileMethodType.UPDATE)
	public int updateInfoApprovalItMust(Parameter parameter) throws Exception{ 
		parameter = DataUtil.makeUserAddedParameter(parameter);	
		
		int processId=0, processId2=0;
		
		//총 결재자 수 카운트
		DataList list_cnt = approvalInquiryDAO.countAPPR(parameter); 				
		//int count2 = approvalInquiryDAO.countAPPR2(parameter); //총 합의자 수 카운트		
		
				
		int count = Integer.parseInt(String.valueOf(list_cnt.get(0, "CNT_APPR")));
		
		
		String TP_APPR_LINE = parameter.get("TP_APPR_LINE");
		
		//나머지 결재자가 남았을 때
		if(parameter.getInt("SEQ_APPR") != count){ 
			
			//합의자라면
			if("03".equals(TP_APPR_LINE)){ 
				processId2 = approvalInquiryDAO.updateInfoNextApprovalWhenAgree(parameter);				
			}else{			
				
				// 다음 결재자의 FG_USE 및 기타정보 update
				processId= approvalInquiryDAO.updateInfoNextApproval(parameter); 
			}
			parameter.setParameter("ID_BIZ_KEY", parameter.getParameter("ID_VOC"));
			DataList nextAppEmpInfo = approvalInquiryDAO.getNextAppEmpId(parameter);
//			parameter.setParameter("ID_ACT_EMP", nextAppEmpInfo.getString(0, "ID_EMP_APPR"));
//			//다음결재자에게 통보(메일)
//			vocCommonUtil.getDispatchInfoForApp(parameter,  VocConstantHolder.TP_BIZ_15, ChannelType.Email.getCode());
//			parameter.setParameter("ID_ACT_EMP", nextAppEmpInfo.getString(0, "ID_EMP_APPR"));
//			//다음결재자에게 통보(SMS)
//			vocCommonUtil.getDispatchInfoForApp(parameter,  VocConstantHolder.TP_BIZ_15, ChannelType.SMS.getCode());
		}else{				
			
			//합의자라면
			if("03".equals(TP_APPR_LINE)){ 
				processId2 = approvalInquiryDAO.updateInfoWhenLastAgree(parameter);
			}else{			
				
				//TP_STATUS_APPR = '결재완료', DT_APPR (최종결재일) 및 기타정보 update
				processId= approvalInquiryDAO.updateInfoWhenLastApproval(parameter); 
			}
//			parameter.setParameter("ID_ISSUE",parameter.getParameter("ID_VOC"));
//			parameter.setParameter("ID_BIZ_KEY",parameter.getParameter("ID_VOC"));
//			//개선과제 활동담당자 배정 통보(메일)
//			vocCommonUtil.getDispatchInfoForIssAct(parameter,  VocConstantHolder.TP_BIZ_18, ChannelType.Email.getCode());
//			//개선과제 활동담당자 배정 통보(SMS)			
//			vocCommonUtil.getDispatchInfoForIssAct(parameter,  VocConstantHolder.TP_BIZ_18, ChannelType.SMS.getCode());
			 	
		}		
		
		if(processId == 1){
			int result = 0;
			
			//나의 결재상태 TP_APPR_PROC update
			result = approvalInquiryDAO.updateInfoApprovalItMust(parameter); 
			
			//2014.04.16 결제승인 시 개선과제의 상태를 변경
//			try {
//				String tpBiz = parameter.getValue(TP_BIZ);
//				String idVoc = parameter.getValue(ID_VOC);
				
//				if(result != 0 && "04".equals(tpBiz) && count == parameter.getInt("SEQ_APPR")){
//				if(result != 0 && count == parameter.getInt("SEQ_APPR")){

//					parameter.set(ID_ISSUE, idVoc);
//					DataList issueDetail = issueInquirySO.getIssuePlanDetail(parameter);
//					String issuStatus = issueDetail.get(0, CD_ISSUE_STATUS);
					
//					if("R1".equals(issuStatus)){
//						parameter.set(ISSUE_STATUS, "P0");
						//개선과제 수립완료 마일리지적립
						//마일리지 점수 조회
//						Parameter param = DataUtil.makeParameter();
//						param = DataUtil.makeUserAddedParameter(parameter);
//						param.set(CD_TYPE,VocConstantHolder.CD_TYPE_02);
//						param.set(CD_ITEM,VocConstantHolder.CD_ITEM_02);
//						DataList mileageInfo = mileageManageInquiryDAO.getMileageList(param);
						//개선과제 팀정보 조회
//						DataList issueInfo = issueInquiryDAO.issueInfoInquiry(parameter);
						//마일리지 파라미터 셋팅(계획수립완료)
//						int rowCount = issueInfo.getRowCount();
//						if(rowCount>0){
//							for(int i=0; i< rowCount; i++){
//								if(!StringUtils.isEmpty(issueInfo.getString(i, CD_BRANCH))){
//									param.setParameter(ID_MILEAGE_RULE, mileageInfo.getString(0, ID_MILEAGE));
//									param.setParameter(TP_BIZ , VocConstantHolder.TP_BIZ_04);
//									param.setParameter(ID_BIZ_KEY , param.getParameter(ID_ISSUE));
//									param.setParameter(PT_MILEAGE , mileageInfo.getString(0, QTY_MILEAGE));
//									tbsMileageDAO.insertTbsMileage(param);
//								}
//							}
//						}
						
						//개선계획 4주 이상추진 마일리지 적립
						//마일리지 점수 조회
//						Parameter param2 = DataUtil.makeParameter();
//						param2 = DataUtil.makeUserAddedParameter(parameter);
//						param2.set(CD_TYPE,VocConstantHolder.CD_TYPE_02);
//						param2.set(CD_ITEM,VocConstantHolder.CD_ITEM_03);
//						DataList mileageInfo2 = mileageManageInquiryDAO.getMileageList(param2);
						//개선과제 팀정보 조회
//						DataList issueInfo2 = issueInquiryDAO.issueActInfoInquiry(parameter);
						//마일리지 파라미터 셋팅(계획수립완료)
//						int rowCount2 = issueInfo2.getRowCount();
//						if(rowCount2>0){
//							for(int i=0; i< rowCount; i++){
//								int dateResult = Integer.parseInt(issueInfo2.getString(i, "DATE_RESULT"));
//								if(dateResult>=28 && !StringUtils.isEmpty(issueInfo2.getString(i, CD_BRANCH))){									
//									param2.setParameter(ID_MILEAGE_RULE, mileageInfo2.getString(0, ID_MILEAGE));
//									param2.setParameter(TP_BIZ , VocConstantHolder.TP_BIZ_04);
//									param2.setParameter(ID_BIZ_KEY , issueInfo2.getString(i, ID_ISSUE_ACT));
//									param2.setParameter(PT_MILEAGE , mileageInfo2.getString(0, QTY_MILEAGE));
//									tbsMileageDAO.insertTbsMileage(param2);									
//								}
//							}
//						}
							
//					}else if("P1".equals(issuStatus)){
//						parameter.set(ISSUE_STATUS, "C0");
						
						//개선과제 완료 마일리지 적립
						//마일리지 점수 조회
//						Parameter param = DataUtil.makeParameter();
//						param = DataUtil.makeUserAddedParameter(parameter);
//						param.set(CD_TYPE,VocConstantHolder.CD_TYPE_02);
//						param.set(CD_ITEM,VocConstantHolder.CD_ITEM_04);
//						DataList mileageInfo = mileageManageInquiryDAO.getMileageList(param);
						//개선과제 팀정보 조회
//						DataList issueInfo = issueInquiryDAO.issueActInfoInquiry(parameter);
						//마일리지 파라미터 셋팅(개선과제 완료)
//						int rowCount = issueInfo.getRowCount();
//						if(rowCount>0){
//							for(int i=0; i< rowCount; i++){
//								if(!StringUtils.isEmpty(issueInfo.getString(i, CD_BRANCH))){
//									param.setParameter(ID_MILEAGE_RULE, mileageInfo.getString(0, ID_MILEAGE));
//									param.setParameter(TP_BIZ , VocConstantHolder.TP_BIZ_04);
//									param.setParameter(ID_BIZ_KEY , issueInfo.getString(i, ID_ISSUE_ACT));
//									param.setParameter(PT_MILEAGE , mileageInfo.getString(0, QTY_MILEAGE));
//									tbsMileageDAO.insertTbsMileage(param);
//								}
//							}
//						}
//					}
					
//					issueProcessSO.updateIssueApproval(parameter);
//				}
//			} catch (Exception e) {
//				throw e;
//			}
			//2014.04.16 결제승인 시 개선과제의 상태를 변경
			
			return result;		
			
		}else if(processId2 == 1){
			return approvalInquiryDAO.updateInfoAgreeItMust(parameter);			
		}
		
		return 0;
	}
	
	/**
	 * 결재자 결재진행.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 나의 결재 - 결재경로 Grid Control
	 */
	public DataList getMyApproveLineListData(Parameter parameter) {			
		parameter = DataUtil.makeUserAddedParameter(parameter);		
		DataList lists = approvalInquiryDAO.getMyApproveLineListData(parameter);
		
		// 상위부서 존재시 표시되는 부서 설정 (상위부서 > 부서명)
		ListIterator<Map<String,Object>> it=lists.listIterator();
		while(it.hasNext()){
			Map<String, Object> dto=it.next();	
			if(dto.get(ID_DEPT_UP)!="" && dto.get(ID_DEPT_UP)!=null){
				String deptNm=dto.get(ID_DEPT_UP)+" > "+dto.get(ID_DEPT);
				dto.put(ID_DEPT, deptNm);
			}
		}
		return lists;
	}
	
	
	
	/**
	 * 결재선관리 검색.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 검색 결과
	 */
	public DataList getApprovalLineList(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return approvalProvider.getApprovalLineList(parameter);
	}
	
	/**
	 * 결재선관리 상세.
	 * @param parameter HTTP 요청 파라미터  
	 * @return 결재선관리 상세 결과
	 */
	public DataList getApprovalLineDetail(Parameter parameter){
		parameter = DataUtil.makeUserAddedParameter(parameter);
		return approvalProvider.getApprovalLineDetail(parameter);
	}
}


