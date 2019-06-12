package com.ubone.api.rest.stamp.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

public interface StampDAO {
	
	/**
	 * 스템프 사용가능 정보 확인
	 * @param
	 * @return 스템프 사용가능 정보 확인
	 */
	public DataList getStampUse(Parameter parameter);
	
	/**
	 * 기 등록 주문 확인
	 * @param
	 * @return 기 등록 주문 확인
	 */
	public DataList chkOrderStamp(Parameter parameter);
	
	/**
	 * 회원 등급 조회
	 * @param
	 * @return 회원 등급 조회 
	 */
	public DataList getMemberGrade(Parameter parameter);
	
	/**
	 * 이벤트 스템프 적립 가능매장 확인
	 * @param
	 * @return 
	 */
	public DataList getStampExcept(Parameter parameter);
	
	/**
	 * 스템프 적립건수 조회
	 * @param
	 * @return 
	 */
	public DataList getCntStamp(Parameter parameter);
	
	/**
	 * 회원 기존 스탬프 이력 조회 - 누적스템프 계산용도
	 * @param
	 * @return 
	 */
	public DataList getStampRecord(Parameter parameter);
	
	/**
	 * 회원스템프 차감을 위한 기존 이력 조회
	 * @param
	 * @return 
	 */
	public DataList getStampOrderRecord(Parameter parameter);
	
	/**
	 * 발행된 리워드 쿠폰 갯수 조회
	 * @param
	 * @return 
	 */
	public DataList getMemberRewardCnt(Parameter parameter);
	
	/**
	 * 주문번호로 적립된 리워드 쿠폰 존재여부 확인
	 * @param
	 * @return 
	 */
	public DataList getMemberRewardOrder(Parameter parameter);
	
	/**
	 * 스템프 이후 적립여부 확인
	 * @param 
	 * @return 
	 */
	public DataList getStampAfterRecord(Parameter parameter);
	
	/**
	 * 해당 주문으로 리워드 쿠폰 생성여부 확인
	 * @param 
	 * @return 
	 */
	public DataList getUseRewardCoupon(Parameter parameter);
	
	/**
	 * 최근 적립된 리워드 조회
	 * @param 
	 * @return 
	 */
	public DataList getRewardMax(Parameter parameter);
	
	/**
	 * ********************************************************************
	 * ******************************************************************** 
	 */
	
	/**
	 * 회원스템프적립
	 * @param param
	 * @return  
	 */
	public int updateMemberStampPlus(Parameter parameter);
	
	/**
	 * 회원스템프차감
	 * @param param
	 * @return  
	 */
	public int updateMemberStampMinus(Parameter parameter);
	
	/**
	 * 회원의 기존 스템프 이력 수정
	 * @param param
	 * @return  
	 */
	public int updateStampRecord(Parameter parameter);
	
	/**
	 * 회원스템프이력 저장
	 * @param param
	 * @return  
	 */
	public String insertStampRecord(Parameter parameter);
	
	/**
	 * 회원 스템프 리워드 저장
	 * @param param
	 * @return  
	 */
	public String insertMemberstampReward(Parameter parameter);
	
	/**
	 * 회원리워드쿠폰 삭제
	 * @param param
	 * @return  
	 */
	public int deleteMemberReward(Parameter parameter);
	
	/**
	 * 리워드 쿠폰 취소 처리
	 * @param param
	 * @return  
	 */
	public int updateRewardCoupon(Parameter parameter);
	
}
