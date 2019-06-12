package com.ubone.api.rest.common.error.dao;


public interface ErrorDAO {
	
	/**
	 * API Error log 저장
	 * @param param
	 * @return count 
	 */
	public String insertApiError(String idApi, String cdCallChnn, Exception e);
	
}
