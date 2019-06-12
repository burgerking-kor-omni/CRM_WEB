package com.ubone.standard.system.role.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.role.dao.TaskManageInquiryDAO;

/** 
 * <pre>
 *  파 일 명 : TaskManageInquiryDAOImpl.java
 *  설    명 : 
 *  작 성 자 : 안진철
 *  작 성 일 : 2013. 5. 13.
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * @author Copyrights 2012 by ㈜ 유비원. All right reserved.
 */
@Repository
public class TaskManageInquiryDAOImpl extends UbSqlSessionDaoSupport implements TaskManageInquiryDAO{
	private String queryPrefix = "TaskManageInquiry.";
	
	public DataList getTaskList(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getTaskList", parameter);
	}
	
	public DataList getTaskDetail(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getTaskDetail", parameter);
	}

	public DataList getTaskCompoList(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "getTaskCompoList", parameter);
	}

	public String insertApRoleCompo(Parameter parameter) {
		return insert(this.queryPrefix + "insertApRoleCompo", parameter); 
	}

	public int deleteApRoleCompo(Parameter parameter) {
		return delete(this.queryPrefix + "deleteApRoleCompo", parameter);
	}

	public String insertTask(Parameter parameter) {
		return insert(this.queryPrefix + "insertTask", parameter);
	}

	public int updateTask(Parameter parameter) {
		return update(this.queryPrefix + "updateTask", parameter);
	}

	@Override
	public int removeTask(Parameter parameter) {
		return delete(this.queryPrefix + "removeTask", parameter);
	}

	@Override
	public DataList selectRoleId(Parameter parameter) {
		return queryForDataList(this.queryPrefix +  "selectRoleId", parameter);
	}
}
