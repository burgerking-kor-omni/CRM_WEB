package com.ubone.api.rest.coupon.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.coupon.dao.CouponDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

@Repository
public class CouponDAOImpl extends UbSqlSessionDaoSupport implements CouponDAO  {
	
	private String queryPrefix = "ApiCoupon.";

	@Override
	public DataList getCoupon(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCoupon", parameter);
	}
	
	@Override
	public DataList getCouponMapping(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCouponMapping", parameter);
	}
	
	@Override
	public DataList getCouponPin(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCouponPin", parameter);
	}
	
	@Override
	public DataList getCouponStoreExcept(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCouponStoreExcept", parameter);
	}
	
	@Override
	public DataList getRewardCoupon(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getRewardCoupon", parameter);
	}
	
	@Override
	public DataList getCheckUseCoupon(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCheckUseCoupon", parameter);
	}
	
	@Override
	public DataList getCheckCouponStore(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCheckCouponStore", parameter);
	}
	
	@Override
	public DataList getCouponObj(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getCouponObj", parameter);
	}
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	@Override
	public String insertCouponPin(Parameter parameter) {
		return insert(this.queryPrefix + "insertCouponPin", parameter);
	}
	
	@Override
	public int updateCouponPin(Parameter parameter) {
		return update(this.queryPrefix + "updateCouponPin", parameter);
	}
	
	@Override
	public int updateRewardCouponPin(Parameter parameter) {
		return update(this.queryPrefix + "updateRewardCouponPin", parameter);
	}
	
	@Override
	public int updateMemberCouponPin(Parameter parameter) {
		return update(this.queryPrefix + "updateMemberCouponPin", parameter);
	}
	
	@Override
	public int updateCouponUseDau(Parameter parameter) {
		return update(this.queryPrefix + "updateCouponUseDau", parameter);
	}
	
	@Override
	public int updateCouponUse(Parameter parameter) {
		return update(this.queryPrefix + "updateCouponUse", parameter);
	}
	
	@Override
	public int updateRewardCoupon(Parameter parameter) {
		return update(this.queryPrefix + "updateRewardCoupon", parameter);
	}

}
