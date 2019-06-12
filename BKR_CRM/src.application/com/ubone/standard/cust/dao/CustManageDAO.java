package com.ubone.standard.cust.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : CustomerDAO.java
 *  설    명 : 고객 조회 관련 DAO
 *  작 성 자 : 강현준
 *  작 성 일 : 2018.06.21
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */

public interface CustManageDAO {
	
	/**
	 * 고객 목록 조회
	 * @param param 검색조건
	 * @return 고객목록
	 */
	public DataList getCustList(Parameter param);
	
	/**
	 * 고객 상세조회
	 * @param param 고객 ID_MEMBER
	 * @return 상세정보
	 */
	public DataList getCustDetail(Parameter param);
	
	/**
	 * 고객 회원탈퇴 처리
	 * @param param 고객 ID_MEMBER
	 * @return 성공여부
	 */
	public String insertDelMember(Parameter param);
	public int deleteMember(Parameter param);
	public int deletelMemberAddr(Parameter param);
	public int deletelSnsMember(Parameter param);
	
	/**
	 * 고객 비밀번호 초기화
	 * @param param 고객 ID_MEMBER
	 * @return 성공여부
	 */
	public int resetPasswd(Parameter param);
	
	
	/**
	 * 회원상세 탭 - 변경이력
	 * @param param 
	 * @return 
	 */
	public DataList getCustLogChange(Parameter param);
	
	/**
	 * 회원상세 탭 - 스탬프 이력
	 * @param param
	 * @return
	 */
	public DataList getCustLogStamp(Parameter param);
	
	/**
	 * 회원상세 탭 - 선물함 이력
	 * @param param
	 * @return
	 */
	public DataList getSendGift(Parameter param);
	public DataList getRecvGift(Parameter param);
	
	/**
	 * 회원상세 탭 - 주문이력 조회
	 * @param param
	 * @return
	 */
	public DataList getOrderList(Parameter param);
	
	/**
	 * 주문이력 팝업 상세조회
	 * @param param
	 * @return
	 */
	public DataList getOrderDetail(Parameter param);
	public DataList getProdList(Parameter param);
	public DataList getOptionList(Parameter param);
	public DataList getCouponListUse(Parameter param);
	
	public DataList getCouponInfo(Parameter param);
	
	/**
	 * 회원상세 탭 - 주문상품이력
	 * @param param
	 * @return
	 */
	public DataList getOrderProd(Parameter param);
	
	/**
	 * 회원상세 탭 - 주문매장이력 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getOrderStore(Parameter param);

	/**
	 * 회원상세 탭 - 구배방법 이력 목록 조회
	 * @param param
	 * @return
	 */
	public DataList getPaymentList(Parameter param);
	
	/**
	 * 회원상세 탭 - 구매채널 이력
	 * @param param 회원코드
	 * @return
	 */
	public DataList getPayChannel(Parameter param);
	
	/**
	 * 주문 목록 팝업 조회
	 * @param param 회원pk, 검색조건
	 * @return 목록정보
	 */
	public DataList getOrderListPopup(Parameter param);
	
	/**
	 * 회원상세 탭 - 보유쿠폰 목록
	 * @param param 회원코드
	 * @return 목록정보
	 */
	public DataList getHaveCouponList (Parameter param);
	
	/**
	 * 쿠폰 사용이력 목록
	 * @param param 멤버id
	 * @return 목록정보
	 */
	public DataList getUseCouponList (Parameter param);
	
	/**
	 * 회원상세 탭 - 버거킹머니 이력조회
	 * @param param
	 * @return
	 */
	public DataList getMoneyList(Parameter param);
	
	/**
	 * SNS 연동 리스트
	 * @param param 고객정보
	 * @return sns 리스트
	 */
	public DataList getSnsList(Parameter param);
	
	
	
	
	
	
	/**
	 * 고객 등급목록 조회
	 * @return 목록 정보
	 */
	public DataList getGradeList();
	
	/**
	 * 고객 등급 상세조회
	 * @param param 등급코드
	 * @return 등급상세
	 */
	public DataList getGradeDetail(Parameter param);
	
	/**
	 * 등급 신규등록
	 * @param param 등급상세정보
	 */
	public void insertGrade(Parameter param);
	
	/**
	 * 등급 상세 수정
	 * @param param 등급 상세정보
	 * @return
	 */
	public int updateGradeDetail(Parameter param);
	
	/**
	 * 등급 삭제 처리
	 * @param param 등급코드
	 */
	public void deleteGrade(Parameter param);
	
	/**
	 * 하향기준 조회
	 * @return
	 */
	public DataList getDownStd();
	
	/**
	 * 하향기준 신규추가
	 * @param param
	 */
	public void insertDownStd (Parameter param);
	
	/**
	 * 기존의 하향기준 삭제
	 */
	public void deleteDownStd();
	
	
	/**
	 * 전체 쿠폰 목록 조회
	 * @param param
	 * @return 목록 정보
	 */
	public DataList getCouponList(Parameter param);
	

	/**
	 * 선불카드 목록 조회
	 * @param param id_member
	 * @return 목록정보
	 */
	public DataList getCardList(Parameter param);
	
	
	/**
	 * 최종 스탬프 누적값 조회
	 * @param param 멤버id
	 * @return 누적값
	 */
	public DataList getStampCntLast(Parameter param);
	
	/**
	 * 스탬프 이력 추가
	 * @param param
	 */
	public void addStampRecord(Parameter param);
	
	/**
	 * 회원 스탬프 개수 업데이트
	 * @param param
	 */
	public void updateStampMember(Parameter param);
	
	/**
	 * 회원 스템프 리워드 저장
	 * @param param 회원 PK
	 */
	public void addStampReward(Parameter param);
	
	/**
	 * 회원 스템프 개수 조회
	 * @param param 회원 PK
	 * @return 스템프 개수
	 */
	public DataList getCountStamp (Parameter param);
	
	/**
	 * 발급된 회원 리워드쿠폰 조회
	 * @param param 회원 PK
	 * @return 리워드쿠폰 개수
	 */
	public DataList getCountReward (Parameter param);
	
}
