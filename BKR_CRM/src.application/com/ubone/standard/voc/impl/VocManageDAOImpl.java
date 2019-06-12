package com.ubone.standard.voc.impl;

import org.springframework.stereotype.Repository;

import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.standard.voc.dao.VocManageDAO;

@Repository
public class VocManageDAOImpl extends UbSqlSessionDaoSupport implements VocManageDAO {
	private String prefix = "VocManage.";
	
	@Override
	public DataList getVocList(Parameter param) {
		return queryForDataList(this.prefix+"getVocList", param);
	}
	
	@Override
	public DataList getVocDetail(Parameter param) {
		return queryForDataList(this.prefix+"getVocDetail", param);
	}
	
	@Override
	public DataList getVocFileList(Parameter param) {
		return queryForDataList(this.prefix+"getVocFileList", param);
	}
	
	@Override
	public void updateVocDetail(Parameter param) {
		update(this.prefix+"updateVocDetail", param);
	}
	
	@Override
	public void deleteVoc(Parameter param) {
		update(this.prefix+"deleteVoc", param);
	}
	
	@Override
	public DataList getOrderInfo(Parameter param) {
		return queryForDataList(this.prefix+"getOrderInfo", param);
	}
	
	@Override
	public DataList getVocAutoComplete(Parameter param) {
		return queryForDataList(this.prefix+"getVocAutoComplete", param);
	}
	
	@Override
	public void insertVoc(Parameter param) {
		insert(this.prefix+"insertVoc", param);
	}
	
	@Override
	public DataList getStoreList(Parameter param) {
		return queryForDataList(this.prefix+"getStoreList",param);
	}
	
	@Override
	public DataList getStoreAutoComplete(Parameter param) {
		return queryForDataList(this.prefix+"getStoreAutoComplete", param);
	}
	
	@Override
	public DataList getUserAutoComplete(Parameter param) {
		return queryForDataList(this.prefix+"getUserAutoComplete", param);
	}
	
	@Override
	public DataList getVocListToExcel(Parameter param) {
		return queryForDataList(this.prefix+"getVocListToExcel", param);
	}
}
