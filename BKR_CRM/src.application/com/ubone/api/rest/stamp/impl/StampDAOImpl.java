package com.ubone.api.rest.stamp.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.stamp.dao.StampDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

@Repository
public class StampDAOImpl extends UbSqlSessionDaoSupport implements StampDAO  {
	
	private String queryPrefix = "ApiStamp.";
	
	@Override
	public DataList getStampUse(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getStampUse", parameter);
	}
	
	@Override
	public DataList chkOrderStamp(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "chkOrderStamp", parameter);
	}
	
	@Override
	public DataList getMemberGrade(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberGrade", parameter);
	}
	
	@Override
	public DataList getStampExcept(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getStampExcept", parameter);
	}
	
	@Override
	public DataList getCntStamp(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCntStamp", parameter);
	}
	
	@Override
	public DataList getStampRecord(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getStampRecord", parameter);
	}
	
	@Override
	public DataList getStampOrderRecord(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getStampOrderRecord", parameter);
	}
	
	@Override
	public DataList getMemberRewardCnt(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberRewardCnt", parameter);
	}
	
	@Override
	public DataList getMemberRewardOrder(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getMemberRewardOrder", parameter);
	}
	
	@Override
	public DataList getStampAfterRecord(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getStampAfterRecord", parameter);
	}
	
	@Override
	public DataList getUseRewardCoupon(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getUseRewardCoupon", parameter);
	}
	
	@Override
	public DataList getRewardMax(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getRewardMax", parameter);
	}
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	@Override
	public int updateMemberStampPlus(Parameter parameter) {
		return update(this.queryPrefix + "updateMemberStampPlus", parameter);
	}
	
	@Override
	public int updateMemberStampMinus(Parameter parameter) {
		return update(this.queryPrefix + "updateMemberStampMinus", parameter);
	}
	
	@Override
	public int updateStampRecord(Parameter parameter) {
		return update(this.queryPrefix + "updateStampRecord", parameter);
	}
	
	@Override
	public String insertStampRecord(Parameter parameter) {
		return insert(this.queryPrefix + "insertStampRecord", parameter);
	}
	
	@Override
	public String insertMemberstampReward(Parameter parameter) {
		return insert(this.queryPrefix + "insertMemberstampReward", parameter);
	}
	
	@Override
	public int deleteMemberReward(Parameter parameter) {
		return delete(this.queryPrefix + "deleteMemberReward", parameter);
	}
	
	@Override
	public int updateRewardCoupon(Parameter parameter) {
		return update(this.queryPrefix + "updateRewardCoupon", parameter);
	}

}
