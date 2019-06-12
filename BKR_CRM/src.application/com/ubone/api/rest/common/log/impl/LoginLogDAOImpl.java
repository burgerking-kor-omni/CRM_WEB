package com.ubone.api.rest.common.log.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.common.log.dao.LoginLogDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;

@Repository
public class LoginLogDAOImpl extends UbSqlSessionDaoSupport implements LoginLogDAO {
	
	private String queryPrefix = "ApiLoginLog.";
	
	@Override
	public String insertLoginLog(String idMember) {
		Parameter logParam = DataUtil.makeParameter();
		logParam.setParameter("ID_MEMBER", idMember);
		return insert(this.queryPrefix + "insertLoginLog", logParam);
	}
	
}
