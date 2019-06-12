package com.ubone.standard.cust.dao;

import com.ubone.framework.data.DataList;
import com.ubone.framework.data.Parameter;

/** 
 * <pre>
 *  파 일 명 : CustManageRimsDAO.java
 *  설    명 : RIMS 고객 조회 관련 DAO
 *  작 성 자 : 강현준
 *  작 성 일 : 2019.03.04
 *  버    전 : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 */

public interface CustManageRimsDAO {
	/**
	 * 회원상세 탭 - 주문이력 조회
	 * @param param
	 * @return
	 */
	public DataList getOrderListRims(Parameter param);
	
	/**
	 * 주문이력 팝업 상세조회
	 * @param param
	 * @return
	 */
	public DataList getOrderDetailRims(Parameter param);
	public DataList getProdListRims(Parameter param);
	public DataList getCouponListUseRims(Parameter param);
	
	/**
	 * 회원상세 탭 - 주문상품이력
	 * @param param
	 * @return
	 */
	public DataList getOrderProdRims(Parameter param);
	
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
	 * 차세대 오픈 스케줄 조회
	 * @param param
	 * @return
	 */
	public DataList getPosSchedule(Parameter param);
	
}
