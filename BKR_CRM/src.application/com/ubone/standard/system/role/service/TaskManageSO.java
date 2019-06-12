package com.ubone.standard.system.role.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.service.ResultUtils;
import com.ubone.standard.system.role.dao.TaskManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : TaskManageSO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class TaskManageSO {
	
	private static final String ROLE_COMPOSITION_TYPE = "ROLE_COMPOSITION_TYPE";
	private static final String ROLE_COMPOSITION_CODE = "ROLE_COMPOSITION_CODE";
	@Resource
	private TaskManageInquiryDAO taskManageInquiryDAO;
	
	/**
	 * 담당업무(시스템관리) 목록 검색
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회 결과
	 */
	public DataList getTaskList(Parameter parameter){
		return taskManageInquiryDAO.getTaskList(parameter);
	}
	
	/**
	 * 담당업무(시스템관리) 목록 상세
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회 결과
	 */
	public DataList getTaskDetail(Parameter parameter){
		return taskManageInquiryDAO.getTaskDetail(parameter);
	}
	
	/**
	 * 담당업무(시스템관리) 목록 조회(담당업무 권한자 구성 LIST) 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회(담당업무 권한자 구성 LIST) 결과
	 */
	public DataList getTaskCompoList(Parameter parameter){
		return taskManageInquiryDAO.getTaskCompoList(parameter);
	}
	
	/**
	 * 담당업무 (시스템관리) 권한자 추가 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무 (시스템관리) 권한자 추가  결과
	 */
	public String addTaskComposer(Parameter parameter){
		DataList dataList =  getTaskCompoList(parameter);
		for (int i = 0; i < dataList.getRowCount(); i++) {
			if(parameter.get(ROLE_COMPOSITION_CODE).equals(dataList.get(i, ROLE_COMPOSITION_CODE))
					&& parameter.get(ROLE_COMPOSITION_TYPE).equals(dataList.get(i, ROLE_COMPOSITION_TYPE))){
				return ResultUtils.makeResultForMessage("중복된 구성원 입니다.");
			}
		}
		return taskManageInquiryDAO.insertApRoleCompo(DataUtil.makeUserAddedParameter(parameter)); 
	}
	
	/**
	 * 담당업무 (시스템관리) 권한자 삭제 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무 (시스템관리) 권한자 삭제  결과
	 */
	public int removeTaskComposer(Parameter parameter){
		
		//권한자를 삭제
		int result = 0;
		String[] compoCodes = parameter.getValues("compoCodes");
		for (int i = 0; i < compoCodes.length; i++) {			
			//배열로 받은 compoCodes 선택된 그리드 갯수만큼 루프문을 돌려 삭제함
			parameter.setParameter(ROLE_COMPOSITION_CODE, compoCodes[i]);
			//체크된 갯수대로 삭제를 수행
			result +=taskManageInquiryDAO.deleteApRoleCompo(parameter);
		}
		return result;
	}
	
	/**
	 * 담당업무(시스템관리)  등록
	 * @param parameter HTTP 요청 파라미터 
	 * @return
	 */
	public String createTask(Parameter parameter){
		
		//2017.10.10 by sikim
		//Set values for default when insert to a role
		parameter.setParameter("ADMIN_YN", "N");
		parameter.setParameter("EXCEPT_MAP_YN", "N");
		taskManageInquiryDAO.insertTask(DataUtil.makeUserAddedParameter(parameter));
		return ResultUtils.makeResultForKey(parameter.get("ROLE_ID"));
	}
	
	/**
	 * 담당업무(시스템관리)  저장
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public int saveTask(Parameter parameter){
		return taskManageInquiryDAO.updateTask(DataUtil.makeUserAddedParameter(parameter));
	}
	
	/**
	 * 담당업무(시스템관리)  삭제
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public int removeTask(Parameter parameter){
		return taskManageInquiryDAO.removeTask(DataUtil.makeUserAddedParameter(parameter));
	}

	/**
	 * 권한코드 조회 함수
	 * @param parameter
	 * @return
	 */
	public DataList selectRoleId(Parameter parameter){
		return taskManageInquiryDAO.selectRoleId(parameter);
	}
	
}
