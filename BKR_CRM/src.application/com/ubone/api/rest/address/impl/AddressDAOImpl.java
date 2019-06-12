package com.ubone.api.rest.address.impl;

import org.springframework.stereotype.Repository;

import com.ubone.api.rest.address.dao.AddressDAO;
import com.ubone.framework.dao.UbSqlSessionDaoSupport;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

@Repository
public class AddressDAOImpl extends UbSqlSessionDaoSupport implements AddressDAO  {
	
	private String queryPrefix = "ApiAddress.";
	
	@Override
	public DataList getAddress(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getAddress", parameter);
	}
	
	@Override
	public DataList getOmniStorInfo(Parameter parameter) {
		return queryForDataList(this.queryPrefix + "getOmniStorInfo", parameter);
	}
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	@Override
	public String insertAddress(Parameter parameter) {
		return insert(this.queryPrefix + "insertAddress", parameter);
	}
	
	@Override
	public int deleteAddress(Parameter parameter) {
		return delete(this.queryPrefix + "deleteAddress", parameter);
	}
	
	@Override
	public int updateAddress(Parameter parameter) {
		return update(this.queryPrefix + "updateAddress", parameter);
	}
	
	@Override
	public int updateAddressBase(Parameter parameter) {
		return update(this.queryPrefix + "updateAddressBase", parameter);
	}

}
