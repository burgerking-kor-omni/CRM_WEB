package com.ubone.standard.system.account.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface AccountManageDAO {
	/**
	 * 계정 중복체크
	 * @param parameter
	 * @return
	 */
	public DataList selectDuplicate(Parameter parameter);

	public String insertAccountRequest(Parameter parameter);

	public DataList selectAccountRequest(Parameter parameter);

	public DataList getAccountRequestDetail(Parameter parameter);

	public int updateAccountRequestStatus(Parameter parameter);

	public DataList getAccountRequestStatus(String loginId);

	public DataList findUserInfo(Parameter parameter);

	public int updatePassWord(Parameter parameter);
	
	public DataList selectMobPhone(Parameter parameter);
	
	public DataList selectEmail(Parameter parameter);
	
	public DataList selectLoginId(Parameter parameter);
	
	public DataList getAccountRequestList(Parameter parameter);
	
	public int updateAccountReq(Parameter parameter);
	
	public int updateUserInfo(Parameter parameter);
	
	public int updateAccountReturn(Parameter parameter);
	
	public int updateUserIncumbent(Parameter parameter);
}
