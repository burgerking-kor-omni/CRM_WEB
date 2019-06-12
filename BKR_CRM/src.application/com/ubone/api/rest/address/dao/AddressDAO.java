package com.ubone.api.rest.address.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface AddressDAO {
	
	/**
	 * 회원 주소 정보 조회
	 * @param param 
	 * @return 
	 */
	public DataList getAddress(Parameter parameter);
	
	/**
	 * OMNI 정보조회
	 * @param param 
	 * @return 
	 */
	public DataList getOmniStorInfo(Parameter parameter);
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	/**
	 * 주소등록
	 * @param param
	 * @return  
	 */
	public String insertAddress(Parameter parameter);
	
	/**
	 * 주소삭제
	 * @param param
	 * @return  
	 */
	public int deleteAddress(Parameter parameter);
	
	/**
	 * 주소수정
	 * @param param
	 * @return  
	 */
	public int updateAddress(Parameter parameter);
	
	/**
	 * 주소수정 - 기본주소여부
	 * @param param
	 * @return  
	 */
	public int updateAddressBase(Parameter parameter);
	
}
