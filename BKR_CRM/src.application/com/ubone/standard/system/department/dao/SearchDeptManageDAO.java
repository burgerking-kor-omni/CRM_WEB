package com.ubone.standard.system.department.dao;

import java.util.List;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.engine.domain.User;

import org.springframework.dao.EmptyResultDataAccessException;

/** 
 * <pre>
 *  파 일 명 : SearchDeptManageInquiryDAO.java
 *  설    명 : 
 *  작 성 자 : 이동엽
 *  작 성 일 : 2013. 5. 8.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */
public interface SearchDeptManageDAO {
	
	/**
	 * 부서 목록(공통) 검색.
	 * @param parameter 
	 * @return 
	 */
	public DataList getDeptList(Parameter parameter);
	
	public List<User> findByRoleIdAndPartCode(String roleId, String partCode) throws EmptyResultDataAccessException;

	public DataList getDetail(String deptId);

	public DataList getDeptTree(Parameter parameter);

	public DataList getDeptTreeLazy(Parameter parameter);

	public void insertDept(Parameter parameter);

	public int update(Parameter makeUserAddedParameter);

	public int delete(Parameter makeUserAddedParameter);
	
	public DataList getDeptEmpList(String deptId);
	
	public DataList checkDeptId(Parameter parameter);
}
