package com.ubone.api.rest.coupon.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;


public interface CouponDAO {
	
	/**
	 * 쿠폰 조회
	 * @param 
	 * @return 
	 */
	public DataList getCoupon(Parameter parameter);
	
	/**
	 * 기존에 발급내역 확인
	 * @param 
	 * @return 
	 */
	public DataList getCouponMapping(Parameter parameter);
	
	/**
	 * 쿠폰핀 조회
	 * @param 
	 * @return 쿠폰번호 조회
	 */
	public DataList getCouponPin(Parameter parameter);
	
	/**
	 * 제외매장 조회
	 * @param 
	 * @return 쿠폰번호 조회
	 */
	public DataList getCouponStoreExcept(Parameter parameter);
	
	/**
	 * 리워드 쿠폰 조회
	 * @param 
	 * @return 쿠폰번호 조회
	 */
	public DataList getRewardCoupon(Parameter parameter);
	
	/**
	 * 쿠폰사용여부조회
	 * @param 
	 * @return 쿠폰번호 조회
	 */
	public DataList getCheckUseCoupon(Parameter parameter);
	
	/**
	 * 쿠폰 제외매장 여부 조회
	 * @param 
	 * @return 쿠폰번호 조회
	 */
	public DataList getCheckCouponStore(Parameter parameter);
	
	/**
	 * 쿠폰 대상 조회
	 * @param 
	 * @return 쿠폰 대상 조회
	 */
	public DataList getCouponObj(Parameter parameter);
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	/**
	 * 쿠폰핀 생성
	 * @param param
	 * @return  
	 */
	public String insertCouponPin(Parameter parameter);
	
	/**
	 * 쿠폰 매핑
	 * @param param
	 * @return  
	 */
	public int updateCouponPin(Parameter parameter);
	
	/**
	 * 리워드 쿠폰 매핑
	 * @param param
	 * @return  
	 */
	public int updateRewardCouponPin(Parameter parameter);
	
	/**
	 * 회원번호 매핑
	 * @param param
	 * @return  
	 */
	public int updateMemberCouponPin(Parameter parameter);
	
	/**
	 * 쿠폰상태변경 - 다우
	 * @param param
	 * @return  
	 */
	public int updateCouponUseDau(Parameter parameter);
	
	/**
	 * 쿠폰상태변경
	 * @param param
	 * @return  
	 */
	public int updateCouponUse(Parameter parameter);
	
	/**
	 * 리워드 쿠폰 변경
	 * @param param
	 * @return  
	 */
	public int updateRewardCoupon(Parameter parameter);
	
}
