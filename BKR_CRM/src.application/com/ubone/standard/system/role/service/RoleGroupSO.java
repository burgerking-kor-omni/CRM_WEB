package com.ubone.standard.system.role.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.role.dao.RoleGroupDAO;

/** 
 * <pre>
 *  파 일 명 : RoleGroupSO.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2013. 7. 08.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Service
public class RoleGroupSO {
	
	private static final String DESCRIPTION = "DESCRIPTION";
	private static final String USER_ID = "USER_ID";
	private static final String GRP_MAP_ID_2 = "GRP_MAP_ID_2";
	private static final String GRP_MAP_ID_1 = "GRP_MAP_ID_1";
	private static final String ROLE_ID = "ROLE_ID";
	@Resource
	private RoleGroupDAO roleGroupDAO;
	
	/**
	 * 권한그룹(시스템관리) 목록 검색
	 * @param parameter HTTP 요청 파라미터 
	 * @return 권한그룹(시스템관리) 목록 조회 결과
	 */
	public DataList getRoleGroupList(Parameter parameter){
		return roleGroupDAO.getRoleGroupList(parameter);
	}
	
	/**
	 * 권한그룹(시스템관리) 목록 상세
	 * @param parameter HTTP 요청 파라미터 
	 * @return 권한그룹(시스템관리) 목록 조회 결과
	 */
	public DataList getRoleGroupDetail(Parameter parameter){
		return roleGroupDAO.getRoleGroupDetail(parameter);
	}
	
	/**
	 * 권한그룹(시스템관리) 유저목록
	 * @param parameter
	 * @return
	 */
	public DataList getAuthGroupUserList(Parameter parameter){
		return roleGroupDAO.getAuthGroupUserList(parameter);
	}
	
	
	/**
	 * 권한그룹(시스템관리) 유저별 권한 목록
	 * @param parameter
	 * @return
	 */
	public DataList getAuthGroupListForUser(Parameter parameter){
		return roleGroupDAO.getAuthGroupListForUser(parameter);
	}
	
	
	/**
	 * 담당업무(시스템관리)  저장
	 * @param parameter HTTP 요청 파라미터 
	 * @return 
	 */
	public void saveAuthGroup(Parameter parameter){
		
		roleGroupDAO.deleteAuthGroup(parameter);
		
		String[] userList = parameter.getValues("USER_LIST");
		Parameter makeParameter = null;
		for (int i = 0; i < userList.length; i++) {
			makeParameter = DataUtil.makeParameter();
			makeParameter.setParameter(ROLE_ID, parameter.getValue(ROLE_ID));
			makeParameter.setParameter(GRP_MAP_ID_1, parameter.getValue(GRP_MAP_ID_1));
			makeParameter.setParameter(GRP_MAP_ID_2, parameter.getValue(GRP_MAP_ID_2));
			makeParameter.setParameter(USER_ID, userList[i]);
			makeParameter.setParameter(DESCRIPTION, parameter.getValue(DESCRIPTION));
			roleGroupDAO.insertAuthGroup(DataUtil.makeUserAddedParameter(makeParameter));
		}
	}
	
	public void addAuthGroupForUser(Parameter parameter){
		
		roleGroupDAO.deleteAuthGroupForUser(parameter);
		
		String[] authList = parameter.getValues("AUTH_LIST");
		Parameter makeParameter = null;
		for (int i = 0; i < authList.length; i++) {
			String[] authInfo = authList[i].split("[|]");
					
			makeParameter = DataUtil.makeParameter();
			if(authInfo.length == 3){
				makeParameter.setParameter(GRP_MAP_ID_2, authInfo[2]);	
			}
			makeParameter.setParameter(ROLE_ID, authInfo[1]);
			makeParameter.setParameter(GRP_MAP_ID_1, authInfo[0]);
			makeParameter.setParameter(USER_ID, parameter.getValue(USER_ID));
			roleGroupDAO.insertAuthGroup(DataUtil.makeUserAddedParameter(makeParameter));
		}
	}

}
