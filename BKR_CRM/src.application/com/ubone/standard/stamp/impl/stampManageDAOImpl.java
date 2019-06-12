package com.ubone.standard.stamp.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;
import com.ubone.standard.stamp.dao.stampManageDAO;

@Repository
public class stampManageDAOImpl extends UbSqlSessionDaoSupport implements stampManageDAO {

	private String prefix = "stampManageDAO.";
	
	@Override
	public DataList getStampStd(Parameter param) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public DataList getProdList(Parameter param) {
		return queryForDataList(this.prefix+"getProdList", param);
	}
	
	@Override
	public DataList getMenuAutoComplete(Parameter param) {
		return queryForDataList(this.prefix+"getMenuAutoComplete", param);
	}
	
	@Override
	public DataList checkStampMenu(Parameter param) {
		return queryForDataList(this.prefix+"checkStampMenu", param);
	}
	
	@Override
	public String insertTbsStamp(Parameter param) {
		// 스템프 마스터 등록
		return insert(this.prefix+"insertTbsStamp", param);
	}
	@Override
	public void insertStampRole(Parameter param) {
		// 적립기준 상품
		insert(this.prefix+"insertStampRole", param);
	}
	
	@Override
	public void insertStampExStore(Parameter param) {
		// 제외매장 등록
		insert(this.prefix+"insertStampExStore", param);
	}
	
	@Override
	public void insertStampStnd(Parameter param) {
		// 스탬프 적립채널 등록
		insert(this.prefix+"insertStampStnd", param);
	}
	
	@Override
	public DataList getTbsStamp(Parameter param) {
		return queryForDataList(this.prefix+"getTbsStamp",param);
	}
	
	@Override
	public DataList getStampStnd(Parameter param) {
		return queryForDataList(this.prefix+"getStampStnd", param);
	}
	
	@Override
	public DataList getStampRole(Parameter param) {
		return queryForDataList(this.prefix+"getStampRole", param);
	}
	
	@Override
	public DataList getStampRecode(Parameter param) {
		return queryForDataList(this.prefix+"getStampRecode", param);
	}
	
	@Override
	public void updateTbsStamp(Parameter param) {
		update(this.prefix+"updateTbsStamp", param);
	}
	
	@Override
	public void deleteStampStnd(Parameter param) {
		delete(this.prefix+"deleteStampStnd", param);
	}
	
	@Override
	public void deleteStampRole(Parameter param) {
		delete(this.prefix+"deleteStampRole", param);
	}
	
	@Override
	public void deleteStampExStore(Parameter param) {
		delete(this.prefix+"deleteStampExStore", param);
	}
	
	@Override
	public String insertTbsStampRecode(Parameter param) {
		// 이력 등록
		return insert(this.prefix+"insertStampRecode", param);
	}
	
	@Override
	public void insertStampRecode(Parameter param) {
		insert(this.prefix+"insertExceptStoreRecode", param);
		insert(this.prefix+"insertRoleRecode", param);
		insert(this.prefix+"insertStndRecode", param);
	}
	
	
	@Override
	public DataList getTbsStampRecord(Parameter param) {
		return queryForDataList(this.prefix+"getTbsStampRecord", param);
	}

	@Override
	public DataList getStampRoleRecord(Parameter param) {
		return queryForDataList(this.prefix+"getStampRoleRecord", param);
	}
	
	@Override
	public DataList getStampStndRecord(Parameter param) {
		return queryForDataList(this.prefix+"getStampStndRecord", param);
	}
	
	@Override
	public void deleteStamp(Parameter param) {
		update(this.prefix+"deleteStamp", param);
	}
	
	@Override
	public void insertStampReward(Parameter param) {
		insert(this.prefix+"insertStampReward", param);
	}
	
	@Override
	public void deleteStampReward(Parameter param) {
		update(this.prefix+"deleteStampReward", param);
	}
	
	@Override
	public DataList getStampReward() {
		return queryForDataList(this.prefix+"getStampReward");
	}
	
	@Override
	public DataList getUpMenuCode(Parameter param) {
		return queryForDataList(this.prefix+"getUpMenuCode", param);
	}
}
