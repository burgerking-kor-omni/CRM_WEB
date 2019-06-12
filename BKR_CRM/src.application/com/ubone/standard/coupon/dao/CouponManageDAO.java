package com.ubone.standard.coupon.dao;

import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.DataList;

public interface CouponManageDAO {

	/**
	 * 다우 핀 가져오기 설정 등록
	 * @param param 설정정보
	 */
	public void insertDauPinConfig(Parameter param);
	
	/**
	 * 다우 핀 가져오기 설정 조회
	 * @return
	 */
	public DataList getDauPinConfig ();
	
	/**
	 * 기존 설정 삭제처리
	 * @param 유저정보
	 */
	public void delDauPinConfig (Parameter param);
	
	/**
	 * 쿠폰 마스터 목록 조회
	 * @param param 검색조건
	 * @return 목록 정보
	 */
	public DataList getCouponList(Parameter param);
	
	/**
	 * 쿠폰 핀 현황 조회
	 * @param param 쿠폰 코드
	 * @return 현황정보
	 */
	public DataList getPinStatus(Parameter param);
	
	/**
	 * 쿠폰 핀 발행 대상 조회
	 * @param param 검색조건
	 * @return 회원정보
	 */
	public DataList getMemberID (Parameter param);
	
	/**
	 * 다우 쿠폰 발행
	 * @param param 쿠폰,멤버정보
	 */
	public void publishCouponDau (Parameter param);
	
	/**
	 * 자체 쿠폰 발행
	 * @param param 쿠폰,멤버정보
	 */
	public void publishCouponBkr (Parameter param); 
	
	/**
	 * 쿠폰 중복 발행여부 체크
	 * @param param 쿠폰정보, 회원pk
	 * @return 중복여부
	 */
	public DataList checkOverCoupon (Parameter param);
	
	/**
	 * 쿠폰 마스터 등록
	 * @param param 쿠폰 정보
	 */
	public String insertCoupon(Parameter param);
	
	/**
	 * 쿠폰 제외매장 등록
	 * @param param 제외매장,쿠폰 정보
	 */
	public void insertStoreEx(Parameter param);
	
	/**
	 * 제외매장 삭제
	 * @param param 쿠폰번호
	 */
	public void deleteStoreEx(Parameter param);
	
	/**
	 * 상품 찾기 팝업
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getMenuList(Parameter param);
	
	/**
	 * 쿠폰 순서 수정
	 * @param param 쿠폰pk, 순서
	 */
	public void updateCouponOrder(Parameter param);
	
	/**
	 * 다우 핀 발행
	 * @param param 쿠폰id, no_req
	 * @return 진행여부
	 */
	public String checkDauPinStatus(Parameter param);
	
	/**
	 * 다우 핀 발행 배치 스케쥴 등록
	 * @param param
	 */
	public void insertDauPin(Parameter param);
	
	/**
	 * 쿠폰 마스터 상세 조회
	 * @param param 쿠폰pk
	 * @return 상세정보
	 */
	public DataList getCouponDetail(Parameter param);
	
	/**
	 * 쿠폰 마스터 수정
	 * @param param 쿠폰 정보
	 */
	public void updateCouponDetail (Parameter param);
	
	/**
	 * 쿠폰 마스터 삭제
	 * @param param 쿠폰 pk
	 */
	public void deleteCouponDetail (Parameter param);
	
	/**
	 * 리워드 쿠폰 현황 목록 조회
	 * @param param 발급일
	 * @return 목록정보
	 */
	public DataList getRewardCouponList(Parameter param);
	
	/**
	 * 스탬프 목록 조회
	 * @param param 검색조건
	 * @return 목록정보
	 */
	public DataList getStampList (Parameter param);



	/**
	 * 쿠폰 마스터 재등록 
	 * @param param 쿠폰 pk
	 */
	public String reInsertCoupon(Parameter param);
	
	/**
	 * 첨부파일 개수 조회
	 * @param param 
	 * @return 첨부파일 개수
	 */
	public DataList getAttachCount(Parameter param);
	
	/**
	 * 첨부파일 링크 재등록
	 * @param param 첨부파일 pk
	 */
	public void insertAttachLink(Parameter param);
	
	/**
	 * 첨부파일 재등록
	 * @param param 첨부파일 pk
	 */
	public String insertAttach(Parameter param);
	
	/**
	 * 제외매장 재등록
	 * @param param 쿠폰pk
	 */
	public void reinsertStoreEx (Parameter param);
}
