package com.ubone.standard.system.department.impl;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.User;
import com.ubone.framework.engine.domain.UserBuilder;
import com.ubone.standard.system.department.dao.SearchDeptManageDAO;

/** 
 * <pre>
 *  파 일 명 : SearchDeptManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
@Repository
public class SearchDeptManageDAOImpl extends UbSqlSessionDaoSupport implements SearchDeptManageDAO{

	private String queryPrefix = "SearchDeptManage.";
	
	public DataList getDeptList(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getDeptList", parameter);
	}
	
	public List<User> findByRoleIdAndPartCode(String roleId, String partCode) throws EmptyResultDataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("roleId", roleId);
		map.put("partCode", partCode);

		//List<Map<String, Object>> list = getSimpleJdbcTemplate().queryForList(getQuery("query.application.user4"), partCode, map);
		DataList list = queryForDataList(this.queryPrefix+"findByRoleIdAndPartCode", map);
		
		List<User> users = new LinkedList<User>();
		for (int i = 0; i < list.size(); i++) {
			String id = (String) list.getString(i, "id");
			String name = (String) list.getString(i, "name");
			String password = (String) list.getString(i, "password");
			String partName = (String) list.getString(i, "partName");
			String headPartCode = (String) list.getString(i, "headquartersCode");
			String classCode = (String) list.getString(i, "classCode");
			String positionCode = (String) list.getString(i, "positionCode");
			String email = (String) list.getString(i, "email");
			String phoneNumber = (String) list.getString(i, "phoneNumber");
			String mobilePhoneNumber = (String) list.getString(i, "mobilePhoneNumber");
			String languageCode = (String) list.getString(i, "languageCode");
			
			UserBuilder builder = new UserBuilder();
			builder.setId(id);
			builder.setName(name);
			builder.setPassword(password);
			builder.setPartCode(partCode);
			builder.setPartName(partName);
			builder.setHeadPartCode(headPartCode);
			builder.setClassCode(classCode);
			builder.setPositionCode(positionCode);
			builder.setEmail(email);
			builder.setPhoneNumber(phoneNumber);
			builder.setMobilePhoneNumber(mobilePhoneNumber);
			builder.setLanguageCode(languageCode);
			
			users.add(builder.build());			
		}

		return users;
	}

	@Override
	public DataList getDetail(String deptId) {
		return queryForDataList(queryPrefix + "getDetail", deptId);
	}

	@Override
	public DataList getDeptTree(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getDeptTree", parameter);
	}

	@Override
	public DataList getDeptTreeLazy(Parameter parameter) {
		return queryForDataList(this.queryPrefix+"getDeptTreeLazy", parameter);
	}

	@Override
	public void insertDept(Parameter parameter) {
		insert(this.queryPrefix  + "insertDept", parameter);
	}

	@Override
	public int update(Parameter parameter) {
		return update(this.queryPrefix  + "updateDept", parameter);
	}

	@Override
	public int delete(Parameter parameter) {
		return delete(this.queryPrefix  + "delete", parameter);
	}

	@Override
	public DataList getDeptEmpList(String deptId) {
		return queryForDataList(queryPrefix + "getDeptEmpList", deptId);
	}

	@Override
	public DataList checkDeptId(Parameter parameter) {
		return queryForDataList(queryPrefix + "checkDeptId", parameter);
	}
	
}
