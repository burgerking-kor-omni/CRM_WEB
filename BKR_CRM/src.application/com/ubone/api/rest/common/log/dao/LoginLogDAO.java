package com.ubone.api.rest.common.log.dao;



public interface LoginLogDAO {
	
	/**
	 * Login log 저장
	 * @param param
	 * @return 
	 */
	public String insertLoginLog(String idMember);
	
}
