package com.ubone.api.rest.common.error.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.common.error.dao.ErrorDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;

@Repository
public class ErrorDAOImpl extends UbSqlSessionDaoSupport implements ErrorDAO {
	
	private String queryPrefix = "ApiError.";
	
	@Override
	public String insertApiError(String idApi, String cdCallChnn, Exception e) {
		Parameter errorParam = DataUtil.makeParameter();
		errorParam.setParameter("ID_API", idApi);
		errorParam.setParameter("CD_CALL_CHNN", cdCallChnn);
		errorParam.setParameter("ERROR_MESSAGE", e.getMessage().toString());
		StringBuffer sb = new StringBuffer();
		for (int i=0; i<e.getStackTrace().length; i++) {
			sb.append(e.getStackTrace()[i]);
		}
		errorParam.setParameter("STACK_TRACE", sb.toString());
		return insert(this.queryPrefix + "insertApiError", errorParam);
	}
	
}
