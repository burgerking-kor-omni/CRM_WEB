package com.ubone.standard.system.account.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.system.account.dao.AccountManageDAO;

@Repository
public class AccountManageDAOImpl extends UbSqlSessionDaoSupport implements AccountManageDAO {
	
	private final String prefix = "AccountManage.";

	@Override
	public DataList selectDuplicate(Parameter parameter) {
		return queryForDataList(this.prefix+"selectDuplicate",parameter);
	}

	@Override
	public String insertAccountRequest(Parameter parameter) {
		return insert(this.prefix + "insertAccountRequest", parameter);
	}

	@Override
	public DataList selectAccountRequest(Parameter parameter) {
		return queryForDataList(this.prefix+"selectAccountRequest",parameter);
	}

	@Override
	public DataList getAccountRequestDetail(Parameter parameter) {
		return queryForDataList(this.prefix+"getAccountRequestDetail",parameter);
	}

	@Override
	public int updateAccountRequestStatus(Parameter parameter) {
		return update(this.prefix+"updateAccountRequestStatus", parameter);
	}

	@Override
	public DataList getAccountRequestStatus(String loginId) {
		Parameter parameter = DataUtil.makeUserAddedParameter();
		parameter.setParameter("LOGIN_ID", loginId);
		return queryForDataList(this.prefix+"getAccountRequestStatus",parameter);
	}

	/**
	 * Find Id 용 유저정보 조회 ( 조회조건 : 이름 + 메일 )
	 * @param parameter
	 * @return
	 */
	
	@Override
	public DataList findUserInfo(Parameter parameter) {
		return queryForDataList(this.prefix+"findUserInfo",parameter);
	}

	@Override
	public int updatePassWord(Parameter parameter) {
		return update(this.prefix+"updateAccountRequestStatus", parameter);
	}

	@Override
	public DataList selectMobPhone(Parameter parameter) {
		return queryForDataList(this.prefix+"selectMobPhone",parameter);
	}

	@Override
	public DataList selectEmail(Parameter parameter) {
		return queryForDataList(this.prefix+"selectEmail",parameter);
	}

	@Override
	public DataList selectLoginId(Parameter parameter) {
		return queryForDataList(this.prefix+"selectLoginId",parameter);
	}

	@Override
	public DataList getAccountRequestList(Parameter parameter) {
		return queryForDataList(this.prefix+"getAccountRequestList",parameter);
	}

	@Override
	public int updateAccountReq(Parameter parameter) {
		return update(this.prefix+"updateAccountReq", parameter);
	}

	@Override
	public int updateUserInfo(Parameter parameter) {
		return update(this.prefix+"updateUserInfo", parameter);
	}

	@Override
	public int updateAccountReturn(Parameter parameter) {
		return update(this.prefix+"updateAccountReturn", parameter);
	}

	@Override
	public int updateUserIncumbent(Parameter parameter) {
		return update(this.prefix+"updateUserIncumbent", parameter);
	}
	
}
