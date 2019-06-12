package com.ubone.standard.coupon.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.coupon.dao.CouponManageDAO;

@Repository
public class CouponManageDAOImpl extends UbSqlSessionDaoSupport implements CouponManageDAO {
	private String prefix = "CouponManageDAO.";
	
	@Override
	public void insertDauPinConfig(Parameter param) {
		insert(this.prefix+"insertDauPinConfig", param);
	}
	
	@Override
	public DataList getDauPinConfig() {
		return queryForDataList(this.prefix+"getDauPinConfig");
	}
	
	@Override
	public void delDauPinConfig(Parameter param) {
		update(this.prefix+"delDauPinConfig", param);
	}
	
	@Override
	public DataList getCouponList(Parameter param) {
		return queryForDataList(this.prefix+"getCouponList", param);
	}
	
	@Override
	public DataList getPinStatus(Parameter param) {
		return queryForDataList(this.prefix+"getPinStatus", param);
	}
	
	@Override
	public DataList getMemberID(Parameter param) {
		return queryForDataList(this.prefix+"getMemberID", param);
	}
	
	@Override
	public void publishCouponDau(Parameter param) {
		update(this.prefix+"publishCouponDau", param);
	}
	
	@Override
	public void publishCouponBkr(Parameter param) {
		insert(this.prefix+"publishCouponBkr", param);
	}
	
	@Override
	public DataList checkOverCoupon(Parameter param) {
		return queryForDataList(this.prefix+"checkOverCoupon",param);
	}
	
	@Override
	public String insertCoupon(Parameter param) {
		return insert(this.prefix+"insertCoupon", param);
	}
	
	@Override
	public void insertStoreEx(Parameter param) {
		insert(this.prefix+"insertStoreEx",param);
	}
	
	@Override
	public void deleteStoreEx(Parameter param) {
		delete(this.prefix+"deleteStoreEx", param);
	}
	
	@Override
	public DataList getMenuList(Parameter param) {
		return queryForDataList(this.prefix+"getMenuList",param);
	}
	
	@Override
	public void updateCouponOrder(Parameter param) {
		update(this.prefix+"updateCouponOrder", param);
	}
	
	@Override
	public String checkDauPinStatus(Parameter param) {
		return queryForObject(this.prefix+"checkDauPinStatus", param);
	}
	
	@Override
	public void insertDauPin(Parameter param) {
		insert(this.prefix+"insertDauPin", param);
	}
	
	@Override
	public DataList getCouponDetail(Parameter param) {
		return queryForDataList(this.prefix+"getCouponDetail",param);
	}
	
	@Override
	public void updateCouponDetail(Parameter param) {
		update(this.prefix+"updateCouponDetail", param);
	}
	
	@Override
	public void deleteCouponDetail(Parameter param) {
		delete(this.prefix+"deleteCouponDetail", param);
	}
	
	@Override
	public DataList getRewardCouponList(Parameter param) {
		return queryForDataList(this.prefix+"getRewardCouponList", param);
	}
	
	@Override
	public DataList getStampList(Parameter param) {
		return queryForDataList(this.prefix+"getStampList", param);
	}
	
	@Override
	public String reInsertCoupon(Parameter param) {
		return insert(this.prefix+"reInsertCoupon", param);
	}
	
	@Override
	public DataList getAttachCount(Parameter param) {
		return queryForDataList(this.prefix+"getAttachCount", param);
	}
	
	@Override
	public void insertAttachLink(Parameter param) {
		insert(this.prefix+"insertAttachLink", param);
	}
	
	@Override
	public String insertAttach(Parameter param) {
		return insert(this.prefix+"insertAttach", param);
	}
	
	@Override
	public void reinsertStoreEx(Parameter param) {
		insert(this.prefix+"reinsertStoreEx", param);
	}
}
