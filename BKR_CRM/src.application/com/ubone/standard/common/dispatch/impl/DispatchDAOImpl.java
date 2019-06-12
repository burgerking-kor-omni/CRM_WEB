package com.ubone.standard.common.dispatch.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.common.dispatch.dao.DispatchDAO;

@Repository
public class DispatchDAOImpl extends UbSqlSessionDaoSupport implements DispatchDAO {
	
	private String queryPrefix = "Dispatch.";
	
	@Override
	public DataList getDispatchEmpTarget(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getDispatchEmpTarget", parameter);
	}
	
	@Override
	public DataList getVocDispatch(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getVocDispatch", parameter);
	}
	
	@Override
	public String insertDispatchRun(Parameter parameter) {
		return insert(this.queryPrefix + "insertDispatchRun", parameter);
	}
	
	@Override
	public String insertDispatchRunTarget(Parameter parameter) {
		return insert(this.queryPrefix + "insertDispatchRunTarget", parameter);
	}
	
}
