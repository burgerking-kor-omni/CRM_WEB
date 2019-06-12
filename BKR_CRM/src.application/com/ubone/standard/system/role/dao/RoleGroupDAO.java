package com.ubone.standard.system.role.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : RoleGroupDAO.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2013. 7. 08.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
public interface RoleGroupDAO {
	/**
	 * 권한그룹(시스템관리) 목록
	 * @param parameter HTTP 요청 파라미터 
	 * @return 권한그룹(시스템관리) 목록 조회 결과
	 */
	public DataList getRoleGroupList(Parameter parameter);
	
	/**
	 * 권한그룹(시스템관리) 상세
	 * @param parameter HTTP 요청 파라미터 
	 * @return 권한그룹(시스템관리) 목록 조회 결과
	 */
	public DataList getRoleGroupDetail(Parameter parameter);
	
	/**
	 * 권한그룹(시스템관리) 유저목록
	 * @param parameter
	 * @return
	 */
	public DataList getAuthGroupUserList(Parameter parameter);

	/**
	 * 권한그룹 저장 (시스템관리) 유저목록
	 * @param makeUserAddedParameter
	 * @return
	 */
	public int insertAuthGroup(Parameter parameter);

	/**
	 * 권한그룹 삭제 (시스템관리) 유저목록
	 * @param makeUserAddedParameter
	 */
	public int deleteAuthGroup(Parameter parameter);
	
	/**
	 * 권한 그룹 삭제 사용자별
	 * @param parameter
	 * @return
	 */
	public int deleteAuthGroupForUser(Parameter parameter);

	/**
	 * 권한그룹 삭제 (시스템관리) 사용자별 권한 그룹 목록
	 * @param parameter
	 * @return
	 */
	public DataList getAuthGroupListForUser(Parameter parameter);
}
