package com.ubone.standard.stamp.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

public interface stampManageDAO {
	
	/**
	 * 스탬프 적립기준 조회
	 * @param param 기준정보
	 * @return 목록정보
	 */
	public DataList getStampStd(Parameter param);

	
	/**
	 * 상품 찾기 팝업 목록 조회
	 * @param param
	 * @return 목록 정보
	 */
	public DataList getProdList(Parameter param);
	
	/**
	 * 제품명 자동완성
	 * @param param 검색어
	 * @return 자동완성
	 */
	public DataList getMenuAutoComplete(Parameter param);
	
	/**
	 * 스탬프 기준관리 상품 유효성 확인
	 * @param param 상품id, 등급id, 적용일자
	 * @return 유효여부
	 */
	public DataList checkStampMenu(Parameter param);
	
	/**
	 * 스템프 기준관리 등록
	 * @param param 기준정보
	 */
	public String insertTbsStamp(Parameter param);
	
	/**
	 * 스탬프 적립기준 메뉴 등록
	 * @param param 메뉴정보
	 */
	public void insertStampRole(Parameter param);
	
	/**
	 * 스탬프 제외매장 등록
	 * @param param 매장정보
	 */
	public void insertStampExStore(Parameter param);
	
	/**
	 * 스탬프 적립채널 등록
	 * @param param 채널정보
	 */
	public void insertStampStnd(Parameter param);
	
	
	/**
	 * 스탬프 상세 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getTbsStamp (Parameter param);
	
	/**
	 * 스탬프 구입방법/채널 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getStampStnd (Parameter param);
	
	/**
	 * 스탬프 적립기준 메뉴 조회
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRole(Parameter param);
	
	/**
	 * 스탬프 변경이력 조회
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRecode(Parameter param);
	
	/**
	 * 스탬프 마스터 수정
	 * @param param 수정정보
	 */
	public void updateTbsStamp(Parameter param);
	
	/**
	 * 스탬프 적립채널 삭제
	 * @param param 스탬프pk
	 */
	public void deleteStampStnd(Parameter param);
	
	/**
	 * 스탬프 적립기준 메뉴 삭제
	 * @param param 스탬프pk
	 */
	public void deleteStampRole(Parameter param);
	
	/**
	 * 스탬프 제외매장 삭제
	 * @param param 스탬프pk
	 */
	public void deleteStampExStore(Parameter param);
	
	
	/**
	 * 스탬프 변경이력 마스터 등록
	 * @param param 스탬프 마스터 저옵
	 */
	public String insertTbsStampRecode(Parameter param);
	
	/**
	 * 스탬프 변경이력 등록
	 * @param param 스탬프pk
	 */
	public void insertStampRecode(Parameter param);
	
	/**
	 * 스탬프 이력 상세 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getTbsStampRecord (Parameter param);
	
	/**
	 * 스탬프 구입방법/채널 이력 조회
	 * @param param 스템프 pk
	 * @return 상세정보
	 */
	public DataList getStampStndRecord (Parameter param);
	
	/**
	 * 스탬프 적립기준 메뉴 조회
	 * @param param 스템프 pk
	 * @return 목록정보
	 */
	public DataList getStampRoleRecord(Parameter param);

	/**
	 * 스탬프 기준관리 삭제
	 * @param param 스탬프 pk
	 */
	public void deleteStamp (Parameter param);
	
	/**
	 * 적립혜택 쿠폰 등록
	 * @param param 쿠폰 정보
	 */
	public void insertStampReward(Parameter param);
	
	/**
	 * 기존 적립혜택 쿠폰 삭제
	 * @param param 
	 */
	public void deleteStampReward (Parameter param);
	
	/**
	 * 스탬프 리워드 쿠폰 목록 조회
	 * @return 목록 정보
	 */
	public DataList getStampReward ();
	
	/**
	 * 2019.05.23 강현준 추가
	 * @param param 3뎁스 메뉴코드
	 * @return 1,2단계 메뉴코드
	 */
	public DataList getUpMenuCode(Parameter param);
}
