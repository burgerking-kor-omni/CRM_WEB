package com.ubone.standard.system.role.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.role.dao.RoleGroupDAO;

/** 
 * <pre>
 *  파 일 명 : RoleGroupDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 김태완
 *  작 성 일 : 2013. 7. 08.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class RoleGroupDAOImpl extends UbSqlSessionDaoSupport implements RoleGroupDAO{
	private String queryPrefix = "RoleGroup.";
	
	public DataList getRoleGroupList(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getRoleGroupList", parameter);
	}
	
	public DataList getRoleGroupDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getRoleGroupDetail", parameter);
	}
	
	public DataList getAuthGroupUserList(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getAuthGroupUserList", parameter);
	}
	
	public int insertAuthGroup(Parameter parameter){
		return update(this.queryPrefix + "insertAuthGroup", parameter);
	}

	public int deleteAuthGroup(Parameter parameter) {
		return update(this.queryPrefix + "deleteAuthGroup", parameter);
	}
	
	public int deleteAuthGroupForUser(Parameter parameter) {
		return update(this.queryPrefix + "deleteAuthGroupForUser", parameter);
	}

	public DataList getAuthGroupListForUser(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getAuthGroupListForUser", parameter);
	}
	
}
