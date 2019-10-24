package com.ubone.standard.cust.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.cust.dao.CustManageDAO;


@Repository
public class CustManageDAOImpl extends UbSqlSessionDaoSupport implements CustManageDAO {
	
	private String prefix = "CustManageDAO.";

	@Override
	public DataList getCustList(Parameter param) {
		return queryForDataList(this.prefix+"getCustList", param);
	}

	@Override
	public DataList getCustDetail(Parameter param) {
		return queryForDataList(this.prefix+"getCustDetail" , param);
	}
	
	@Override
	public String insertDelMember(Parameter param) {
		return insert(this.prefix+"insertDelMember", param);
	}
	@Override
	public int deleteMember(Parameter param) {
		return update(this.prefix+"deleteMember", param);
	}
	@Override
	public int deletelMemberAddr(Parameter param) {
		return update(this.prefix+"deletelMemberAddr", param);
	}
	@Override
	public int deletelSnsMember(Parameter param) {
		return update(this.prefix+"deletelSnsMember", param);
	}
	
	@Override
	public int resetPasswd(Parameter param) {
		return update(this.prefix+"resetPasswd", param);
	}
	
	
	
	@Override
	public DataList getOrderList(Parameter param) {
		return queryForDataList(this.prefix+"getOrderList", param);
	}
	@Override
	public DataList getOrderProd(Parameter param) {
		return queryForDataList(this.prefix+"getOrderProd", param);
	}
	
	@Override
	public DataList getOrderStore(Parameter param) {
		return queryForDataList(this.prefix+"getOrderStore", param);
	}
	
	@Override
	public DataList getOrderDetail(Parameter param) {
		return queryForDataList(this.prefix+"getOrderDetail",param);
	}
	
	@Override
	public DataList getProdList(Parameter param) {
		return queryForDataList(this.prefix+"getProdList", param);
	}
	
	@Override
	public DataList getOptionList(Parameter param) {
		return queryForDataList(this.prefix+"getOptionList", param);
	}
	
	@Override
	public DataList getCouponInfo(Parameter param) {
		return queryForDataList(this.prefix+"getCouponInfo", param);
	}
	
	@Override
	public DataList getCouponListUse(Parameter param) {
		return queryForDataList(this.prefix+"getCouponListUse", param);
	}
	
	@Override
	public DataList getPaymentList(Parameter param) {
		return queryForDataList(this.prefix+"getPaymentList", param);
	}
	
	@Override
	public DataList getPayChannel(Parameter param) {
		return queryForDataList(this.prefix+"getPayChannel", param);
	}
	
	@Override
	public DataList getOrderListPopup(Parameter param) {
		return queryForDataList(this.prefix+"getOrderListPopup", param);
	}
	
	@Override
	public DataList getHaveCouponList(Parameter param) {
		return queryForDataList(this.prefix+"getHaveCouponList", param);
	}
	
	@Override
	public DataList getUseCouponList(Parameter param) {
		return queryForDataList(this.prefix+"getUseCouponList", param);
	}
	
	@Override
	public DataList getCustLogStamp(Parameter param) {
		return queryForDataList(this.prefix+"getCustLog_stamp", param);
	}
	
	@Override
	public DataList getCouponList(Parameter param) {
		return queryForDataList(this.prefix+"getCouponList",param);
	}

	@Override
	public DataList getSnsList(Parameter param) {
		return queryForDataList(this.prefix+"getSnsList", param);
	}
	
	@Override
	public DataList getCustLogChange(Parameter param) {
		return queryForDataList(this.prefix+"getCustLog_change", param);
	}
	
	@Override
	public DataList getSendGift(Parameter param) {
		return queryForDataList(this.prefix+"getSendGift", param);
	}
	
	@Override
	public DataList getRecvGift(Parameter param) {
		return queryForDataList(this.prefix+"getRecvGift", param);
	}
	
	@Override
	public DataList getMoneyList(Parameter param) {
		return queryForDataList(this.prefix+"getMoneyList", param);
	}

	
	
	
	@Override
	public DataList getGradeList() {
		return queryForDataList(this.prefix+"getGradeList");
	}
	
	@Override
	public DataList getGradeDetail(Parameter param) {
		return queryForDataList(this.prefix+"getGradeDetail", param);
	}
	
	@Override
	public void insertGrade(Parameter param) {
		insert(this.prefix+"insertGrade", param);
	}
	
	@Override
	public int updateGradeDetail(Parameter param) {
		return update(this.prefix+"updateGradeDetail", DataUtil.makeUserAddedParameter(param));
	}
	
	@Override
	public void deleteGrade(Parameter param) {
		update(this.prefix+"deleteGrade", param);
	}
	
	@Override
	public DataList getDownStd() {
		return queryForDataList(this.prefix+"getDownStd");
	}
	
	@Override
	public void insertDownStd(Parameter param) {
		insert(this.prefix+"insertDownStd", param);
	}
	
	@Override
	public void deleteDownStd() {
		Parameter param = DataUtil.makeParameter();
		update(this.prefix+"deleteDownStd", param);
	}
	
	@Override
	public DataList getCardList(Parameter param) {
		return queryForDataList(this.prefix+"getCardList", param);
	}
	
	@Override
	public DataList getStampCntLast(Parameter param) {
		return queryForDataList(this.prefix+"getStampCntLast", param);
	}
	
	@Override
	public void addStampRecord(Parameter param) {
		// 최종 여부 N으로 수정
		update(this.prefix+"updateStampLast", param);

		// 최종 스탬프 이력 추가
		insert(this.prefix+"addStampRecord", param);
	}
	
	@Override
	public void updateStampMember(Parameter param) {
		update(this.prefix+"updateStampMember", param);
	}
	
	@Override
	public void addStampReward(Parameter param) {
		insert(this.prefix+"addStampReward", param);
	}
	
	@Override
	public DataList getCountStamp(Parameter param) {
		return queryForDataList(this.prefix+"getCountStamp",param);
	}
	
	@Override
	public DataList getCountReward(Parameter param) {
		return queryForDataList(this.prefix+"getCountReward", param);
	}
	
	@Override
	public int updateMemberName(Parameter param) {
		return update(this.prefix+"updateMemberName", param);
	}
	
	@Override
	public int checkEmail(Parameter param) {
		return queryForObject(this.prefix+"checkEmail", param);
	}
	
	@Override
	public void updateEmail(Parameter param) {
		update(this.prefix+"updateEmail", param);
	}
	
	@Override
	public void insertChangeRecord(Parameter param) {
		insert(this.prefix+"insertChangeRecord", param);
	}
}
