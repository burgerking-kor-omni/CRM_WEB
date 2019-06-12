package com.ubone.standard.system.role.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : TaskManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface TaskManageInquiryDAO {
	/**
	 * 담당업무(시스템관리) 목록 검색
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회 결과
	 */
	public DataList getTaskList(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 목록 상세
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회 결과
	 */
	public DataList getTaskDetail(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 목록 조회(담당업무 권한자 구성 LIST) 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 담당업무(시스템관리) 목록 조회(담당업무 권한자 구성 LIST) 결과
	 */
	public DataList getTaskCompoList(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 권한자 추가 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public String insertApRoleCompo(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 권한자 삭제 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public int deleteApRoleCompo(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 권한자 추가 
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public String insertTask(Parameter parameter);
	
	/**
	 * 담당업무(시스템관리) 권한자 상세 저장
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public int updateTask(Parameter parameter);

	/**
	 * 담당업무 권한을 삭제하는 함수
	 * @param makeUserAddedParameter
	 * @return
	 */
	public int removeTask(Parameter makeUserAddedParameter);

	/**
	 * 권한ID 조회 함수 - 중복체크용
	 * @param parameter
	 * @return
	 */
	public DataList selectRoleId(Parameter parameter);
}
