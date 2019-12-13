package com.ubone.api.rest.stamp.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.stereotype.Service;

import com.ubone.api.rest.common.constant.ApiCommon;
import com.ubone.api.rest.common.constant.ApiConstantHolder;
import com.ubone.api.rest.stamp.dao.StampDAO;
import com.ubone.framework.data.DataList;
import com.ubone.framework.data.DataUtil;
import com.ubone.framework.data.Parameter;
import com.ubone.framework.data.Result;

/**
 * <pre>
 *  파 일 명  : StampSO.java
 *  설    명   : API 스템프 SO
 *  작 성 자  : 
 *  작 성 일  : 2018.11.01
 *  버    전   : 1.0
 *  수정이력 :
 *  기타사항 :
 * </pre>
 * 
 * @author Copyrights 2009 by ㈜ 유비원. All right reserved.
 */

@Service
public class StampSO {

	@Resource
	private ApiCommon apiCommon;

	@Resource
	private StampDAO stampDAO;
	
	
	/**
	 * 스템프적립가능여부 확인 - (KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result getStampExcept(Parameter parameter) throws Exception {
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 스템프 적립 가능매장 확인
		// 1-1. 이벤트 스템프 적립 가능매장 확인'
		boolean fgEventStamp = true;
		boolean fgDefaultStamp = true;
		
		Parameter eventExceptParam = DataUtil.makeParameter();
		eventExceptParam.setParameter("ID_STORE", parameter.getParameter("ID_STORE"));	// 매장ID
		eventExceptParam.setParameter("TP_SET", ApiConstantHolder.STAMP_EVENT);			// 설정구분
		
		DataList dtEventStore = stampDAO.getStampExcept(eventExceptParam);
		
		// 제외매장에 속하면 이벤트 flag 값을 false 로 변경
		if (0 < dtEventStore.getRowCount()) {
			fgEventStamp = false;
		}
		
		// 1-2. 기본 스템프 적립 가능매장 확인
		Parameter defaultExceptParam = DataUtil.makeParameter();
		defaultExceptParam.setParameter("ID_STORE", parameter.getParameter("ID_STORE"));	// 매장ID
		defaultExceptParam.setParameter("TP_SET", ApiConstantHolder.STAMP_DEFAULT);			// 설정구분
		
		DataList dtDefaultStore = stampDAO.getStampExcept(defaultExceptParam);
		
		// 제외매장에 속하면 이벤트 flag 값을 false 로 변경
		if (0 < dtDefaultStore.getRowCount()) {
			fgDefaultStamp = false;
		}
		
		// 1-3. 기본, 이벤트 설정 둘다 제외매장이면 return
		if (fgEventStamp && fgDefaultStamp) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_POSSIBLE);
			resultInfo.put("result_message", "적립이 가능합니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_STORE);
			resultInfo.put("result_message", "적립 제외 매장입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
	}
	
	/**
	 * 스템프적립 가능여부 확인 - (KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkSaveStamp(Parameter parameter) throws Exception {
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 0. 스템프 사용가능 정보 확인
		DataList dtUse = stampDAO.getStampUse(parameter);
		
		if (0 >= dtUse.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_STAMP);
			resultInfo.put("result_message", "적립가능한 스템프 정보가 없습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 1. 스템프 이벤트 적용여부 확인
		// 1-1. 회원등급 조회
		int cntStampIncre = 0;
		DataList dtGrede = stampDAO.getMemberGrade(parameter);
		String cdGrade = 0 < dtGrede.getRowCount() ? dtGrede.getString(0, "CD_GRADE") : "01";

		// 1-2. 상품, 등급, 기간에 해당하는 스템프이벤트 확인
		JSONArray productList = new JSONArray(parameter.getParameter("PRODUCT_LIST").toString());
		
		if (0 < productList.length()) {
			String fgEvent = "N";
			
			for (int i=0; i<productList.length(); i++) {
				JSONObject product = productList.getJSONObject(i);
				Parameter stampParam = DataUtil.makeParameter();
				stampParam.setParameter("CD_MTH_PURCHS", parameter.getParameter("CD_MTH_PURCHS"));		// 구매방법
				stampParam.setParameter("CD_ORDER_CHNN", parameter.getParameter("CD_ORDER_CHNN"));		// 주문채널
				stampParam.setParameter("ID_MENU", product.getString("product_pk"));					// 상품
				stampParam.setParameter("CNT_BUY", product.getString("cnt_buy"));						// 구매수량
				stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_EVENT);						// 설정구분
				stampParam.setParameter("CD_GRADE", cdGrade);					// 회원등급
				
				// 무료인 상품은 적립대상이 아님
				if (ApiConstantHolder.FLAG_N.equals(product.getString("fg_free"))) {
					DataList dtEventStamp = stampDAO.getCntStamp(stampParam);
					
					// 1-3. 이벤트 여부에 따른 분기처리
					if (0 < dtEventStamp.getRowCount()) {
						cntStampIncre += Integer.parseInt(dtEventStamp.getString(0, "CNT_STAMP"));
						fgEvent = "Y";	// 이벤트 설정에 포함되었을때 이벤트설정여부를 Y 로 변경한다.
					} else {
						// 1-4. 이벤트가 없으면 스템프적립 기본설정정보 조회
						stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_DEFAULT);					// 설정구분
						
						DataList dtDefaultStamp = stampDAO.getCntStamp(stampParam);
						
						if (0 < dtDefaultStamp.getRowCount()) {
							cntStampIncre += Integer.parseInt(dtDefaultStamp.getString(0, "CNT_STAMP"));
						}
					}
				}
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_PRODUCT);
			resultInfo.put("result_message", "적립관련 상품이 존재하지 않습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultData.put("stampCount", cntStampIncre);
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 조회되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultData", resultData));
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		return result;
	}
	
	/**
	 * 스템프적립 - (KIOSK)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertStampKiosk(Parameter parameter) throws Exception {
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 0. 스템프 사용가능 정보 확인
		DataList dtUse = stampDAO.getStampUse(parameter);
		
		if (0 >= dtUse.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_STAMP);
			resultInfo.put("result_message", "적립가능한 스템프 정보가 없습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 1. 스템프 이벤트 적용여부 확인
		// 1-1. 회원등급 조회
		DataList dtGrede = stampDAO.getMemberGrade(parameter);
		
		if (0 < dtGrede.getRowCount()) {
			parameter.setParameter("ID_MEMBER", dtGrede.getString(0, "ID_MEMBER"));
			// 1-2. 상품, 등급, 기간에 해당하는 스템프이벤트 확인
			JSONArray productList = new JSONArray(parameter.getParameter("PRODUCT_LIST").toString());
			
			if (0 < productList.length()) {
				int cntStampIncre = 0;
				String fgEvent = "N";
				
				for (int i=0; i<productList.length(); i++) {
					JSONObject product = productList.getJSONObject(i);
					Parameter stampParam = DataUtil.makeParameter();
					stampParam.setParameter("CD_MTH_PURCHS", parameter.getParameter("CD_MTH_PURCHS"));		// 구매방법
					stampParam.setParameter("CD_ORDER_CHNN", parameter.getParameter("CD_ORDER_CHNN"));		// 주문채널
					stampParam.setParameter("ID_MENU", product.getString("product_pk"));					// 상품
					stampParam.setParameter("CNT_BUY", product.getString("cnt_buy"));						// 구매수량
					stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_EVENT);						// 설정구분
					stampParam.setParameter("CD_GRADE", dtGrede.getString(0, "CD_GRADE"));					// 회원등급
					
					// 무료인 상품은 적립대상이 아님
					if (ApiConstantHolder.FLAG_N.equals(product.getString("fg_free"))) {
						DataList dtEventStamp = stampDAO.getCntStamp(stampParam);
						
						// 1-3. 이벤트 여부에 따른 분기처리
						if (0 < dtEventStamp.getRowCount()) {
							cntStampIncre += Integer.parseInt(dtEventStamp.getString(0, "CNT_STAMP"));
							fgEvent = "Y";	// 이벤트 설정에 포함되었을때 이벤트설정여부를 Y 로 변경한다.
						} else {
							// 1-4. 이벤트가 없으면 스템프적립 기본설정정보 조회
							stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_DEFAULT);					// 설정구분
							
							DataList dtDefaultStamp = stampDAO.getCntStamp(stampParam);
							
							if (0 < dtDefaultStamp.getRowCount()) {
								cntStampIncre += Integer.parseInt(dtDefaultStamp.getString(0, "CNT_STAMP"));
							}
						}
					}
				}
				
				// 1-5. 적립할 스템프가 있을시 스템프증가 및 이력처리
				if (0 == cntStampIncre) {
					resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_CONDITION);
					resultInfo.put("result_message", "스템프 적립 대상 조건에 맞지 않습니다.");
					result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
					result.addDataList(DataUtil.makeDataList("resultData", resultData));
					return result;
				} else {
					DataList dtChk = stampDAO.chkOrderStamp(parameter);
					
					if (0 < dtChk.getRowCount()) {
					} else {
						this.insertStampInfo(cntStampIncre, fgEvent, parameter);	// 스템프건수증가 및 히스토리 저장
					}
				}
			} else {
				resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_PRODUCT);
				resultInfo.put("result_message", "적립관련 상품이 존재하지 않습니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", resultData));
				return result;
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_MEMBER);
			resultInfo.put("result_message", "등록되지 않은 회원입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 등록되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 스템프정보 조회
		DataList dtRecord = stampDAO.getStampRecord(parameter);
		
		if (0 < dtRecord.getRowCount()) {
			resultData.put("id_member", dtRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
			resultData.put("cd_increment", dtRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
			resultData.put("cnt_stamp_incre", dtRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
			resultData.put("cnt_stamp_stack", dtRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
			resultData.put("cnt_stamp", dtRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
		}

		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}

	/**
	 * 스템프적립 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result insertStamp(Parameter parameter) throws Exception {
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 0. 스템프 사용가능 정보 확인
		DataList dtUse = stampDAO.getStampUse(parameter);
		
		if (0 >= dtUse.getRowCount()) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_STAMP);
			resultInfo.put("result_message", "적립가능한 스템프 정보가 없습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 1. 스템프 적립 가능매장 확인
		// 1-1. 이벤트 스템프 적립 가능매장 확인'
		boolean fgEventStamp = true;
		boolean fgDefaultStamp = true;
		
		Parameter eventExceptParam = DataUtil.makeParameter();
		eventExceptParam.setParameter("ID_STORE", parameter.getParameter("STOR_CD"));	// 매장ID
		eventExceptParam.setParameter("TP_SET", ApiConstantHolder.STAMP_EVENT);			// 설정구분
		
		DataList dtEventStore = stampDAO.getStampExcept(eventExceptParam);
		
		// 제외매장에 속하면 이벤트 flag 값을 false 로 변경
		if (0 < dtEventStore.getRowCount()) {
			fgEventStamp = false;
		}
		
		// 1-2. 기본 스템프 적립 가능매장 확인
		Parameter defaultExceptParam = DataUtil.makeParameter();
		defaultExceptParam.setParameter("ID_STORE", parameter.getParameter("STOR_CD"));	// 매장ID
		defaultExceptParam.setParameter("TP_SET", ApiConstantHolder.STAMP_DEFAULT);		// 설정구분
		
		DataList dtDefaultStore = stampDAO.getStampExcept(defaultExceptParam);
		
		// 제외매장에 속하면 이벤트 flag 값을 false 로 변경
		if (0 < dtDefaultStore.getRowCount()) {
			fgDefaultStamp = false;
		}
		
		// 1-3. 기본, 이벤트 설정 둘다 제외매장이면 return
		if (!fgEventStamp && !fgDefaultStamp) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_STORE);
			resultInfo.put("result_message", "적립 제외 매장입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 1. 스템프 이벤트 적용여부 확인
		// 1-1. 회원등급 조회
		DataList dtGrede = stampDAO.getMemberGrade(parameter);
		
		if (0 < dtGrede.getRowCount()) {
			// 1-2. 상품, 등급, 기간에 해당하는 스템프이벤트 확인
			JSONArray productList = new JSONArray(parameter.getParameter("PRODUCT_LIST").toString());
			
			if (0 < productList.length()) {
				int cntStampIncre = 0;
				String fgEvent = "N";
				
				for (int i=0; i<productList.length(); i++) {
					JSONObject product = productList.getJSONObject(i);
					Parameter stampParam = DataUtil.makeParameter();
					stampParam.setParameter("CD_MTH_PURCHS", parameter.getParameter("CD_MTH_PURCHS"));		// 구매방법
					stampParam.setParameter("CD_ORDER_CHNN", parameter.getParameter("CD_ORDER_CHNN"));		// 주문채널
					stampParam.setParameter("ID_MENU", product.getString("product_pk"));					// 상품
					stampParam.setParameter("CNT_BUY", product.getString("cnt_buy"));						// 구매수량
					stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_EVENT);						// 설정구분
					stampParam.setParameter("CD_GRADE", dtGrede.getString(0, "CD_GRADE"));					// 회원등급
					
					// 무료인 상품은 적립대상이 아님
					if (ApiConstantHolder.FLAG_N.equals(product.getString("fg_free"))) {
						DataList dtEventStamp = stampDAO.getCntStamp(stampParam);
						
						// 1-3. 이벤트 여부에 따른 분기처리
						if (0 < dtEventStamp.getRowCount()) {
							cntStampIncre += Integer.parseInt(dtEventStamp.getString(0, "CNT_STAMP"));
							fgEvent = "Y";	// 이벤트 설정에 포함되었을때 이벤트설정여부를 Y 로 변경한다.
						} else {
							// 1-4. 이벤트가 없으면 스템프적립 기본설정정보 조회
							stampParam.setParameter("TP_SET", ApiConstantHolder.STAMP_DEFAULT);					// 설정구분
							
							DataList dtDefaultStamp = stampDAO.getCntStamp(stampParam);
							
							if (0 < dtDefaultStamp.getRowCount()) {
								cntStampIncre += Integer.parseInt(dtDefaultStamp.getString(0, "CNT_STAMP"));
							}
						}
					}
				}
				
				// 1-5. 적립할 스템프가 있을시 스템프증가 및 이력처리
				if (0 == cntStampIncre) {
					resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_CONDITION);
					resultInfo.put("result_message", "스템프 적립 대상 조건에 맞지 않습니다.");
					result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
					result.addDataList(DataUtil.makeDataList("resultData", resultData));
					return result;
				} else {
					DataList dtChk = stampDAO.chkOrderStamp(parameter);
					
					if (0 < dtChk.getRowCount()) {
					} else {
						this.insertStampInfo(cntStampIncre, fgEvent, parameter);	// 스템프건수증가 및 히스토리 저장	
					}
				}
			} else {
				resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_PRODUCT);
				resultInfo.put("result_message", "적립관련 상품이 존재하지 않습니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
				result.addDataList(DataUtil.makeDataList("resultData", resultData));
				return result;
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_MEMBER);
			resultInfo.put("result_message", "등록되지 않은 회원입니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 등록되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 4. 스템프정보 조회
		DataList dtRecord = stampDAO.getStampRecord(parameter);
		
		if (0 < dtRecord.getRowCount()) {
			resultData.put("id_member", dtRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
			resultData.put("cd_increment", dtRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
			resultData.put("cnt_stamp_incre", dtRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
			resultData.put("cnt_stamp_stack", dtRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
			resultData.put("cnt_stamp", dtRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
		}

		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
	}
	
	/**
	 * 스템프건수증가 및 히스토리 저장
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	private void insertStampInfo(int cntStamp, String fgEvent, Parameter parameter) throws Exception {
		// 1. 회원 스템프 증가
		Parameter stampParam = DataUtil.makeParameter();
		stampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));		// 회원PK
		stampParam.setParameter("CNT_STAMP", cntStamp);		// 증가스템프개수
		
		stampDAO.updateMemberStampPlus(stampParam);
		
		// 2. 회원 기존 스탬프 이력 조회 - 누적스템프 계산용도
		int cntStampStack = 0;
		DataList dtRocord = stampDAO.getStampRecord(parameter);
		
		if (0 < dtRocord.getRowCount()) {
			cntStampStack = Integer.parseInt(dtRocord.getString(0, "CNT_STAMP_STACK"));
		}
		
		// 3. 회원의 기존 스템프 이력 수정
		stampDAO.updateStampRecord(parameter);
		
		// 4. 회원 스템프 이력 저장
		Parameter recodeParam = DataUtil.makeParameter();
		recodeParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));			// 회원PK
		recodeParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));			// 주문번호
		recodeParam.setParameter("STOR_CD", parameter.getParameter("STOR_CD"));				// 주문번호
		recodeParam.setParameter("CD_INCREMENT", ApiConstantHolder.CD_INCREMENT_PLUS);		// 증가/차감코드
		recodeParam.setParameter("TP_INCREMENT", ApiConstantHolder.TP_INCREMENT_PLUS_MENU);	// 증가/차감구분 
		recodeParam.setParameter("FG_EVENT", fgEvent);										// 이벤트여부
		recodeParam.setParameter("CNT_STAMP_INCRE", cntStamp);								// 증가/차감스탬프갯수
		recodeParam.setParameter("CNT_STAMP_STACK", (cntStampStack + cntStamp));			// 누적스탬프갯수
		
		stampDAO.insertStampRecord(recodeParam); 
		
		// 5. 스템프 리워드 전환
		//5-1. 회원 스템프 갯수 조회
		int cntFive = 0;
		int cntTen = 0;
		
		DataList dtMemberStamp = stampDAO.getMemberGrade(parameter);
		
		if (0 < dtMemberStamp.getRowCount()) {
			// 지금까지 지급했어야 하는 5/10 쿠폰수
			cntFive = Integer.parseInt(dtMemberStamp.getString(0, "FIVE_COUPON")) - Integer.parseInt(dtMemberStamp.getString(0, "TEN_COUPON"));
			cntTen = Integer.parseInt(dtMemberStamp.getString(0, "TEN_COUPON"));
		}
		
		// 5-2. 발행된 리워드 쿠폰 갯수 조회
		DataList dtMemberReward = stampDAO.getMemberRewardCnt(parameter);
		
		// 6. 기발급된 리워트 쿠폰에 따른 분기 처리
		if (0 < dtMemberReward.getRowCount()) {
			// 6-1. 기발급된 건이 있을때 지급까지 발급했어야하는 쿠폰수와 기발급된 발급건을 바교한다.
			for (int i=0; i<dtMemberReward.getRowCount(); i++) {
				String tpReward = dtMemberReward.getString(i, "TP_REWARD");		// 리워드구분 - 01:5개, 02:10개
				int cnt = Integer.parseInt(dtMemberReward.getString(i, "CNT"));	// 리워드받은 쿠폰수
				
				// 6-2. 비교
				if (ApiConstantHolder.TP_REWARD_FIVE.equals(tpReward)) {	// 5개
					// 지금까지 지급해야하는 리워드쿠폰수 - 지금까지 지급한 리워드쿠폰수
					for (int j=0; j<(cntFive - cnt); j++) {
						Parameter fiveStampParam = DataUtil.makeParameter();
						fiveStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
						fiveStampParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));	// 주문번호
						fiveStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_FIVE);		// 리워드구분
						
						stampDAO.insertMemberstampReward(fiveStampParam);
					}
				} else if (ApiConstantHolder.TP_REWARD_TNE.equals(tpReward)) {	// 10개
					// 지금까지 지급해야하는 리워드쿠폰수 - 지금까지 지급한 리워드쿠폰수
					for (int j=0; j<(cntTen - cnt); j++) {
						Parameter tenStampParam = DataUtil.makeParameter();
						tenStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
						tenStampParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));		// 주문번호
						tenStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_TNE);		// 리워드구분
						
						stampDAO.insertMemberstampReward(tenStampParam);
					}
				}
			}
		}
//		else {
//			// 5-3. 적립된 리워드쿠폰이 없을때 지급해야하는 5개의 Reword 쿠폰 등록
//			for (int i=0; i<cntFive; i++) {
//				Parameter fiveStampParam = DataUtil.makeParameter();
//				fiveStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
//				fiveStampParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));	// 주문번호
//				fiveStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_FIVE);		// 리워드구분
//				
//				stampDAO.insertMemberstampReward(fiveStampParam);
//			}
//			
//			// 5-4. 적립된 리워드쿠폰이 없을때 지급해야하는 10개의 Reword 쿠폰 등록
//			for (int i=0; i<cntTen; i++) {
//				Parameter tenStampParam = DataUtil.makeParameter();
//				tenStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
//				tenStampParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));		// 주문번호
//				tenStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_TNE);		// 리워드구분
//				
//				stampDAO.insertMemberstampReward(tenStampParam);
//			}
//		}
	}
	
	/**
	 * 스템프차감 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result checkStamp(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String fgReward = "N";		// 적립리워드 여부
		
		// 1. 스템프 존재여부 확인
		DataList dtAfter = stampDAO.getStampAfterRecord(parameter);
		
		// 1-1. 데이터 존재여부 확인
		if (0 < dtAfter.getRowCount()) {			
			
			// 2. 리워드쿠폰 존재여부 및 사용여부 확인
			for (int i=0; i<dtAfter.getRowCount(); i++) {
				Parameter param = DataUtil.makeParameter();
				param.setParameter("ID_MEMBER", dtAfter.getString(i, "ID_MEMBER"));
				param.setParameter("ORDER_NO", dtAfter.getString(i, "ORDER_NO"));
				
				DataList dtReward = stampDAO.getUseRewardCoupon(param);
				
				if (0 < dtReward.getRowCount()) {
					// 2-1. 사용여부 확인
					if (!ApiConstantHolder.DAU_STATUS_NONE.equals(dtReward.getString(0, "FG_USE"))) {
						fgReward = "Y";
						break;
					}
				}
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_SAVE_STANP);
			resultInfo.put("result_message", "적립된 스템프가 없습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 3. 쿠폰 사용여부에 따른 return 처리
		if (ApiConstantHolder.FLAG_Y.equals(fgReward)) {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_CANCEL);
			resultInfo.put("result_message", "주문취소가 불가능합니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_CANCEL);
			resultInfo.put("result_message", "주문취소가 가능합니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
	}
		
	/**
	 * 스템프차감 - (Web & APP)
	 * @param HTTP 요청 파라미터  
	 * @return 
	 */
	public Result deleteStamp(Parameter parameter) throws Exception {
		
		Result result = DataUtil.makeResult();
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		// 1. 회원주문이력 존재여부 확인
		DataList dtRecord = stampDAO.getStampOrderRecord(parameter);
		
		if (0 < dtRecord.getRowCount()) {
			// 1-1. 기취소여부 확인
			for (int k=0; k<dtRecord.getRowCount(); k++) {
				if (ApiConstantHolder.CD_INCREMENT_MINUS.equals(dtRecord.getString(k, "CD_INCREMENT"))) {
					resultInfo.put("result_code", ApiConstantHolder.STAMP_CANCEL);
					resultInfo.put("result_message", "이미 취소된 주문입니다.");
					result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
					
					// 스템프정보 조회
					DataList dtErrorRecord = stampDAO.getStampRecord(parameter);
					
					// return 설정
					if (0 < dtErrorRecord.getRowCount()) {
						resultData.put("id_member", dtErrorRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
						resultData.put("cd_increment", dtErrorRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
						resultData.put("cnt_stamp_incre", dtErrorRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
						resultData.put("cnt_stamp_stack", dtErrorRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
						resultData.put("cnt_stamp", dtErrorRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
					}

					result.addDataList(DataUtil.makeDataList("resultData", resultData));
					return result;
				}
			}

			String fgReward = "N";		// 적립리워드 여부
			
			// 1-1. 스템프 리워드 쿠폰 사용여부 확인
			DataList dtReward = stampDAO.getUseRewardCoupon(parameter);
			
			// 1-2. 데이터 존재여부 확인
			if (0 < dtReward.getRowCount()) {
				for (int j=0; j<dtReward.getRowCount(); j++) {
					// 2-1. 사용여부 확인
					if (!ApiConstantHolder.DAU_STATUS_NONE.equals(dtReward.getString(j, "FG_USE"))) {
						fgReward = "Y";
						break;
					}
				}
			}
			
			// 2. 쿠폰 사용여부에 따른 처리
			if (ApiConstantHolder.FLAG_N.equals(fgReward)) {
				// 2-1. 회원 스템프 감소
				Parameter stampParam = DataUtil.makeParameter();
				stampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));		// 회원PK
				stampParam.setParameter("CNT_STAMP", dtRecord.getString(0, "CNT_STAMP_INCRE"));	// 주문에서 적립된 스템프 개수 - 차감용도
				
				stampDAO.updateMemberStampMinus(stampParam);
				
				// 3. 회원의 기존 스템프 이력 수정
				stampDAO.updateStampRecord(parameter);
				
				// 3-1. 회원 스템프 이력 저장
				Parameter recodeParam = DataUtil.makeParameter();
				recodeParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));				// 회원PK
				recodeParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));				// 주문번호
				recodeParam.setParameter("STOR_CD", dtRecord.getString(0, "STOR_CD"));					// 주문매장
				recodeParam.setParameter("CD_INCREMENT", ApiConstantHolder.CD_INCREMENT_MINUS);			// 증가/차감코드
				recodeParam.setParameter("TP_INCREMENT", ApiConstantHolder.TP_INCREMENT_MINUS_ORDER);	// 증가/차감구분 
				recodeParam.setParameter("FG_EVENT", dtRecord.getString(0, "FG_EVENT"));				// 이벤트여부
				int cntStampIncre = Integer.parseInt(dtRecord.getString(0, "CNT_STAMP_INCRE"));
				int cntStampStack = Integer.parseInt(dtRecord.getString(0, "CNT_STAMP"));
				recodeParam.setParameter("CNT_STAMP_INCRE", cntStampIncre);								// 증가/차감스탬프갯수
				recodeParam.setParameter("CNT_STAMP_STACK", (cntStampStack - cntStampIncre));			// 누적스탬프갯수
				
				stampDAO.insertStampRecord(recodeParam);
				
				// 4. 회원 스템프 갯수 조회
				int cntFive = 0;
				int cntTen = 0;
				int cntRewardFive = 0;
				int cntRewardTen = 0;
				
				DataList dtMemberStamp = stampDAO.getMemberGrade(parameter);
				
				if (0 < dtMemberStamp.getRowCount()) {
					// 지금까지 지급했어야 하는 5/10 쿠폰수
					cntFive = Integer.parseInt(dtMemberStamp.getString(0, "FIVE_COUPON")) - Integer.parseInt(dtMemberStamp.getString(0, "TEN_COUPON"));
					cntTen = Integer.parseInt(dtMemberStamp.getString(0, "TEN_COUPON"));
				}
				
				// 5. 리워드 갯수 확인
				DataList dtMemberReward = stampDAO.getMemberRewardCnt(parameter);
				
				if (0 < dtMemberReward.getRowCount()) {
					for (int i=0; i<dtMemberReward.getRowCount(); i++) {
						String tpReward = dtMemberReward.getString(i, "TP_REWARD");		// 리워드구분 - 01:5개, 02:10개
						
						if (ApiConstantHolder.TP_REWARD_FIVE.equals(tpReward)) {	// 5개
							cntRewardFive = Integer.parseInt(dtMemberReward.getString(i, "CNT"));	// 리워드받은 쿠폰수
						} else if (ApiConstantHolder.TP_REWARD_TNE.equals(tpReward)) {	// 10개
							cntRewardTen = Integer.parseInt(dtMemberReward.getString(i, "CNT"));	// 리워드받은 쿠폰수
						}
					}
				}
				
				// 6. 회원에게 발급되었어야 하는 리워드 갯수 확인 및 리워드 쿠폰 삭제
				if (cntFive != cntRewardFive) {
					Parameter fiveStampParam = DataUtil.makeParameter();
					fiveStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
					fiveStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_FIVE);		// 리워드구분

					for (int j=0; j<(cntRewardFive - cntFive); j++) {
						// 6-1. 삭제대상 조회 - 제일 나중에 적립된 리워드 쿠폰
						DataList dtLast = stampDAO.getRewardMax(fiveStampParam);
						
						if (0 < dtLast.getRowCount()) {
							// 6-2. 리워드 삭제
							fiveStampParam.setParameter("NO_MEMBER_STAMP_REWARD", dtLast.getString(0, "NO_MEMBER_STAMP_REWARD"));
							stampDAO.deleteMemberReward(fiveStampParam);
							
							// 6-3. 쿠폰 수정
							stampDAO.updateRewardCoupon(fiveStampParam);
						}
					}
				}
				
				if (cntTen != cntRewardTen) {
					Parameter tenStampParam = DataUtil.makeParameter();
					tenStampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));	// 회원PK
					tenStampParam.setParameter("TP_REWARD", ApiConstantHolder.TP_REWARD_TNE);		// 리워드구분
					
					for (int j=0; j<(cntRewardTen - cntTen); j++) {
						
						// 6-1. 삭제대상 조회 - 제일 나중에 적립된 리워드 쿠폰
						DataList dtLast = stampDAO.getRewardMax(tenStampParam);
						
						if (0 < dtLast.getRowCount()) {
							// 6-2. 리워드 삭제
							tenStampParam.setParameter("NO_MEMBER_STAMP_REWARD", dtLast.getString(0, "NO_MEMBER_STAMP_REWARD"));
							stampDAO.deleteMemberReward(tenStampParam);
							
							// 6-3. 쿠폰 수정
							stampDAO.updateRewardCoupon(tenStampParam);
						}
					}
				}
			} else {
				resultInfo.put("result_code", ApiConstantHolder.STAMP_CANCEL);
				resultInfo.put("result_message", "리워드 쿠폰을 사용했습니다.");
				result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));

				// 스템프정보 조회
				DataList dtErrorRecord = stampDAO.getStampRecord(parameter);
				
				// return 설정
				if (0 < dtErrorRecord.getRowCount()) {
					resultData.put("id_member", dtErrorRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
					resultData.put("cd_increment", dtErrorRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
					resultData.put("cnt_stamp_incre", dtErrorRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
					resultData.put("cnt_stamp_stack", dtErrorRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
					resultData.put("cnt_stamp", dtErrorRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
				}

				result.addDataList(DataUtil.makeDataList("resultData", resultData));
				return result;
			}
		} else {
			resultInfo.put("result_code", ApiConstantHolder.STAMP_CANCEL);
			resultInfo.put("result_message", "적립된 스템프가 존재하지 않습니다.");
			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
			
			// 스템프정보 조회
			DataList dtErrorRecord = stampDAO.getStampRecord(parameter);
			
			// return 설정
			if (0 < dtErrorRecord.getRowCount()) {
				resultData.put("id_member", dtErrorRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
				resultData.put("cd_increment", dtErrorRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
				resultData.put("cnt_stamp_incre", dtErrorRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
				resultData.put("cnt_stamp_stack", dtErrorRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
				resultData.put("cnt_stamp", dtErrorRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
			}

			result.addDataList(DataUtil.makeDataList("resultData", resultData));
			return result;
		}
		
		// 6. 정상처리
		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
		resultInfo.put("result_message", "정상적으로 처리되었습니다.");
		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
		
		// 7. 스템프정보 조회
		DataList dtRetuenRecord = stampDAO.getStampRecord(parameter);
		
		// 8. return 설정
		if (0 < dtRetuenRecord.getRowCount()) {
			resultData.put("id_member", dtRetuenRecord.getString(0, "ID_MEMBER"));				/* 회원PK */	
			resultData.put("cd_increment", dtRetuenRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
			resultData.put("cnt_stamp_incre", dtRetuenRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
			resultData.put("cnt_stamp_stack", dtRetuenRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
			resultData.put("cnt_stamp", dtRetuenRecord.getString(0, "CNT_STAMP"));				/* 스템프개수 */
		}

		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
		result.addDataList(dtResultData);
		
		return result;
		
//		// 1. 회원주문이력 존재여부 확인
//		DataList dtRecord = stampDAO.getStampOrderRecord(parameter);
//		
//		if (0 < dtRecord.getRowCount()) {
//			// 1-1. 회원 스템프 감소
//			Parameter stampParam = DataUtil.makeParameter();
//			stampParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));		// 회원PK
//			stampParam.setParameter("CNT_STAMP", dtRecord.getString(0, "CNT_STAMP_INCRE"));	// 주문에서 적립된 스템프 개수 - 차감용도
//			
//			stampDAO.updateMemberStampMinus(stampParam);
//			
//			// 1-2. 회원의 기존 스템프 이력 수정
//			stampDAO.updateStampRecord(parameter);
//			
//			// 1-3. 회원 스템프 이력 저장
//			Parameter recodeParam = DataUtil.makeParameter();
//			recodeParam.setParameter("ID_MEMBER", parameter.getParameter("ID_MEMBER"));				// 회원PK
//			recodeParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));				// 주문번호
//			recodeParam.setParameter("STOR_CD", dtRecord.getString(0, "STOR_CD"));					// 주문매장
//			recodeParam.setParameter("CD_INCREMENT", ApiConstantHolder.CD_INCREMENT_MINUS);			// 증가/차감코드
//			recodeParam.setParameter("TP_INCREMENT", ApiConstantHolder.TP_INCREMENT_MINUS_ORDER);	// 증가/차감구분 
//			recodeParam.setParameter("FG_EVENT", dtRecord.getString(0, "FG_EVENT"));				// 이벤트여부
//			int cntStampIncre = Integer.parseInt(dtRecord.getString(0, "CNT_STAMP_INCRE"));
//			int cntStampStack = Integer.parseInt(dtRecord.getString(0, "CNT_STAMP_STACK"));
//			recodeParam.setParameter("CNT_STAMP_INCRE", cntStampIncre);								// 증가/차감스탬프갯수
//			recodeParam.setParameter("CNT_STAMP_STACK", (cntStampStack - cntStampIncre));			// 누적스탬프갯수
//			
//			stampDAO.insertStampRecord(recodeParam);
//			
//			// 1-4. 쿠폰 리워드에 데이터가 있는지 확인
//			Parameter rewardOrderParam = DataUtil.makeParameter();
//			rewardOrderParam.setParameter("ORDER_NO", parameter.getParameter("ORDER_NO"));
//			
//			DataList dtMemberRewardOrder = stampDAO.getMemberRewardOrder(rewardOrderParam);
//			
//			// 취소요청된 주문번호로 발급예정인 쿠폰을 존재하면 삭제한다.
//			if (0 < dtMemberRewardOrder.getRowCount()) {
//				stampDAO.deleteMemberReward(rewardOrderParam);
//			}
//		} else {
//			resultInfo.put("result_code", ApiConstantHolder.STAMP_NONE_PRODUCT);
//			resultInfo.put("result_message", "주문정보가 존재하지 않습니다.");
//			result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
//			result.addDataList(DataUtil.makeDataList("resultData", resultData));
//			return result;
//		}
//		
//		// 3. 정상처리
//		resultInfo.put("result_code", ApiConstantHolder.RESULT_INSERT_SUCCESS);
//		resultInfo.put("result_message", "정상적으로 등록되었습니다.");
//		result.addDataList(DataUtil.makeDataList("resultInfo", resultInfo));
//		
//		// 4. return 설정
//		if (0 < dtRecord.getRowCount()) {
//			resultData.put("id_member", dtRecord.getString(0, "ID_MEMBER"));				/* 회원PK */
//			resultData.put("cd_increment", dtRecord.getString(0, "CD_INCREMENT"));			/* 증가/차감코드 */
//			resultData.put("cnt_stamp_incre", dtRecord.getString(0, "CNT_STAMP_INCRE"));	/* 증/차감스템프개수 */
//			resultData.put("cnt_stamp_stack", dtRecord.getString(0, "CNT_STAMP_STACK"));	/* 누적스탬프갯수 */
//			resultData.put("cnt_stamp", dtRecord.getString(0, "ID_MEMBER"));				/* 스템프개수 */
//		}
//
//		DataList dtResultData = DataUtil.makeDataList("resultData", resultData);
//		result.addDataList(dtResultData);
//		
//		return result;
	}

}
